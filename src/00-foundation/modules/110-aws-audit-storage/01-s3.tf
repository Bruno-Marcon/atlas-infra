################################################################################
# Bucket de auditoria
#
# Destino dos logs de acesso dos buckets das camadas seguintes. Bloqueio de
# acesso público e criptografia são padrão do sandbox: recurso novo nasce com
# os dois, nunca se acrescenta depois.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_s3_bucket" "audit" {
  bucket = "${local.prefixo}-audit"

  tags = {
    Name     = "${local.prefixo}-audit"
    resource = "storage"
  }
}

resource "aws_s3_bucket_public_access_block" "audit" {
  bucket                  = aws_s3_bucket.audit.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "audit" {
  bucket = aws_s3_bucket.audit.id

  versioning_configuration {
    status = var.audit_storage_config.versionamento ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "audit" {
  bucket = aws_s3_bucket.audit.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "audit" {
  bucket = aws_s3_bucket.audit.id

  rule {
    id     = "expiracao-auditoria"
    status = "Enabled"

    filter {}

    expiration {
      days = var.audit_storage_config.retencao_dias
    }
  }
}
