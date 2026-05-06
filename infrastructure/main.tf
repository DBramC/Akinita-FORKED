provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "main" {
  name = "akinita-cluster"
}

resource "aws_lb" "main" {
  name               = "main-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = []
  subnets            = var.subnet_ids
}

resource "aws_ecs_task_definition" "app" {
  family                   = "akinita-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([{
    name  = "akinita-app"
    image = "${var.image_url}:latest"
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
    environment = [
      { name = "SPRING_DATASOURCE_URL", value = var.db_url },
      { name = "SPRING_DATASOURCE_USERNAME", value = var.db_user },
      { name = "SPRING_DATASOURCE_PASSWORD", value = var.db_pass }
    ]
  }])
}