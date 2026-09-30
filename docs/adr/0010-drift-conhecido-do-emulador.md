# ADR-0010: Drift do emulador é aceito e documentado, não contornado no HCL

- **Status:** Aceita
- **Data:** 2026-09-15
- **Substitui:** —

## Contexto

Após o apply completo (15/15 — 5 camadas × 3 ambientes, em 2026-09-15), o plan imediato não
converge em duas camadas, de forma idêntica em `dev`, `hmg` e `prd`:

| Camada | Plan pós-apply | Causa |
|---|---|---|
| `01-network-additional` | `0 to add, 1 to change` | O floci não persiste tags de `aws_network_acl` |
| `02-infra` | `1 to add, 1 to destroy` | O emulador devolve `num_cache_nodes = 0` e `node_type` vazio para `aws_elasticache_cluster`; `node_type` força replacement |

As camadas `00`, `03` e `04` dão `No changes`.

## Decisão

O HCL permanece escrito como seria para a AWS real. **Não** se adiciona `ignore_changes` nem
condicional para esconder esse drift. Ele é tratado como ruído conhecido: um plan "limpo" neste
repositório significa *só essas duas linhas*, não *zero mudanças*.

## Alternativas descartadas

| Alternativa | Por que não |
|---|---|
| `ignore_changes = [tags]` na NACL e `[node_type]` no cache | Esconde drift real quando o alvo for a nuvem |
| Condicional "se emulador" no módulo | Contamina o código com o alvo de teste |
| Remover o ElastiCache | Perde cobertura do resto do recurso |

## Consequências

- Todo revisor de plan precisa conhecer essas duas linhas — estão no `CLAUDE.md` e aqui
- Qualquer linha **além** delas é mudança real e precisa de explicação
- Em `02-infra` o cache é recriado a cada apply no emulador; inofensivo aqui, pois não há dado
- Este drift não valida nem invalida o código para uso real

## Revisitar quando

Uma versão nova do floci corrigir qualquer das duas causas — então atualizar a tabela ou
descontinuar esta ADR.
