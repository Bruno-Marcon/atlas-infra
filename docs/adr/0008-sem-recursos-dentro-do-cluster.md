# ADR-0008: Nenhum recurso dentro do cluster; add-ons do EKS desligados no sandbox

- **Status:** Aceita
- **Data:** 2026-09-15
- **Substitui:** —

## Contexto

O emulador cria `aws_eks_cluster` e `aws_eks_node_group` como objetos de API, mas:

- a API de add-ons não existe — `POST /clusters/<nome>/addons` responde `UnknownOperationException`
- o que a API do EKS devolve como endpoint não é um control plane gerenciado; cada cluster vira um
  k3s em container, cuja versão (v1.34.1) nem é a que a API reporta (1.31)

Declarar namespace, deployment, Ingress ou malha com os providers `kubernetes`/`helm` "passaria"
em algum grau, mas não provaria nada sobre um EKS real.

## Decisão

- Este repositório **não declara nada** com os providers `kubernetes` ou `helm`. Ele termina na
  borda do cluster: cluster, nodegroup, roles, OIDC/IRSA
- O módulo `03-infra-additional/modules/30-k8s-addons` existe com a forma correta de
  `aws_eks_addon` e nasce com `habilitar_addons = false`. Contra uma conta real, basta ligar a flag

## Alternativas descartadas

| Alternativa | Por que não |
|---|---|
| Declarar workloads contra o k3s do emulador | Cobertura fingida: valida o k3s, não o EKS |
| Remover o módulo de add-ons | Perde o slot na camada e a forma do recurso já revisada |
| Instalar add-ons via `helm_release` | Mesmo problema da primeira linha, e mistura responsabilidade |

## Consequências

- Workload da aplicação é responsabilidade de outro repositório (manifests/GitOps), não deste
- A camada 03 converge em `No changes` com os add-ons desligados
- O k3s não serve para validar upgrade de versão do EKS

## Revisitar quando

O emulador passar a implementar a API de add-ons, ou o alvo passar a ser uma conta real.
