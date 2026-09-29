env = "dev"

dominio = "dev.atlas.sandbox-cdb.local"

databases_config = {
  billing_mode         = "PAY_PER_REQUEST"
  point_in_time_backup = false
}

rds_config = {
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  multi_az          = false
  backup_retencao   = 1
  deletion_protect  = false
}

kubernetes_config = {
  versao         = "1.31"
  instance_types = ["t3.medium"]
  capacity_type  = "SPOT"
  min_size       = 0
  max_size       = 2
  desired_size   = 1
}

cache_config = {
  engine    = "memcached"
  node_type = "cache.t3.micro"
  num_nodes = 1
}

repositorios_imagem = ["api", "worker"]
