# Architecture Decision Records — atlas-infra

Cada arquivo registra **uma** decisão: o contexto, o que foi decidido, as alternativas descartadas
e o custo aceito. Formato em [`0000-template.md`](0000-template.md); processo em
[ADR-0001](0001-registrar-decisoes-em-adr.md).

## Índice

| ADR | Decisão | Status |
|---|---|---|
| [0001](0001-registrar-decisoes-em-adr.md) | Decisões de arquitetura são registradas como ADR no repositório | Aceita |
| [0002](0002-cinco-camadas-numeradas-com-state-proprio.md) | Cinco camadas numeradas, cada uma com state próprio | Aceita |
| [0003](0003-cadeia-entre-camadas-por-remote-state.md) | Camadas se ligam só por `terraform_remote_state` | Aceita |
| [0004](0004-workspace-por-ambiente-diferenca-so-em-tfvars.md) | Um workspace por ambiente; diferença só no tfvars | Aceita |
| [0005](0005-backend-s3-no-emulador-local.md) | State em S3 + lock em DynamoDB, dentro do emulador local | Aceita |
| [0006](0006-nomenclatura-e-tags-canonicas.md) | Nome `<platform>-<application>-<env>-<tipo>` e tags via `default_tags` | Aceita |
| [0007](0007-segredo-fora-do-codigo.md) | Terraform cria o contêiner do segredo; o valor nunca vem do código | Aceita |
| [0008](0008-sem-recursos-dentro-do-cluster.md) | Nada dentro do cluster; add-ons do EKS desligados no sandbox | Aceita |
| [0009](0009-nodegroup-dimensionado-por-ambiente.md) | Nodegroup dimensionado por tfvars; `desired_size` ignorado | Aceita |
| [0010](0010-drift-conhecido-do-emulador.md) | Drift do emulador é aceito e documentado, não contornado | Aceita |

## Regras

- Numeração sequencial de 4 dígitos, nunca reaproveitada
- ADR `Aceita` não é editada: uma nova a **substitui** e a antiga passa a `Substituída por ADR-NNNN`
- Mudança de arquitetura entra no mesmo PR que a sua ADR
- No Claude Code: `/nova-adr <título>`

## Decisões em aberto

Candidatas a ADR que ainda não foram decididas:

- **Versionar os scripts e o lock file.** O `.gitignore` ignora `*.ps1` e `.terraform.lock.hcl`,
  então `bootstrap.ps1`, `apply-cascata.ps1`, os `deploy.ps1` e os locks de provider não estão no
  git. Um clone novo não consegue operar o repositório, e a versão do provider não é fixada entre
  máquinas. Manter `set-env.ps1` ignorado continua fazendo sentido
