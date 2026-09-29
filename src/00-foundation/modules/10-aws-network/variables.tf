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

variable "cidr_subnet" {
  description = "Dois primeiros octetos do CIDR da VPC (ex.: 10.10)"
  type        = string
}

variable "azs" {
  description = "Sufixos de zona de disponibilidade usados pelas subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
