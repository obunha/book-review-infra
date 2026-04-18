resource "aws_db_subnet_group" "mysql" {
  name       = "${var.application_name}-${var.environment}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.application_name}-${var.environment}-db-subnet-group"
  }
}

resource "aws_security_group" "mysql" {
  name        = "${var.application_name}-${var.environment}-mysql-sg"
  vpc_id      = var.vpc_id
  description = "MySQL security group"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.backend_security_group_id]
    description     = "MySQL from backend"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.application_name}-${var.environment}-mysql-sg"
  }
}

resource "aws_db_instance" "mysql" {
  identifier     = "bookreview-${var.environment}-mysql"
  engine         = "mysql"
  engine_version = "5.7"
  instance_class = "db.t3.micro"

  db_name  = var.mysql_database_name
  username = var.mysql_admin_username
  password = var.mysql_admin_password

  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.mysql.id]

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_encrypted     = false

  skip_final_snapshot = true
  publicly_accessible = false

  tags = {
    Name = "${var.application_name}-${var.environment}-mysql"
  }
}
