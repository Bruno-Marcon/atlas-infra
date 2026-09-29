env = "dev"

storage_config = {
  versionamento     = false
  expiracao_dias    = 30
  transicao_ia_dias = 15
}

fila_config = {
  visibilidade_s = 30
  retencao_s     = 345600
  max_tentativas = 3
}

registros_dns = {
  "api" = ""
  "app" = ""
}
