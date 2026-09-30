# ADR-0002: Infraestrutura em cinco camadas numeradas, cada uma com state próprio

- **Status:** Aceita
- **Data:** 2026-09-15
- **Substitui:** —

## Contexto

O atlas tem recursos com ciclos de vida muito diferentes: rede e bucket de auditoria mudam quase
nunca; cluster, banco e IAM mudam às vezes; filas e registros DNS da aplicação mudam com
frequência. Um state único faria todo plan varrer ~70 recursos e colocaria a VPC no raio de
qualquer mudança de fila.

## Decisão

O código fica em `src/` dividido em cinco camadas — `00-foundation`, `01-network-additional`,
`02-infra`, `03-infra-additional`, `04-application` —, cada uma um root module independente com
`backend.tf` próprio (uma `key` por camada) e ciclo próprio de `init/plan/apply`.

Toda camada tem a mesma anatomia: `backend.tf`, `provider.tf`, `variables.tf`, `datasource.tf`
(exceto a 00), `main.tf`, `outputs.tf`, `deploy.ps1`, `env/<env>/variables.tfvars` e
`modules/<NN>-<nome>/`.

## Alternativas descartadas

| Alternativa | Por que não |
|---|---|
| Root module único | Raio de impacto total em todo apply; plan lento; lock bloqueia tudo |
| Um root module por serviço (rede, eks, rds…) | Explode em muitos states e dependências cruzadas sem ordem clara |
| Terragrunt | Mais uma ferramenta para o sandbox manter; o ganho (DRY de backend) não compensa em 5 camadas |

## Consequências

- Mudança numa camada alta não pode destruir recurso de uma baixa
- `backend.tf` e o bloco de config do `terraform_remote_state` se repetem em toda camada — é
  duplicação aceita
- Apply total exige percorrer as camadas em ordem (`apply-cascata.ps1`); desfazer é na ordem inversa
- A numeração sugere uma cadeia estrita que não existe — ver ADR-0003

## Revisitar quando

Uma camada passar de ~40 recursos ou duas camadas precisarem mudar sempre juntas.
