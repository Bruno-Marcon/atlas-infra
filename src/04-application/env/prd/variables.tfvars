env = "prd"

storage_config = {
  versionamento     = true
  expiracao_dias    = 365
  transicao_ia_dias = 60
}

fila_config = {
  visibilidade_s = 60
  retencao_s     = 1209600
  max_tentativas = 5
}

registros_dns = {
  "api" = ""
  "app" = ""
}
