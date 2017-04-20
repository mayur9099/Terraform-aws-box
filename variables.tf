variable "jenkins_iam_role_name" {
  default     = "jenkins_iam_role_name"
}

variable "base_iam_role_name" {
  default     = "base_iam_role"
}

variable "spinnaker_iam_role_name" {
  default     = "spinnaker_iam_role"
}

variable "properties_and_logging_iam_role_name" {
  default     = "properties_and_logging_iam_role"
}

variable "access_key" { 
  description = "AWS access key"
}

variable "secret_key" { 
  description = "AWS secret access key"
}

variable "region"     { 
  description = "AWS region to host your network"
  default     = "us-west-2" 
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.128.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.128.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "10.128.2.0/24"
}

/* amis by region */
variable "amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-west-2 = "ami-f173cc91" 
  }
}

variable "aws_spinnaker_amis" {
  description = "Base AMI to launch the instances with"
  default = {
    us-west-2 = "ami-fc69ea9c"
  }
}

