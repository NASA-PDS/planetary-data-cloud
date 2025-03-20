module "iam" {
  source = "./terraform-modules/iam"

  pds_s3_data_tagger_function_name      = var.pds_s3_data_tagger_function_name
  permission_boundary_for_iam_roles_arn = var.permission_boundary_for_iam_roles_arn
  region                                = var.region
  pds_s3_data_tagger_metadata_bucket    = var.pds_s3_data_tagger_metadata_bucket
  s3_bucket_name_to_be_tagged           = var.s3_bucket_name_to_be_tagged
}

module "pds-s3-data-tagger" {
  source = "./terraform-modules/pds-s3-data-tagger"

  pds_s3_data_tagger_function_name   = var.pds_s3_data_tagger_function_name
  pds_s3_data_tagger_role_arn        = module.iam.pds_s3_data_tagger_role_arn
  region                             = var.region
  pds_s3_data_tagger_metadata_bucket = var.pds_s3_data_tagger_metadata_bucket
  s3_bucket_name_to_be_tagged        = var.s3_bucket_name_to_be_tagged

  depends_on = [module.iam]

}
