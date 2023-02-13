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

data "aws_vpc" "main"{
    id ="vpc-01792651f19e4bfa0" 
}

resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "my_server security group"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }
  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 
}




resource "aws_key_pair" "deployer" {
  key_name = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFpneEK8amRmCyB9eksG8nM4zVwPM33n/zEQR6cFWQgV3mhitRxdsM1MdR1JtmxMi9Qja24wHgxqFvyxN/X3ZU/rADC/aHDVW/XhqMQbjDOohRYEDSG+M1BuPbYCclwA+PuJ+HVa+FojCUvaf+0uGpWSGAz4QONDX2bbZ2R1EWlhxxYkOIHtQxc6pXJWcrEqGqccSPW51+KEzgew/n0UzmV92DL324bBPtTkVS+3YThxDUOeHD+gvRxbT7T6mA1z0kwRJEJMpOGxWDWMAANxFq/QL93iYPwfF/4hO0lLpUsgciI0r6MLfW2YUh7DU69d68XzULyhGJQ3oBAWDPq0ob knoldus@knoldus-Vostro-3590" # Place your public key here
}


data "template_file" "user_data"{
    template = file("./userdata.yaml")
}




resource "aws_instance" "my_server" {
 
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  key_name = "${aws_key_pair.deployer.key_name}"
  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "MyServer"
  }
}


output "EC2_IP" {
  value = aws_instance.my_server.public_ip
}

/*
terraform plan -out=my_saved_plan.plan
terraform apply my_saved_plan

*/