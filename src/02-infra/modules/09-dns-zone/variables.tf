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

variable "vpc_id" {
  description = "VPC associada à zona privada"
  type        = string
}

variable "dominio" {
  description = "Domínio da zona privada do ambiente"
  type        = string
}
