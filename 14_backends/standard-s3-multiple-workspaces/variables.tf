variable "vpc_id"{
   type = string
}

variable "public_key" {
  type = string
}

variable "instance_type" {
  type = string
  
}

variable "server_name" {
  type = string
  
}

/*
variable "workspace_iam_roles" {
  default = {
    staging = "arn:aws:iam::STAGING-ACCOUNT-ID:role/Terraform"
    disaster-recovery = "arn:aws:iam::STAGING-ACCOUNT-ID:role/Terraform"
    production = "arn:aws:iam::STAGING-ACCOUNT-ID:role/Terraform"
  }
}
*/  # use this when using multiple aws account