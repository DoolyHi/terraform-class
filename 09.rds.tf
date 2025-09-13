resource "aws_db_subnet_group" "terraform-rds-subnet-group" {
  name       = "terraform-rds-subnet-group"
  subnet_ids = [aws_subnet.terraform-pri-subnet-2a.id, aws_subnet.terraform-pri-subnet-2c.id]

  tags = {
    Name = "terraform-rds-subnet-group"
  }
}
resource "aws_db_parameter_group" "terraform-mariadb-parameter-group" {
  name        = "terraform-mariadb-parameter-group"
  family      = "mariadb10.11" # 사용 중인 MariaDB 버전에 맞게 조정
  description = "Custom parameter group for MariaDB"

  parameter {
    name  = "max_connections"
    value = "150"
  }

  parameter {
    name  = "time_zone"
    value = "Asia/Seoul"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_filesystem"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8mb4_unicode_ci"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }


  parameter {
    name  = "binlog_format"
    value = "ROW"
  }
}
#RDS 생성
resource "aws_db_instance" "terraform-mariadb-rds" {
  identifier_prefix    = "terraform-mariadb-rds"
  allocated_storage    = 10
  engine               = "mariadb"
  engine_version       = "10.11.8"
  instance_class       = "db.t3.micro"
  db_name              = "terraform_mariadb_rds"
  username             = "root"     ### 수정
  password             = "Password1234"     ### 수정
  parameter_group_name = "terraform-mariadb-parameter-group"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.terraform-rds-subnet-group.name
  vpc_security_group_ids = [aws_security_group.terraform-sg-rds.id]

  tags = {
    Name = "terraform-mariadb-rds"
  }
}