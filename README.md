# atlas-infra

Infraestrutura do sistema fictício **atlas**, no padrão multi-camada numerada do sandbox-cdb.
Todo alvo é o **emulador local** (`http://localhost:4566`) — não existe conta de nuvem real por trás.

## Estrutura

```
src/
├── 00-foundation/           VPC, subnets, IGW, rotas, SG, SNS, bucket de auditoria
├── 01-network-additional/   VPC endpoint de S3, network ACL
├── 02-infra/                zona DNS, IAM (app + roles do cluster), RDS + DynamoDB,
│                            cluster EKS + nodegroup, ECR, cache em memória
├── 03-infra-additional/     OIDC/IRSA, log groups, add-ons do cluster, segredos,
│                            parâmetros, certificado TLS
└── 04-application/          bucket da aplicação, filas SQS + DLQ, registros DNS
```

### Módulos por camada

| Camada | Módulos |
|---|---|
| `00-foundation` | `10-aws-network` · `70-aws-sns-topic` · `110-aws-audit-storage` |
| `01-network-additional` | `10-vpc-endpoints` · `20-network-acl` |
| `02-infra` | `09-dns-zone` · `10-iam` · `40-databases` · `50-kubernetes` · `60-container-registry` · `80-cache` |
| `03-infra-additional` | `10-k8s-oidc` · `20-observabilidade` · `30-k8s-addons` · `40-secrets` · `50-tls-certificados` |
| `04-application` | `30-storages` · `50-dns` · `50-filas` |

Cada camada tem sempre a mesma anatomia:

| Arquivo | Papel |
|---|---|
| `backend.tf` | State remoto — uma `key` por camada, mesmo bucket e prefixo de workspace |
| `provider.tf` | Provider e `default_tags`; é o único ponto que aponta para o emulador |
| `variables.tf` | Variáveis da camada, com validação de `env` |
| `datasource.tf` | `terraform_remote_state` das camadas anteriores (ausente na 00) |
| `main.tf` | Um bloco `module` por módulo, com cabeçalho dizendo o porquê |
| `outputs.tf` | O que a camada exporta para as seguintes |
| `deploy.ps1` | Fluxo padrão: init, workspace, validate, plan, confirmação, apply |
| `env/<ambiente>/variables.tfvars` | O que muda por ambiente — e só isso |
| `modules/<NN>-<nome>/` | Módulos locais numerados por ordem de dependência |

Dentro de um módulo, os `.tf` são numerados por preocupação (`01-vpc.tf`, `10-subnets.tf`,
`30-routes.tf`…), e `variables.tf`/`outputs.tf` fecham o contrato.

## Convenções

- **Nome de recurso:** `<platform>-<application>-<env>-<tipo>` → `sbx-atlas-hmg-catalogo`
- **Tags:** `platform`, `application`, `environment`, `managed_by` vêm de `default_tags`; cada recurso acrescenta `Name` e `resource`
- **Um workspace por ambiente** (`dev`, `hmg`, `prd`), com `workspace_key_prefix` separando os states
- **Ordem de apply é a ordem numérica.** A camada N lê o state da N-1 pelo `terraform_remote_state` — nunca por valor copiado à mão no tfvars
- **Segredo:** o Terraform cria o contêiner e a permissão de leitura; o **valor** é escrito fora do ciclo, e `ignore_changes` impede que o apply o sobrescreva

## Como rodar

```powershell
# 1. Emulador de pé
docker compose -f ../../../floci/compose.yaml up -d

# 2. Bucket de state e tabela de lock (uma vez só)
./bootstrap.ps1

# 3. Camada por camada, na ordem numérica
./src/00-foundation/deploy.ps1 -env hmg
./src/01-network-additional/deploy.ps1 -env hmg
./src/02-infra/deploy.ps1 -env hmg
./src/03-infra-additional/deploy.ps1 -env hmg
./src/04-application/deploy.ps1 -env hmg
```

`-PlanOnly` gera o plan e para antes do apply. Sem a flag, o script pede confirmação explícita
antes de aplicar.

Para desfazer, a ordem é a **inversa** (04 → 00): a camada de baixo tem recurso do qual as de cima
dependem. Zerar tudo de uma vez também é opção legítima no sandbox:
`docker compose -f ../../../floci/compose.yaml down -v`.

## Limites do emulador

O ciclo `init/plan/apply/destroy` fecha de verdade, e o state remoto com lock funciona. O que o
emulador **não** dá:

- Comportamento real de rede — a VPC existe como objeto de API, não como rede
- Avaliação de IAM efetivo — policy inválida pode passar aqui e falhar na nuvem
- Quota, limite de serviço e custo
- **Control plane de verdade no EKS** — o cluster e o nodegroup são criados como objeto de
  API, mas não há servidor de API atrás deles. Por isso este repositório não declara nada com
  os providers `kubernetes` ou `helm` (namespace, deployment, malha de serviço, Ingress):
  seria cobertura fingida
- **API de add-ons do EKS** — `POST /clusters/<nome>/addons` não existe no emulador. O módulo
  `30-k8s-addons` tem a forma correta do recurso e nasce com `habilitar_addons = false`; contra
  uma conta real basta ligar a flag
- **Banco que aceita conexão** — o RDS responde à API (criação, endpoint, credencial no cofre),
  mas não é um PostgreSQL de verdade escutando na ponta

Ou seja: o modelo prova que o HCL está correto e que a cadeia entre camadas fecha. Não prova que a
infraestrutura funciona.
# atlas-infra
