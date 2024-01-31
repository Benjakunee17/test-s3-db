/**
 * Create by : Benja kuneepong
 * Date : Wed, Aug 30, 2023  4:57:13 PM
 * Purpose : ใช้สำหรับอนุญาติให้ traffic ทั้งหมดเข้า EC2 linux ได้
 */
resource "aws_security_group" "ec2_linux" {
  name        = "${var.service_name}-${var.system_name}-ec2-linux-${var.environment}-securitygroup"
  description = "Allow ssh traffic to EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["10.0.0.0/8"]
  }

 ingress {
    description      = "Allow all inside subnet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = []
    self             = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-${var.system_name}-ec2-linux-${var.environment}-securitygroup"
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Wed, Aug 30, 2023  4:57:13 PM
 * Purpose : ใช้สำหรับอนุญาติให้ traffic ทั้งหมดเข้า EC2 ด้วย protocol web ได้
 */
resource "aws_security_group" "ec2_web" {
  name        = "${var.service_name}-${var.system_name}-ec2-web-${var.environment}-securitygroup"
  description = "Allow web traffic to EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow all"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow all"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.service_name}-${var.system_name}-ec2-web-${var.environment}-securitygroup"
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Wed, Aug 30, 2023  4:57:13 PM
 * Purpose : ใช้สำหรับอนุญาติให้ port 3306 เข้า database ได้
 */
resource "aws_security_group" "aurora_db_sg" {
  name_prefix = "aurora-db-sg"
  description = "Security group for Aurora database"
  vpc_id      = var.vpc_id

  # Allow incoming traffic from the IP address range of the Aurora database
  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.151.23.0/24"]
  }

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = ["${aws_security_group.ec2_linux.id}"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  # Attach the security group to an EC2 instance or RDS instance running the Aurora database
  # Replace this with the actual resource ID of your Aurora database instance
  tags = {
    Name = "aurora-db-sg"
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Wed, Aug 30, 2023  4:57:13 PM
 * Purpose : ใช้สำหรับอนุญาติให้ traffic จาก ALB เข้ามาได้ผ่าน port 80 และ 443
 */
resource "aws_security_group" "alb_sg" {
  name        = "alb_security_group"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  # Define inbound rules as per your requirements
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Define inbound rules as per your requirements
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outgoing traffic to anywhere
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
