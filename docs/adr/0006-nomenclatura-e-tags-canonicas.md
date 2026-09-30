# ADR-0006: Nome canônico `<platform>-<application>-<env>-<tipo>` e tags via `default_tags`

- **Status:** Aceita
- **Data:** 2026-09-15
- **Substitui:** —

## Contexto

Três ambientes da mesma topologia no mesmo emulador (e, numa conta real, possivelmente na mesma
conta) precisam de nomes que não colidam e que digam, só de olhar, a quem o recurso pertence.

## Decisão

- Todo recurso é nomeado `<platform>-<application>-<env>-<tipo>` (ex.: `sbx-atlas-hmg-catalogo`),
  montado por `locals.prefixo = "${var.platform}-${var.application}-${var.env}"` em cada módulo
- `platform`, `application`, `environment` e `managed_by` vêm de `default_tags` no `provider.tf`;
  cada recurso acrescenta apenas `Name` e `resource` (categoria: `database`, `kubernetes`,
  `secret`…)
- `platform = "sbx"` e `application = "atlas"` são defaults de variável, não repetidos em tfvars

## Alternativas descartadas

| Alternativa | Por que não |
|---|---|
| Módulo de naming compartilhado | Uma dependência a mais para uma concatenação de três strings |
| Tags completas em cada recurso | Repetição que diverge; `default_tags` garante cobertura |
| `name_prefix` gerado pelo provider | Nome imprevisível; quebra busca e referência humana |

## Consequências

- `locals.prefixo` deve existir em **um único** `.tf` por módulo — duplicá-lo ao adicionar um
  segundo arquivo quebra o `validate` (armadilha já ocorrida)
- Nomes com limite de tamanho curto (ex.: ElastiCache) precisam caber com o prefixo
- Recurso que não aceita tags herdadas (ou emulador que não as persiste, caso da NACL — ADR-0010)
  gera drift de tag

## Revisitar quando

A plataforma adotar outra convenção de nome, ou houver múltiplas contas onde o `env` no nome vira
redundante.
