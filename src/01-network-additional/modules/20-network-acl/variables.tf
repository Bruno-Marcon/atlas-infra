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
  description = "VPC criada na camada 00-foundation"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets associadas à ACL"
  type        = list(string)
}

variable "cidr_permitido_interno" {
  description = "CIDR liberado na regra de entrada"
  type        = string
}
