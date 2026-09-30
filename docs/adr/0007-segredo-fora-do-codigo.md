# ADR-0007: Terraform cria o contêiner do segredo; o valor nunca vem do código

- **Status:** Aceita
- **Data:** 2026-09-15
- **Substitui:** —

## Contexto

A aplicação precisa de credenciais (banco, integrações). Colocar o valor em tfvars ou variável de
ambiente o expõe no repositório, no histórico do shell e no plan. Mas deixar o segredo inteiro
fora do Terraform perde a política de acesso e o nome canônico.

## Decisão

- **Segredo da aplicação** (`03-infra-additional/modules/40-secrets`): o Terraform cria o
  `aws_secretsmanager_secret`, a policy de leitura para a role da aplicação e uma versão
  *placeholder*. O valor real é escrito fora do ciclo (rotação, pipeline ou à mão) e
  `ignore_changes = [secret_string]` impede que um apply o sobrescreva
- **Senha do banco** (`02-infra/modules/40-databases`): nasce de `random_password` e vai direto
  para o Secrets Manager, junto com host, porta e nome do banco. Nunca passa por tfvars.
  `ignore_changes = [password]` no `aws_db_instance` protege rotação feita fora do Terraform

## Alternativas descartadas

| Alternativa | Por que não |
|---|---|
| Valor em tfvars (mesmo ignorado pelo git) | Vaza em cópia de arquivo, em log de CI e no plan |
| Variável `sensitive` preenchida por env var | O valor ainda passa pelo shell e fica no state como input |
| Segredo criado 100% fora do Terraform | Perde nome canônico, tags e a policy de leitura versionada |

## Consequências

- A senha gerada por `random_password` **fica no state** — o state é tão sensível quanto o
  segredo, e o bucket de state precisa de acesso restrito numa conta real
- Após uma rotação externa, o state guarda uma senha velha; isso é esperado e inofensivo por causa
  do `ignore_changes`
- Nenhum valor de segredo em commit, tfvars, scratchpad ou nota — só a referência (nome do secret)

## Revisitar quando

Houver rotação gerenciada (ex.: `manage_master_user_password` do RDS) disponível no alvo — ela
tira a senha do state por completo.
