################################################################################
# Ciclo de vida e log de acesso
################################################################################
resource "aws_s3_bucket_lifecycle_configuration" "app" {
  bucket = aws_s3_bucket.app.id

  rule {
    id     = "transicao-e-expiracao"
    status = "Enabled"

    filter {}

    transition {
      days          = var.storage_config.transicao_ia_dias
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = var.storage_config.expiracao_dias
    }
  }
}

resource "aws_s3_bucket_logging" "app" {
  bucket        = aws_s3_bucket.app.id
  target_bucket = var.audit_bucket_id
  target_prefix = "s3-access/${local.prefixo}-app/"
}
