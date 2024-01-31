/**
 * Create by : Benja kuneepong
 * Date : Wed, Aug 30, 2023  4:57:13 PM
 * Purpose : ประกาศตัวแปลเพื่อใช้ในแต่ละ resource
 */

awsprofile   = "cplwebsiteprd"
awsprofileid = "449640511956"
aws_region   = "ap-southeast-1"

owner_name     = "cpall"
system_name    = "webcpalaos"
service_name   = "new"
project_name   = ""
sr_name        = ""
environment    = "prd"
create_by_name = "Ms. benja kuneepong created by terraform for project website laos"

#cplwebsiteprd-vpc
vpc_id             = "vpc-0800f35c740fc0d12"
subnet_app_b       = "subnet-0d14b0705107d9681"
subnet_app_c       = "subnet-07a8dbbe8c3df4337"
subnet_nonexpose_b = "subnet-01831ddafaf775493"
subnet_nonexpose_c = "subnet-0efee252abd2438d9"
subnet_secure_b    = "subnet-0535fe5f9c6329ca1"
subnet_secure_c    = "subnet-042d045ca1f4ffaa0"

ec2_instance_image = "ami-0736ccda425a0af91" # Tec-MasterImage-20230821
ec2_instance_type  = "t3.medium"

aurora_version              = "8.0.mysql_aurora.3.04.0"
aurora_master_username      = "admin"
aurora_master_password      = "frXdckYzqtImlGWR"
aurora_instance_type        = "db.t4g.medium" # db.t4g.medium 2core 4GB
aurora_ca_cert              = "rds-ca-rsa4096-g1"

certificate_arn    = "arn:aws:acm:ap-southeast-1:449640511956:certificate/6f04759a-f8ef-4482-a02c-b7e90849db13" #www.cpalllaos.com
ssl_policy         = "ELBSecurityPolicy-FS-1-2-Res-2020-10"


#######################################
##RDS
#User : cpalaosadm
#Password : hiX0C5FHpxDmCda3lF6a
