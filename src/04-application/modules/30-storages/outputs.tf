output "bucket_id" {
  description = "Nome do bucket da aplicação"
  value       = aws_s3_bucket.app.id
}

output "bucket_arn" {
  description = "ARN do bucket da aplicação"
  value       = aws_s3_bucket.app.arn
}
