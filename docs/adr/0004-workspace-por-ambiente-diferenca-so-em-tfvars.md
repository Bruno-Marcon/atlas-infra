# ADR-0004: Um workspace por ambiente; a diferença entre ambientes vive só no tfvars

- **Status:** Aceita
- **Data:** 2026-09-15
- **Substitui:** —

## Contexto

`dev`, `hmg` e `prd` precisam da mesma topologia com dimensionamento diferente (tamanho de
instância, retenção, multi-AZ, deletion protection). Duplicar diretórios por ambiente multiplica o
HCL por três e deixa os ambientes divergirem por acidente.

## Decisão

Cada ambiente é um **workspace** do Terraform com o mesmo nome (`dev`, `hmg`, `prd`); o backend
separa os states por `workspace_key_prefix = "sbx-atlas"` →
`sbx-atlas/<env>/<camada>.tfstate`. Todo valor que muda por ambiente vem de
`env/<env>/variables.tfvars` e só de lá. A variável `env` é validada contra `dev|hmg|prd`.

A topologia é idêntica nos três: mesmos endereços de recurso, nenhum recurso exclusivo de um
ambiente.

## Alternativas descartadas

| Alternativa | Por que não |
|---|---|
| Diretório por ambiente (`envs/prd/…`) | HCL triplicado; drift entre ambientes por esquecimento |
| Recurso condicional por ambiente (`count = var.env == "prd" ? 1 : 0`) | Faz `hmg` deixar de ensaiar `prd` |
| Um bucket de state por ambiente | Três bootstraps para manter no emulador sem ganho de isolamento real |

## Consequências

- `terraform workspace select` errado aplica no ambiente errado — `deploy.ps1` e
  `apply-cascata.ps1` selecionam o workspace a partir do `-env` para evitar isso
- **Workspaces vivem dentro do bucket de state:** perdendo o bucket, é preciso
  `terraform workspace new <env>` em cada camada
- Diferenças legítimas (ex.: `skip_final_snapshot = var.env != "prd"` no RDS) ficam restritas a
  atributo, nunca à existência do recurso

## Revisitar quando

Um ambiente precisar de recurso que os outros não têm, ou houver contas separadas por ambiente.
