################################################################################
# Registro de imagens
#
# Um repositório por componente. `scan_on_push` fica ligado sempre: imagem sem
# varredura entra no cluster sem ninguém saber o que tem dentro.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_ecr_repository" "componente" {
  for_each = toset(var.repositorios)

  name                 = "${local.prefixo}/${each.value}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name     = "${local.prefixo}-ecr-${each.value}"
    resource = "registry"
  }
}

resource "aws_ecr_lifecycle_policy" "componente" {
  for_each = aws_ecr_repository.componente

  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expira imagens sem tag"
        selection = {
          tagStatus   = "untagged"
          countType   = "imageCountMoreThan"
          countNumber = var.imagens_mantidas
        }
        action = { type = "expire" }
      }
    ]
  })
}
