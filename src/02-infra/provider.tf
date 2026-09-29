################################################################################
# Provider
#
# Sandbox: todo endpoint aponta para o emulador local (ver config.md do
# workspace). Trocar este arquivo é o único ponto de mudança para apontar
# a camada a uma conta real.
################################################################################
terraform {
  required_version = ">= 1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.60"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = "test"
  secret_key = "test"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ec2            = var.endpoint_local
    s3             = var.endpoint_local
    sns            = var.endpoint_local
    sqs            = var.endpoint_local
    ssm            = var.endpoint_local
    iam            = var.endpoint_local
    sts            = var.endpoint_local
    dynamodb       = var.endpoint_local
    secretsmanager = var.endpoint_local
    logs           = var.endpoint_local
  }

  default_tags {
    tags = {
      platform    = var.platform
      application = var.application
      environment = var.env
      managed_by  = "terraform"
    }
  }
}
