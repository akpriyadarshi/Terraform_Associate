terraform {
  
}

provider "aws" {
  # Configuration options
  region = "us-east-1"

}


module "apache" {
  source = ".//terraform-aws-apache-example"
  vpc_id = "vpc-01792651f19e4bfa0"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFpneEK8amRmCyB9eksG8nM4zVwPM33n/zEQR6cFWQgV3mhitRxdsM1MdR1JtmxMi9Qja24wHgxqFvyxN/X3ZU/rADC/aHDVW/XhqMQbjDOohRYEDSG+M1BuPbYCclwA+PuJ+HVa+FojCUvaf+0uGpWSGAz4QONDX2bbZ2R1EWlhxxYkOIHtQxc6pXJWcrEqGqccSPW51+KEzgew/n0UzmV92DL324bBPtTkVS+3YThxDUOeHD+gvRxbT7T6mA1z0kwRJEJMpOGxWDWMAANxFq/QL93iYPwfF/4hO0lLpUsgciI0r6MLfW2YUh7DU69d68XzULyhGJQ3oBAWDPq0ob knoldus@knoldus-Vostro-3590"
  instance_type = "t2.micro"
  server_name = "Apache Example Server"
}

output "public_ip" {
  value = module.apache.EC2_IP
}