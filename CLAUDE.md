# CLAUDE.md — atlas-infra

Guia do Claude Code para este repositório. Responder em **português brasileiro**; comandos, flags
e valores de API ficam em inglês.

Terraform do sistema fictício **atlas**, em 5 camadas numeradas. **Todo alvo é o emulador local**
(`floci`, `http://localhost:4566`) — não existe conta de nuvem real por trás.

Este repositório vive dentro do hub `sandbox-cdb` (`../../../`). As regras do hub continuam
valendo aqui (`../../../CLAUDE.md`, `../../../.claude/rules/`); este arquivo só acrescenta o que é
específico do atlas-infra.

## Leia antes de mudar qualquer coisa

1. `docs/adr/` — as decisões de arquitetura. Não contradizer uma ADR `Aceita` sem escrever outra
   que a substitua
2. `README.md` — convenção de escrita do código (anatomia da camada, numeração de arquivo)
3. `../../../Obsidian/03 - Sistemas/atlas-infra.md` § **Memória Operacional** — histórico e armadilhas já resolvidas

## Mapa

```
src/
├── 00-foundation/          raiz — VPC, subnets, IGW, rotas, SG, SNS, bucket de auditoria
├── 01-network-additional/  FOLHA — VPC endpoint S3, NACL (ninguém lê os outputs dela)
├── 02-infra/               DNS, IAM, RDS + DynamoDB, EKS + nodegroup, ECR, cache    ← lê 00
├── 03-infra-additional/    OIDC/IRSA, log groups, add-ons, segredos, SSM, ACM         ← lê 00, 02
└── 04-application/         bucket da app, SQS + DLQ, registros DNS                    ← lê 00, 02, 03
bootstrap.ps1               cria bucket de state + tabela de lock (uma vez)
apply-cascata.ps1           00→04 por ambiente, para o ambiente na 1ª falha, tem -DryRun
set-env.ps1                 variáveis do emulador para terminal fora do Claude Code
```

Ordem real de dependência (ADR-0003): `00 → {01, 02}`, `02 → 03 → 04`. A `01` pode rodar em
paralelo ou ser pulada.

## Regras invioláveis

- **Nunca `terraform destroy`** — está no `deny` do hub. Para zerar o ambiente:
  `docker compose -f ../../../floci/compose.yaml down -v` (e depois `./bootstrap.ps1` de novo)
- **Plan antes de apply, sempre.** Apply sem o plan lido e aprovado pelo usuário não acontece
- **Camada N lê a N-1 só por `terraform_remote_state`** (ADR-0003). Nunca copiar ID/ARN para tfvars
- **Diferença entre ambientes só em `env/<env>/variables.tfvars`** (ADR-0004). Nada de
  `count = var.env == "prd" ? …` criando recurso exclusivo de um ambiente
- **Segredo:** Terraform cria o contêiner e a permissão; o valor fica fora do código e do tfvars,
  com `ignore_changes` (ADR-0007). Nenhum valor de segredo em commit, tfvars ou scratch
- **Nada com provider `kubernetes` ou `helm`** (ADR-0008) — o emulador não tem control plane

## Como rodar (a partir da raiz deste repo)

```powershell
docker compose -f ../../../floci/compose.yaml ps           # os 3 serviços precisam estar de pé
./bootstrap.ps1                                            # só na primeira vez / após down -v

# uma camada, um ambiente
cd src/02-infra
terraform init -input=false
terraform workspace select -or-create=true hmg
terraform plan -input=false -var-file="env/hmg/variables.tfvars" -out="02-infra-hmg.tfplan"

# todas as camadas
./apply-cascata.ps1 -DryRun            # plan em cascata
```

- As variáveis do emulador (`AWS_ENDPOINT_URL`, `test/test`, `us-east-1`) já vêm do `env` do
  `settings.json` do hub — não precisa dot-source de `set-env.ps1` dentro do Claude Code
- `src/<camada>/deploy.ps1` pede confirmação por `Read-Host` antes do apply: é para o terminal do
  usuário. No Claude Code, preferir `terraform` direto ou a skill `tf-plan-lote`
- Workflow do hub para qualquer mudança: `infra-context-detect → tf-plan-lote → infra-playbook → cluster-health`

## Convenções de código

- **Nome:** `<platform>-<application>-<env>-<tipo>` → `sbx-atlas-hmg-catalogo`, via
  `locals.prefixo` (ADR-0006)
- **Tags:** `platform`, `application`, `environment`, `managed_by` vêm de `default_tags` no
  `provider.tf`; cada recurso acrescenta **só** `Name` e `resource`
- **Módulo novo:** `modules/<NN>-<nome>/` com NN pela ordem de dependência dentro da camada;
  `.tf` numerados por preocupação (`01-…`, `10-…`), fechando com `variables.tf` e `outputs.tf`
- **`locals.prefixo` em um arquivo só por módulo** — duplicar quando o módulo ganha um segundo
  `.tf` quebra o `validate`
- **Todo `module` no `main.tf` tem cabeçalho** `####` dizendo o porquê, não o quê
- Variável de camada com `description`; `env` validado contra `dev|hmg|prd`
- Output novo que outra camada vai consumir → declarar no `outputs.tf` da camada **e** conferir o
  `datasource.tf` da consumidora
- `terraform fmt -recursive` antes de entregar

## Armadilhas conhecidas

- **Drift permanente esperado** (ADR-0010): pós-apply, `01` acusa `1 to change` (NACL sem tags no
  emulador) e `02` acusa `1 to add / 1 to destroy` (`aws_elasticache_cluster`). Plan "limpo" aqui =
  só esse drift. Qualquer outra linha é mudança real e precisa ser explicada
- **`provider.tf` lista só parte dos endpoints** (ec2, s3, sns, sqs, ssm, iam, sts, dynamodb,
  secretsmanager, logs). EKS, RDS, ElastiCache, ECR, Route53 e ACM chegam ao emulador pelo
  `AWS_ENDPOINT_URL` do ambiente. Sem essa variável, eles tentam a AWS real — não rodar plan
  fora do Claude Code sem `set-env.ps1`
- **Workspaces vivem dentro do bucket de state.** Perdeu o bucket → `terraform workspace new <env>`
  em cada camada; o `.terraform/environment` local mente
- Item `<key>-md5` na tabela de lock é o checksum do state, não lock preso
- Cada `aws_eks_cluster` vira um k3s real; a versão da API do EKS (1.31) não é a do k3s — não
  serve para validar upgrade
- **O `.gitignore` ignora `*.ps1` e `.terraform.lock.hcl`** — hoje nenhum script nem lock file está
  versionado. Um clone novo não tem `bootstrap.ps1`, `deploy.ps1` nem `apply-cascata.ps1`.
  Pendente de decisão; não "corrigir" sem o usuário pedir

## Git

- Commit, push e PR **só pela skill `git-commit-pr`** do hub (Conventional Commits em pt-br,
  CHANGELOG em Keep a Changelog)
- Mudança de arquitetura (camada, backend, convenção, provider) → nova ADR em `docs/adr/` no
  mesmo commit
