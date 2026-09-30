# ADR-0009: Dimensionamento do nodegroup vem do tfvars; `desired_size` é ignorado após a criação

- **Status:** Aceita
- **Data:** 2026-09-15
- **Substitui:** —

## Contexto

`dev` deve poder zerar fora do horário e rodar em SPOT; `prd` precisa de mínimo de 2 nós
ON_DEMAND. Ao mesmo tempo, um autoscaler ajusta o `desired_size` em execução — se o Terraform o
gerencia, todo apply desfaz o que o autoscaler fez.

## Decisão

`min_size`, `max_size`, `desired_size`, `instance_types` e `capacity_type` vêm de
`kubernetes_config` no tfvars de cada ambiente (ex.: `dev` = SPOT, 0–2; `prd` = ON_DEMAND, 2–4).
O `aws_eks_node_group` tem `lifecycle { ignore_changes = [scaling_config[0].desired_size] }`:
o Terraform define o valor inicial e depois não briga com o autoscaling.

## Alternativas descartadas

| Alternativa | Por que não |
|---|---|
| `desired_size` gerenciado pelo Terraform | Todo apply reverte o autoscaler |
| Dimensionamento fixo no módulo | Força mudança de código para mudar tamanho de ambiente |
| Nodegroup por ambiente com `count` | Viola ADR-0004 (topologia idêntica) |

## Consequências

- Mudar `desired_size` no tfvars **não tem efeito** num nodegroup já existente — para forçar, é
  fora do Terraform (CLI/console) ou recriando o recurso
- Zerar `dev` é mudar `min_size`/`desired_size` fora do Terraform ou via autoscaler, sem tocar no HCL

## Revisitar quando

Adoção de Karpenter ou equivalente que substitua nodegroups gerenciados.
