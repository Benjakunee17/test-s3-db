/**
 * Create by : Benja kuneepong
 * Date : Mon, Sep  4, 2023  5:19:03 PM
 * Purpose : สร้าง subnet group สำหรับ aurora DB
 */

resource "aws_db_subnet_group" "main" {
  name       = "${var.service_name}-${var.system_name}-${terraform.workspace}-aurora-rds-subnet-group"
  subnet_ids = [var.subnet_secure_b, var.subnet_secure_c]

  tags = {
    Name = "${var.service_name}-${var.system_name}-${terraform.workspace}-aurora-subnet-group-website-laos"
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Mon, Sep  4, 2023  5:19:03 PM
 * Purpose : สร้าง parameter group สำหรับ aurora DB
 */
resource "aws_rds_cluster_parameter_group" "main" {
  name        = "${var.service_name}-${var.system_name}-${terraform.workspace}-aurora-rds-parameter-group"
  description = "RDS aurora default cluster parameter group for exta"
  family      = "aurora-mysql8.0"

#  lifecycle {
#    ignore_changes = all
#  }

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  parameter {
    name         = "time_zone"
    value        = "Asia/Bangkok"
    apply_method = "pending-reboot"
  }
}


/**
 * Create by : Benja kuneepong
 * Date : Mon, Sep  4, 2023  5:19:03 PM
 * Purpose : สร้าง aurora DB
 */
resource "aws_rds_cluster" "main" {
  cluster_identifier              = "${var.service_name}-${var.system_name}-${terraform.workspace}-aurora-rds"
  engine                          = "aurora-mysql"
  engine_version                  = var.aurora_version
  master_username                 = var.aurora_master_username
  master_password                 = var.aurora_master_password
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.main.id
  db_subnet_group_name            = aws_db_subnet_group.main.id
  vpc_security_group_ids          = [aws_security_group.aurora_db_sg.id]
  backup_retention_period         = 7
  preferred_backup_window         = "17:30-19:30"
  copy_tags_to_snapshot           = true
  skip_final_snapshot             = true

#  lifecycle {
#    ignore_changes = all
#  }
}

/**
 * Create by : Benja kuneepong
 * Date : Mon, Sep  4, 2023  5:19:03 PM
 * Purpose : สร้าง cluster writer สำหรับ aurora DB
 */
resource "aws_rds_cluster_instance" "cluster_instances" {
  count                        = 1
  identifier                   = "${var.service_name}-${var.system_name}-${terraform.workspace}-aurora-rds-instance"
  cluster_identifier           = aws_rds_cluster.main.id
  instance_class               = var.aurora_instance_type
  engine                       = aws_rds_cluster.main.engine
  engine_version               = aws_rds_cluster.main.engine_version
  performance_insights_enabled = var.aurora_performance_insights_enabled
  ca_cert_identifier          = var.aurora_ca_cert
  copy_tags_to_snapshot        = true
  apply_immediately            = true
  promotion_tier               = 0

#  lifecycle {
#    ignore_changes = all
#  }

  tags = {
    Name = "${var.service_name}-${var.system_name}-${terraform.workspace}-aurora-rds-website-laos"
    DailyBackup = "Daily1"
  }
}
