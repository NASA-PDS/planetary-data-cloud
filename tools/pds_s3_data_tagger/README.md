# PDS S3 Data Tagger Lambda function

PDS S3 Data Tagger lambda function can be used with an S3 Batch Operation to go through all the objects in a S3 bucket and then 
apply a Tag called `pds_object_type` based on the file type, such as `.xml`, `.csv` and other data files.


## Prerequisites to Deploy PDS S3 Data Tagger Lambda Function

- Terraform to be installed in the deployment execution environment (This was tested with Terraform v1.5.7. Any higher version should also work)

## Deployment Steps

1. Checkout the [PDS planetary-data-cloud](https://github.com/NASA-PDS/planetary-data-cloud) repository.

```shell
git clone https://github.com/NASA-PDS/planetary-data-cloud.git
```

2. Open the `planetary-data-cloud/tools/pds_s3_data_tagger/terraform/terraform.tfvars` file and 
set the following variables with actual values.

```shell

# AWS Region
region                                = "us-west-2"

# Permission boundary to be used when creating IAM roles
permission_boundary_for_iam_roles_arn = "arn:aws:iam::***********:policy/mcp-*************"

# The name of the S3 bucket which has the objects to be tagged
s3_bucket_name_to_be_tagged           = "pds-***********"

```

3. Change current directory to `planetary-data-cloud/tools/pds_s3_data_tagger/terraform`

```shell
cd planetary-data-cloud/tools/pds_s3_data_tagger/terraform
```

4. Set the following environment variables with correct values in terminal window using export command.

```shell
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_SESSION_TOKEN=
```


5. Initialize terraform (in  planetary-data-cloud/tools/pds_s3_data_tagger/terraform).

```shell
terraform init
```


6. Check  terraform plan.

```shell
terraform plan
```

7. Apply the terraform changes.

```shell
terraform apply
```

This will create,
 - Lambda function called `pds_s3_data_tagger`
 - IAM role called `pds_s3_data_tagger_role`


## Using the pds_s3_data_tagger Lambda Function with S3 Batch Operations

You can use the Lambda function `pds_s3_data_tagger`, which was created above, with an S3 Batch Operation as explained bellow.

[Invoke a Lambda function with Amazon S3 batch events](https://docs.aws.amazon.com/lambda/latest/dg/services-s3-batch.html)

Instead of creating a new IAM role for above S3 batch process, it is possible to reuse the IAM role called `pds_s3_data_tagger_role` created above.

