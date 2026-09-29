variable "platform" {
  description = "Nome da plataforma"
  type        = string
}

variable "application" {
  description = "Nome da aplicação"
  type        = string
}

variable "env" {
  description = "Nome do ambiente"
  type        = string
}

variable "audit_bucket_id" {
  description = "Bucket de auditoria da camada 00-foundation"
  type        = string
}

variable "habilitar_roles_eks" {
  description = "Cria as roles de cluster e de nó do EKS"
  type        = bool
  default     = true
}
