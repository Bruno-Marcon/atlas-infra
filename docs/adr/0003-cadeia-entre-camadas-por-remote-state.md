# ADR-0003: Camadas se ligam só por `terraform_remote_state`

- **Status:** Aceita
- **Data:** 2026-09-15
- **Substitui:** —

## Contexto

Com states separados (ADR-0002), uma camada precisa de IDs criados por outra: a `02-infra` usa
`vpc_id` e `subnet_private_ids` da `00`; a `04` usa `zone_id` e `cluster_endpoint` da `02`. Copiar
esses valores para o tfvars funciona no primeiro dia e mente no segundo — quando o recurso é
recriado, o plan continua "limpo" apontando para um ID que não existe mais.

## Decisão

Uma camada lê o que precisa de outra **exclusivamente** por `data "terraform_remote_state"` em
`datasource.tf`, no mesmo workspace (`workspace = terraform.workspace`). Nenhum ID, ARN ou nome
gerado por outra camada aparece em tfvars.

Dependências reais hoje:

| Camada | Lê de |
|---|---|
| `00-foundation` | — |
| `01-network-additional` | `foundation` |
| `02-infra` | `foundation` |
| `03-infra-additional` | `foundation`, `infra` |
| `04-application` | `foundation`, `infra`, `infra_additional` |

## Alternativas descartadas

| Alternativa | Por que não |
|---|---|
| Valor copiado em tfvars | Fica desatualizado em silêncio; é o jeito mais rápido de fazer o plan mentir |
| Data source por tag/nome (`data "aws_vpc"`) | Acopla a convenção de nome e retorna 0 ou N resultados de forma frágil |
| SSM Parameter Store como barramento | Mais um recurso a manter e sincronizar; o state já é a fonte da verdade |

## Consequências

- A camada N só dá plan com a N-1 **aplicada** no mesmo ambiente
- Renomear um output é mudança quebrante para as consumidoras — conferir os `datasource.tf`
- **A `01-network-additional` é folha:** ninguém declara `remote_state "network_additional"`.
  A ordem obrigatória real é `00 → {01, 02}`, `02 → 03 → 04`; a `01` pode rodar em paralelo ou ser
  pulada. A numeração não reflete isso — está registrado aqui para ninguém serializar à toa

## Revisitar quando

Os outputs precisarem ser lidos por outro repositório (aí um barramento explícito, como SSM, passa
a fazer sentido).
