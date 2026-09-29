output "endpoint_s3_id" {
  description = "ID do gateway endpoint de S3"
  value       = aws_vpc_endpoint.s3.id
}
