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

variable "cluster_role_arn" {
  description = "Role do control plane, criada no módulo 10-iam"
  type        = string
}

variable "node_role_arn" {
  description = "Role dos nós, criada no módulo 10-iam"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets onde o cluster e os nós vivem"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups do control plane"
  type        = list(string)
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
