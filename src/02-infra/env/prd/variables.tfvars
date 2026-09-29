env = "prd"

dominio = "prd.atlas.sandbox-cdb.local"

databases_config = {
  billing_mode         = "PAY_PER_REQUEST"
  point_in_time_backup = true
}

rds_config = {
  engine            = "postgres"
  instance_class    = "db.t3.small"
  allocated_storage = 50
  multi_az          = true
  backup_retencao   = 30
  deletion_protect  = true
}

kubernetes_config = {
  versao         = "1.31"
  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"
  min_size       = 2
  max_size       = 4
  desired_size   = 2
}

cache_config = {
  engine    = "memcached"
  node_type = "cache.t3.micro"
  num_nodes = 2
}

repositorios_imagem = ["api", "worker"]
