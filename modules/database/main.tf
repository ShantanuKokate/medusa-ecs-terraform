resource "aws_db_instance" "medusa_db" {
  identifier              = "medusa-${var.environment}"
  engine                  = "postgres"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  vpc_security_group_ids  = [var.db_security_group_id]
  db_subnet_group_name    = aws_db_subnet_group.medusa_db_subnets.name
  skip_final_snapshot     = true
}

resource "aws_db_subnet_group" "medusa_db_subnets" {
  name       = "medusa-db-subnets-${var.environment}"
  subnet_ids = var.private_subnets
}

