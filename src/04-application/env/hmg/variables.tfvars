env = "hmg"

storage_config = {
  versionamento     = true
  expiracao_dias    = 90
  transicao_ia_dias = 30
}

fila_config = {
  visibilidade_s = 60
  retencao_s     = 604800
  max_tentativas = 5
}

registros_dns = {
  "api" = ""
  "app" = ""
}
