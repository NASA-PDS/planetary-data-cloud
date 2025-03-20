variable "region" {
  description = "Region"
  type        = string
  default     = "us-west-2"
}

variable "pds_s3_data_tagger_function_name" {
  type      = string
  default = "pds_s3_data_tagger"
  sensitive = true
}

variable "permission_boundary_for_iam_roles_arn" {
  description = "ARN of Permission boundary to be used when creating IAM roles"
  type        = string
  sensitive   = true
}

variable "s3_bucket_name_to_be_tagged" {
  description = "Name of the S3 bucket to be tagged"
  type        = string
  sensitive   = true
}

variable "pds_s3_data_tagger_metadata_bucket" {
  description = "Name of the PDS S3 Data Tagger metadata bucket"
  type        = string
  default     = "pds-s3-data-tagger-metadata"
  sensitive   = true
}