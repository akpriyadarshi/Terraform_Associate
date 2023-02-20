terraform {
  backend "s3"{
    bucket = "my-tf-state-bucket-aki"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}


provider "aws" {
  # Configuration options
  region = "us-east-1"
  #assume_role = "${var.workspace_iam_roles[terraform.workspace]}" /use this when using multiple aws account
    
  

}



module "apache" {
  source = "akpriyadarshi/apache-example/aws"
  vpc_id = var.vpc_id
  public_key = var.public_key
  instance_type = var.instance_type
  server_name = var.server_name
}

output "public_ip" {
  value = module.apache.EC2_IP
}




/* 

terraform workspace list
terraform workspace new staging
terraform workspace new production
terraform workspace select production
terraform workspace delete disaster-recovery
*/