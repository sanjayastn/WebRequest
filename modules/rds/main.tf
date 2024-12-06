
# defining the rds module
resource "aws_db_instance" "rds" {
  allocated_storage      = var.allocated_storage
  instance_class         = var.instance_class
  engine                 = var.engine
  engine_version         = var.engine_version
  db_name                = var.rds_name
  username               = var.rds_username
  password               = var.rds_password
  parameter_group_name   = var.parameter_group_name
  publicly_accessible    = var.publicly_accessible
  vpc_security_group_ids = [var.rds_sg]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  multi_az               = var.multi_az
  skip_final_snapshot    = var.skip_final_snapshot

}

# defining subnet groups for rds
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.rds_subnet_group_name
  subnet_ids = var.subnet_ids

}


