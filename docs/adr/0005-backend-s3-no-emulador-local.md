# ADR-0005: State remoto em S3 com lock em DynamoDB, dentro do emulador local

- **Status:** Aceita
- **Data:** 2026-09-15
- **Substitui:** —

## Contexto

O atlas-infra é laboratório: não há conta de nuvem real. Ainda assim, o objetivo é exercitar o
ciclo completo como seria em produção — state remoto, lock, versionamento de state,
`terraform_remote_state` entre camadas. State local não exercita nada disso.

## Decisão

Todo alvo é o emulador `floci` (`http://localhost:4566`). O backend de todas as camadas é S3
(`sbx-atlas-terraform`, com versionamento) com lock em DynamoDB (`sbx-atlas-tflock`, chave
`LockID`), ambos **dentro do emulador**, criados uma única vez por `bootstrap.ps1` (idempotente).
Credenciais são as fixas do emulador (`test/test`).

`provider.tf` de cada camada concentra o apontamento para o emulador (`endpoints`, `skip_*`) —
trocar esse arquivo e o `backend.tf` é o caminho para apontar a uma conta real.

## Alternativas descartadas

| Alternativa | Por que não |
|---|---|
| State local | Não exercita lock nem `terraform_remote_state` entre camadas |
| Conta AWS real de sandbox | Custo, credencial real e risco — o workspace existe justamente para não ter isso |
| Backend `pg`/`http` | Diferente do que se usaria em AWS; ensaia a coisa errada |

## Consequências

- O state é tão durável quanto o emulador: com `FLOCI_STORAGE_MODE=memory` (default do floci),
  um `docker compose down` apaga bucket, workspaces e recursos juntos. O compose do hub usa
  `hybrid` por isso
- Recriar o bucket à mão esquece o versionamento — sempre usar `bootstrap.ps1`
- **`provider.tf` não lista todos os serviços** (faltam eks, rds, elasticache, ecr, route53, acm):
  esses chegam ao emulador pelo `AWS_ENDPOINT_URL` do ambiente. Rodar sem essa variável manda
  parte das chamadas para a AWS real. A variável vem de `set-env.ps1` ou do `settings.json`
- `terraform destroy` é negado por política do hub; zerar é `docker compose ... down -v`

## Revisitar quando

O repositório passar a ter um alvo de nuvem real — aí `backend.tf`/`provider.tf` ganham variante
por alvo e esta ADR é substituída.
