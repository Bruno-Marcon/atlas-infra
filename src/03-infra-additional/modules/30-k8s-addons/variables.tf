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

variable "cluster_name" {
  description = "Cluster onde os add-ons são instalados"
  type        = string
}

variable "habilitar" {
  description = "Liga a criação dos add-ons (ver limitação do emulador no 01-addons.tf)"
  type        = bool
  default     = false
}

variable "addons" {
  description = "Add-ons gerenciados e suas versões (vazio = versão padrão do cluster)"
  type        = map(string)
  default = {
    "vpc-cni"    = ""
    "coredns"    = ""
    "kube-proxy" = ""
  }
}
