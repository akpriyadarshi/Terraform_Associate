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
  public_key = "XXXXXXXXXXXXXXXX" # Place your public key here
}


resource "aws_instance" "my_server" {
 
  ami           = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  key_name = "${aws_key_pair.deployer.key_name}"
  

  tags = {
    Name = "MyServer"
  }

  lifecycle {
    prevent_destroy = false
  }
}


output "EC2_IP" {
  value = aws_instance.my_server.public_ip
}

