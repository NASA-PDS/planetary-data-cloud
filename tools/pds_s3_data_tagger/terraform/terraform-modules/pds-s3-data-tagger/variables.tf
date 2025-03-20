variable "pds_s3_data_tagger_role_arn" {
  description = "PDS S3 Data Tagger role ARN"
  type        = string
  sensitive   = true
}

variable "pds_s3_data_tagger_function_name" {
  type      = string
  sensitive = true
}

variable "region" {
  description = "Region"
  type        = string
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