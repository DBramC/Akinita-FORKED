variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_host" {
  description = "Database host"
  type        = string
}