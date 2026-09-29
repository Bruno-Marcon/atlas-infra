################################################################################
# Banco relacional
#
# A senha nasce aqui e vai direto para o cofre: nunca passa por tfvars, por
# variável de ambiente nem pelo state em texto claro legível por humano.
# Rotação posterior acontece fora do Terraform — por isso o ignore_changes.
################################################################################
locals {
  prefixo = "${var.platform}-${var.application}-${var.env}"
}

resource "random_password" "banco" {
  length           = 32
  special          = true
  override_special = "!#%*-_=+"
}

resource "aws_db_subnet_group" "this" {
  name       = "${local.prefixo}-db-subnet"
  subnet_ids = var.subnet_ids

  tags = {
    Name     = "${local.prefixo}-db-subnet"
    resource = "database"
  }
}

resource "aws_db_instance" "principal" {
  identifier = "${local.prefixo}-db"

  engine         = var.rds_config.engine
  instance_class = var.rds_config.instance_class

  allocated_storage = var.rds_config.allocated_storage
  storage_encrypted = true

  db_name  = replace("${var.application}_${var.env}", "-", "_")
  username = "adminapp"
  password = random_password.banco.result

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.security_group_ids

  multi_az                = var.rds_config.multi_az
  backup_retention_period = var.rds_config.backup_retencao
  deletion_protection     = var.rds_config.deletion_protect
  skip_final_snapshot     = var.env != "prd"

  lifecycle {
    ignore_changes = [password]
  }

  tags = {
    Name     = "${local.prefixo}-db"
    resource = "database"
  }
}

resource "aws_secretsmanager_secret" "banco" {
  name        = "${local.prefixo}-secret-db"
  description = "Credenciais do banco ${aws_db_instance.principal.identifier}"

  tags = {
    Name     = "${local.prefixo}-secret-db"
    resource = "secret"
  }
}

resource "aws_secretsmanager_secret_version" "banco" {
  secret_id = aws_secretsmanager_secret.banco.id

  secret_string = jsonencode({
    username = aws_db_instance.principal.username
    password = random_password.banco.result
    host     = aws_db_instance.principal.address
    port     = aws_db_instance.principal.port
    dbname   = aws_db_instance.principal.db_name
  })
}
