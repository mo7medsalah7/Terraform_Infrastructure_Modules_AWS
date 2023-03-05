

resource "aws_db_instance" "my_database" {
  instance_class         = "db.t2.small"
  identifier             = "itidb"
  engine                 = "mysql"
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  port                   = 3306
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  skip_final_snapshot    = true

}
