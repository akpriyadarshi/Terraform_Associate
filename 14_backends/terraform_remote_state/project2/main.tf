provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "vpc" {
backend = "local"
  config = {
    path = "../project1/terraform.tfstate"
   }
}

data "aws_vpc" "main"{
    id = data.terraform_remote_state.vpc.outputs.vpc_id
}

/*
# older version
data "aws_subnet_ids" "subnet_ids"{
    vpc_id = data.aws_vpc.main.id
}
*/

#for new versions
data "aws_subnets" "subnet_ids"{

   filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
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


resource "aws_instance" "my_server" {
 
  ami           = "ami-0aa7d40eeae50c9a9"
  #subnet_id = tolist(data.aws_subnet.subnet_ids.ids)[0]
  subnet_id = tolist(data.aws_subnets.subnet_ids.ids)[0]
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]

  tags = {
    Name = var.server_name
  }
}










