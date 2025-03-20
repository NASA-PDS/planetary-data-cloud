# Terraform script to setup the PDS S3 Data Tagger

data "archive_file" "pds_s3_data_tagger_function_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/pds-s3-data-tagger.py"
  output_path = "${path.module}/lambda/pds-s3-data-tagger.zip"
}

resource "aws_lambda_function" "pds_s3_data_tagger_function" {
  function_name    = var.pds_s3_data_tagger_function_name
  description      = "PDS S3 Data Tagger Function"
  filename         = data.archive_file.pds_s3_data_tagger_function_zip.output_path
  source_code_hash = data.archive_file.pds_s3_data_tagger_function_zip.output_base64sha256
  role             = var.pds_s3_data_tagger_role_arn
  runtime          = "python3.12"
  handler          = "pds-s3-data-tagger.lambda_handler"
  timeout          = 10
  depends_on       = [data.archive_file.pds_s3_data_tagger_function_zip]

}

# Create CloudWatch Log Group for pds_s3_data_tagger_function
resource "aws_cloudwatch_log_group" "pds_s3_data_tagger_function_log_group" {
  name = "/aws/lambda/${var.pds_s3_data_tagger_function_name}"
}

##########################################################################################################################
#
# The following S3 metadata bucket, S3 bucket datasource and the aws_s3_bucket_replication_configuration is commented out,
# because the the S3 Batch process manifest file is already available.
# This configuration can be used when generating a new manifest file.
#
###########################################################################################################################

# resource "aws_s3_bucket" "pds_s3_data_tagger_metadata" {
#   bucket = var.pds_s3_data_tagger_metadata_bucket
# }
#
# resource "aws_s3_bucket_versioning" "pds_s3_data_tagger_metadata_versioning" {
#   bucket = aws_s3_bucket.pds_s3_data_tagger_metadata.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# data "aws_s3_bucket" "pds_s3_data_tagger_source_bucket" {
#   bucket = var.s3_bucket_name_to_be_tagged
# }

# resource "aws_s3_bucket_replication_configuration" "pds_s3_data_tagger_metadata_bucket_replication_configuration" {
#
#   role   = var.pds_s3_data_tagger_role_arn
#   bucket = data.aws_s3_bucket.pds_s3_data_tagger_source_bucket.id
#
#   rule {
#
#     filter {
#     }
#
#     id = "pds-s3-bucket-replication-rule"
#
#     status = "Enabled"
#
#     delete_marker_replication {
#       status = "Disabled"
#     }
#
#     source_selection_criteria {}
#     destination {
#       bucket        = aws_s3_bucket.pds_s3_data_tagger_metadata.arn
#     }
#   }
#
#   depends_on = [aws_s3_bucket_versioning.pds_s3_data_tagger_metadata_versioning]
# }
