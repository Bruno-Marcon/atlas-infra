output "vpc_endpoint_s3_id" {
  description = "ID do gateway endpoint de S3"
  value       = module.vpc-endpoints.endpoint_s3_id
}

output "network_acl_id" {
  description = "ID da network ACL das subnets públicas"
  value       = module.network-acl.acl_id
}
