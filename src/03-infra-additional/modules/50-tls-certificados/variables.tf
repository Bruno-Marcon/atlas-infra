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

variable "zone_id" {
  description = "Zona privada onde o registro de validação é publicado"
  type        = string
}

variable "dominio" {
  description = "Domínio base do certificado"
  type        = string
}
