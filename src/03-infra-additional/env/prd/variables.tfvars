env = "prd"

log_retencao_dias = 90

parametros_aplicacao = {
  nivel_log     = "warn"
  timeout_req_s = "10"
}

service_accounts = {
  "atlas"        = "atlas-api"
  "atlas-worker" = "atlas-worker"
}

habilitar_addons = false
