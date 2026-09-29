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
  description = "Zona privada do ambiente, criada na camada 02-infra"
  type        = string
}

variable "zone_name" {
  description = "Domínio da zona privada"
  type        = string
}

variable "cluster_endpoint" {
  description = "Endpoint da API do cluster, usado como alvo do registro interno"
  type        = string
}

variable "registros" {
  description = "Nomes publicados na zona (subdomínio => alvo; alvo vazio aponta para o cluster)"
  type        = map(string)
}
