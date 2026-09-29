################################################################################
# Cache em memória
#
# Fica na 02 junto com o banco porque é dependência de runtime da aplicação:
# some o cache, a aplicação degrada — não é complemento opcional.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "aws_elasticache_subnet_group" "this" {
  name       = "${local.prefixo}-cache-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "this" {
  cluster_id         = "${local.prefixo}-cache"
  engine             = var.cache_config.engine
  node_type          = var.cache_config.node_type
  num_cache_nodes    = var.cache_config.num_nodes
  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = var.security_group_ids

  tags = {
    Name     = "${local.prefixo}-cache"
    resource = "cache"
  }
}
