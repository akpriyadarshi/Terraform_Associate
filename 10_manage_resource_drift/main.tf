terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"

}

resource "aws_s3_bucket" "bucket" {
  
}


resource "aws_instance" "my_server" {
 
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  

  tags = {
    Name = "My_Server"
  }
}






output "EC2_IP" {
  value = aws_instance.my_server.public_ip
}




/* commands that i ran
terraform apply -refresh-only
terraform apply -replace="aws_instance.my_server"
terraform import aws_s3_bucket.bucket my-s3-terraform-import
*/