################################################################################
# Estado da camada anterior
#
# É assim que a cadeia numerada se liga: cada camada lê o output da anterior
# pelo state remoto, no mesmo workspace (= ambiente). Nunca por valor copiado
# à mão no tfvars.
################################################################################
data "terraform_remote_state" "foundation" {
  backend   = "s3"
  workspace = terraform.workspace

  config = {
    bucket               = "sbx-atlas-terraform"
    key                  = "foundation.tfstate"
    region               = "us-east-1"
    workspace_key_prefix = "sbx-atlas"

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
