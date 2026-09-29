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

variable "region" {
  description = "Região da nuvem"
  type        = string
}

variable "vpc_id" {
  description = "VPC criada na camada 00-foundation"
  type        = string
}

variable "route_table_public_id" {
  description = "Route table pública da camada 00-foundation"
  type        = string
}
