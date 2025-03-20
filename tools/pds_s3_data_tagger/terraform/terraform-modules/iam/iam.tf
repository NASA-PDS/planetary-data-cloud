# Terraform script to create a IAM roles to be used in pds-s3-data-tagger


data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy" "mcp_operator_policy" {
  arn = var.permission_boundary_for_iam_roles_arn
}

############################################################
#
# IAM Roles and policies used by pds-s3-data-tagger module
#
############################################################

data "aws_iam_policy_document" "assume_role_lambda" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = [
        "batchoperations.s3.amazonaws.com",
        "lambda.amazonaws.com"
      ]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "pds_s3_data_tagger_role_policy" {

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.pds_s3_data_tagger_function_name}:log-stream:*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:PutInventoryConfiguration",
      "s3:GetInventoryConfiguration",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionTagging",
      "s3:GetObjectAcl",
      "s3:PutObjectAcl",
      "s3:GetBucketLocation",
      "s3:GetReplicationConfiguration",
      "s3:InitiateReplication",
      "s3:DeleteObjectTagging",
      "s3:DeleteObjectVersionTagging"
    ]
    resources = [
      "arn:aws:s3:::${var.pds_s3_data_tagger_metadata_bucket}/*",
      "arn:aws:s3:::${var.s3_bucket_name_to_be_tagged}",
      "arn:aws:s3:::${var.s3_bucket_name_to_be_tagged}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      "arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:${var.pds_s3_data_tagger_function_name}"
    ]
  }

}

resource "aws_iam_role" "pds_s3_data_tagger_role" {
  name = "pds_s3_data_tagger_role"
  inline_policy {
    name   = "pds_s3_data_tagger_role_policy"
    policy = data.aws_iam_policy_document.pds_s3_data_tagger_role_policy.json
  }
  assume_role_policy   = data.aws_iam_policy_document.assume_role_lambda.json
  permissions_boundary = data.aws_iam_policy.mcp_operator_policy.arn
}

###########################################################
#
# Outputs
#
###########################################################

output "pds_s3_data_tagger_role_arn" {
  value = aws_iam_role.pds_s3_data_tagger_role.arn
}
