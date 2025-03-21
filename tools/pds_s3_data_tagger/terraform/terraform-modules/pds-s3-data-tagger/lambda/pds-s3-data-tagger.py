# This lambda function is called by an S3 batch operation event and
# it sets s3 object_type tag for a given S3 object based on the file type

import json
import boto3
import re
import logging

logger = logging.getLogger("pds-s3-data-tagger")
logger.setLevel(logging.DEBUG)
logger.addHandler(logging.StreamHandler())


def lambda_handler(event, context):

    invocation_id = event["invocationId"]
    invocation_schema_version = event["invocationSchemaVersion"]
    results = []
    result_code = None
    result_string = None

    task = event["tasks"][0]
    task_id = task["taskId"]

    s3_client = boto3.client('s3')
    s3_bucket_arn = event['tasks'][0].get("s3BucketArn")
    s3_bucket = get_bucket_name_from_arn(s3_bucket_arn)
    s3_key = event['tasks'][0].get("s3Key")

    try:

        """ Sets s3 object_type tag based on the file type """

        pds_object_type_tag_value = 'data'

        # Set pds_object_type_tag_value based on PDS file type
        if s3_key.lower().endswith('.xml'):
            pds_object_type_tag_value = 'label'
        elif s3_key.lower().endswith('.csv'):
            pds_object_type_tag_value = 'inventory'
        else:
            pds_object_type_tag_value = 'data'

        response = s3_client.put_object_tagging(
            Bucket=s3_bucket,
            Key=s3_key,
            Tagging={
                'TagSet': [
                    {
                        'Key': 'pds_object_type',
                        'Value': pds_object_type_tag_value,
                    }
                ],
            },
        )

        success_message = f"Set pds_object_type tag to {pds_object_type_tag_value} for s3_key: {s3_key} in s3_bucket: {s3_bucket}'"
        logger.debug(f"Response: {response}")
        logger.debug(success_message)

        result_code = "Succeeded"
        result_string = (
            success_message
        )

    except Exception as error:
        result_code = "PermanentFailure"
        result_string = str(error)
        logger.exception(error)
    finally:
        results.append(
            {
                "taskId": task_id,
                "resultCode": result_code,
                "resultString": result_string,
            }
        )

    return {
        "invocationSchemaVersion": invocation_schema_version,
        "treatMissingKeysAs": "PermanentFailure",
        "invocationId": invocation_id,
        "results": results,
    }


def get_bucket_name_from_arn(arn):
    """ Extracts bucket name from S3 ARN """

    # Check if the ARN is None or empty
    if not arn:
        return None

    # Regular expression to match common S3 ARN pattern
    bucket_pattern = r"arn:aws:s3:::([a-z0-9.-]+)"

    match = re.search(bucket_pattern, arn)
    if match:
        return match.group(1)

    return None
