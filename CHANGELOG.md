# Changelog

Formato: [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).

## [Não publicado]

### Adicionado
- Estrutura inicial em 5 camadas numeradas (00-foundation, 01-network-additional, 02-infra,
  03-infra-additional, 04-application), com backend S3 e lock em DynamoDB no emulador local.

### Adicionado (expansão de escopo)
- Camada 02: zona DNS privada, roles de cluster e de nó do EKS, banco relacional com senha
  gerada e guardada no cofre, cluster EKS + nodegroup, registro de imagens e cache em memória.
- Camada 03: provedor OIDC do cluster com roles por service account (IRSA), add-ons gerenciados
  (desligados no sandbox) e certificado TLS com validação por DNS.
- Camada 04: registros DNS da aplicação na zona do ambiente.
