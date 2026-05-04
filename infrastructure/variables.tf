variable "aws_region" { default = "us-east-1" }
variable "app_name" { default = "akinita" }
variable "cpu" { default = "1024" }
variable "memory" { default = "2048" }
variable "container_port" { default = 8080 }

variable "db_url" { type = string }
variable "db_username" { type = string }
variable "db_password" { type = string, sensitive = true }