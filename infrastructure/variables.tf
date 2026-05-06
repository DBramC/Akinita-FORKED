variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "execution_role_arn" {
  description = "IAM Role for ECS Execution"
  type        = string
}

variable "image_url" {
  description = "ECR or Registry image path"
  type        = string
}

variable "db_url" {
  type      = string
  sensitive = true
}

variable "db_user" {
  type      = string
  sensitive = true
}

variable "db_pass" {
  type      = string
  sensitive = true
}