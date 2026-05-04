resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "subnets" {
  count      = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"
}

resource "aws_ecs_cluster" "main" {
  name = "akinita-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "akinita-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  container_definitions = jsonencode([{
    name  = "akinita-app"
    image = "ds-lab-2024:latest"
    portMappings = [{ containerPort = 8080 }]
    environment = [
      { name = "SPRING_DATASOURCE_PASSWORD", value = var.db_password },
      { name = "SPRING_DATASOURCE_USERNAME", value = var.db_username },
      { name = "SPRING_DATASOURCE_URL", value = "jdbc:postgresql://${var.db_host}:5432/akinita" }
    ]
  }])
}