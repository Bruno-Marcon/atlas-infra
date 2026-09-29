################################################################################
# Backend remoto — uma key por camada, mesmo bucket e mesmo prefixo de workspace
################################################################################
terraform {
  backend "s3" {
    bucket               = "sbx-atlas-terraform"
    key                  = "network-additional.tfstate"
    region               = "us-east-1"
    workspace_key_prefix = "sbx-atlas"
    dynamodb_table       = "sbx-atlas-tflock"

    access_key                  = "test"
    secret_key                  = "test"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    use_path_style              = true

    endpoints = {
      s3       = "http://localhost:4566"
      dynamodb = "http://localhost:4566"
    }
  }
}
