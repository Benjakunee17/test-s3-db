# /**
#  * Create by : Benja kuneepong
#  * Date : Wed, Aug 30, 2023  4:57:13 PM
#  * Purpose : ประกาศว่าใช้ terraform version อะไรสำหรับ provider
#  */
 terraform {
   required_providers {
     aws = {
       source  = "hashicorp/aws"
       version = "4.67.0"
     }
   }
 }

/**
 * Create by : Benja kuneepong
 * Date : Wed, Aug 30, 2023  4:57:13 PM
 * Purpose : สร้าง bucket สำหรับเก็บ state ของ terraform
 */
terraform {
  backend "s3" {
    bucket  = "new-cpa-dev-terraform-state-bucket"
    key     = "terraform/dev/terraform.tfstate"
    region  = "ap-southeast-1"
    acl     = "bucket-owner-full-control"
    encrypt = true
    profile = "awscpadev"
  }
}

/**
 * Create by : Benja kuneepong
 * Date : Wed, Aug 30, 2023  4:57:13 PM
 * Purpose : กำหนด provider information
 */
provider "aws" {
  profile  = var.awsprofile
  region   = var.aws_region
  insecure = true

  default_tags {
    tags = {
      Owner   = var.owner_name
      Service = var.service_name
      System  = var.system_name
      Environment = "${var.environment}"
      Createby    = var.create_by_name
    }
  }
}
