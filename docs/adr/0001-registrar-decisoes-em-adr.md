# ADR-0001: Decisões de arquitetura são registradas como ADR no repositório

- **Status:** Aceita
- **Data:** 2026-09-29
- **Substitui:** —

## Contexto

As decisões do atlas-infra estavam espalhadas entre comentários de cabeçalho no HCL, o `README.md`
e a Memória Operacional do vault (`Obsidian/03 - Sistemas/atlas-infra.md`). Quem abre só o
repositório (pessoa ou agente) não vê o porquê das escolhas, e uma mudança bem-intencionada pode
desfazer uma delas sem perceber — por exemplo, copiar um ID para tfvars "para simplificar".

## Decisão

Toda decisão que molda a estrutura do repositório (camadas, backend, convenção, provider, forma de
lidar com o emulador) vive como ADR em `docs/adr/`, no formato de `0000-template.md`, numerada em
sequência e versionada junto com o código que ela afeta.

## Alternativas descartadas

| Alternativa | Por que não |
|---|---|
| Só no vault (`01 - Decisões/`) | Fica fora do repositório: não viaja com um clone nem aparece no diff do PR que a introduz |
| Só em comentário no HCL | Não registra alternativa descartada nem consequência; some quando o arquivo é refatorado |
| Wiki externa | Diverge do código sem ninguém notar |

## Consequências

- ADR `Aceita` não é editada — é substituída por outra, que aponta para ela. Só o campo de status
  da antiga muda
- Mudança de arquitetura sem ADR no mesmo PR é incompleta
- O comando `/nova-adr` (`.claude/commands/nova-adr.md`) padroniza a criação

## Revisitar quando

Houver uma fonte de verdade de decisões compartilhada por vários repositórios que seja lida
automaticamente no PR.
