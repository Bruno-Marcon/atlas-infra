################################################################################
# Tabelas do sistema
#
# Uma tabela de catálogo (chave composta) e uma de idempotência, com TTL.
# Backup contínuo só onde o ambiente pede — ver env/<ambiente>/variables.tfvars.
################################################################################
resource "aws_dynamodb_table" "catalogo" {
  name         = "${local.prefixo}-catalogo"
  billing_mode = var.databases_config.billing_mode
  hash_key     = "pk"
  range_key    = "sk"

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  point_in_time_recovery {
    enabled = var.databases_config.point_in_time_backup
  }

  tags = {
    Name     = "${local.prefixo}-catalogo"
    resource = "database"
  }
}

resource "aws_dynamodb_table" "idempotencia" {
  name         = "${local.prefixo}-idempotencia"
  billing_mode = var.databases_config.billing_mode
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  ttl {
    attribute_name = "expira_em"
    enabled        = true
  }

  tags = {
    Name     = "${local.prefixo}-idempotencia"
    resource = "database"
  }
}
