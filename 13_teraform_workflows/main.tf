terraform {
    backend "remote" {
      hostname = "app.terraform.io"
      organization = "KnoldusAkash"
      workspaces {
        name = "vcs-terraform"
      }
    }
  
}

provider "aws" {
  # Configuration options
  region = "us-east-1"

}

resource "aws_s3_bucket" "bucket"{

 bucket = "vcs-${uuid()}"
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
