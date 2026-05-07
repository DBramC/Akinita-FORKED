variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "ssh_public_key" {
  description = "Public key for EC2 access"
  type        = string
}

variable "instance_type" {
  default = "t3.medium"
}