resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  username               = "springuser"
  password               = "password"
  port                   = 5432
  publicly_accessible    = false
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
}

resource "kubernetes_config_map" "db_config" {
  metadata {
    name = "db-config"
  }

  data = {
    SPRING_DATASOURCE_URL      = "jdbc:postgresql://${aws_db_instance.postgres.address}:5432/springdb"
    SPRING_DATASOURCE_USERNAME = "springuser"
    SPRING_DATASOURCE_PASSWORD = "password"
  }
}



resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = module.vpc.private_subnets
}

resource "aws_db_subnet_group" "db-sub-group" {
  name       = "db-sub-group"
  subnet_ids = module.vpc.private_subnets
}