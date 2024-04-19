resource "aws_db_subnet_group" "example" {
  name = "subnet_security_gp"
   subnet_ids = aws_subnet.demo[*].id


  tags = {
    Name = "subnet_gp_name"
  }
}

resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow MySQL traffic to RDS instance"
  vpc_id      = aws_vpc.demo.id

  ingress {
    description = "MySQL from EC2"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust this CIDR block to limit access to specific IP ranges if needed
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = var.RDS_name
  username             = var.RDS_username
  password             = var.RDS_password
  parameter_group_name = "default.mysql5.7"
  identifier           = "wordpress-db"
  skip_final_snapshot  = true
  publicly_accessible = true
  vpc_security_group_ids = [aws_security_group.allow_mysql.id]
  db_subnet_group_name = aws_db_subnet_group.example.name
  depends_on = [
    aws_security_group.allow_mysql
  ]
}

