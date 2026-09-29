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

variable "subnet_ids" {
  description = "Subnets privadas do cache"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups do cache"
  type        = list(string)
}

variable "cache_config" {
  description = "Motor, tipo de nó e quantidade de nós do cache"
  type = object({
    engine    = string
    node_type = string
    num_nodes = number
  })
}
