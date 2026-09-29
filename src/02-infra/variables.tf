variable "platform" {
  description = "Nome da plataforma"
  type        = string
  default     = "sbx"
}

variable "application" {
  description = "Nome da aplicação"
  type        = string
  default     = "atlas"
}

variable "env" {
  description = "Nome do ambiente (dev, hmg ou prd)"
  type        = string

  validation {
    condition     = contains(["dev", "hmg", "prd"], var.env)
    error_message = "env precisa ser dev, hmg ou prd."
  }
}

variable "region" {
  description = "Região da nuvem"
  type        = string
  default     = "us-east-1"
}

variable "endpoint_local" {
  description = "Endpoint do emulador local; vazio aponta para a nuvem real"
  type        = string
  default     = "http://localhost:4566"
}

variable "databases_config" {
  description = "Configuração das tabelas do sistema"
  type = object({
    billing_mode         = string
    point_in_time_backup = bool
  })
}

variable "dominio" {
  description = "Domínio da zona privada do ambiente"
  type        = string
}

variable "kubernetes_config" {
  description = "Versão do cluster e dimensionamento do nodegroup"
  type = object({
    versao         = string
    instance_types = list(string)
    capacity_type  = string
    min_size       = number
    max_size       = number
    desired_size   = number
  })
}

variable "rds_config" {
  description = "Dimensionamento e janela de backup do banco relacional"
  type = object({
    engine            = string
    instance_class    = string
    allocated_storage = number
    multi_az          = bool
    backup_retencao   = number
    deletion_protect  = bool
  })
}

variable "cache_config" {
  description = "Motor, tipo de nó e quantidade de nós do cache"
  type = object({
    engine    = string
    node_type = string
    num_nodes = number
  })
}

variable "repositorios_imagem" {
  description = "Componentes com repositório de imagem próprio"
  type        = list(string)
}
