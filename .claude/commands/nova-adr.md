---
description: Registra uma nova ADR em docs/adr/ a partir de uma decisão descrita em texto livre
argument-hint: <título curto da decisão>
---

Registre uma nova ADR para: **$ARGUMENTS**

1. Leia `docs/adr/README.md` (índice e regras) e `docs/adr/0000-template.md`
2. Descubra o próximo número: maior `NNNN-*.md` em `docs/adr/` + 1, com 4 dígitos
3. Se a decisão contradiz uma ADR `Aceita`, a nova ADR a **substitui**: preencha `Substitui:` na
   nova e mude o status da antiga para `Substituída por ADR-NNNN` — é a única edição permitida
   numa ADR já aceita
4. Preencha a partir do template, com evidência do código (caminho do arquivo) no Contexto.
   Status inicial: `Proposta`
5. Acrescente a linha na tabela de índice de `docs/adr/README.md`
6. Mostre o conteúdo ao usuário e só marque `Aceita` quando ele confirmar
