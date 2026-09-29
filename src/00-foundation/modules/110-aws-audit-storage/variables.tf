variable "platform" {
  description = "Nome da plataforma"
  type        = string
}

variable "application" {
  description = "Nome da aplicação"
  type        = string
}

variable "env" {
  description = "Nome do ambiente (dev, hmg ou prd)"
  type        = string
}

variable "audit_storage_config" {
  description = "Retenção e versionamento do bucket de auditoria"
  type = object({
    retencao_dias = number
    versionamento = bool
  })
}
