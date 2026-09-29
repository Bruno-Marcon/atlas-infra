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

variable "repositorios" {
  description = "Repositórios de imagem do sistema"
  type        = list(string)
}

variable "imagens_mantidas" {
  description = "Quantas imagens sem tag ficam antes da expiração"
  type        = number
  default     = 10
}
