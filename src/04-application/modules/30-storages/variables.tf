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

variable "storage_config" {
  description = "Versionamento e ciclo de vida do bucket da aplicação"
  type = object({
    versionamento     = bool
    expiracao_dias    = number
    transicao_ia_dias = number
  })
}

variable "audit_bucket_id" {
  description = "Bucket de auditoria da camada 00-foundation, destino do log de acesso"
  type        = string
}
