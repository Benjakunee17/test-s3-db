# test-s3-db
# step.1 create s3 
# step.2 migate state terraform to s3
# step.3 provision rds aurora and security group
if want to delete 
s3.tf
  lifecycle {
     prevent_destroy = false
   }
