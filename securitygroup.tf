
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

