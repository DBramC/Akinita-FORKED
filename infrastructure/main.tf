resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = { ManagedBy = "Bram Vortex", Project = "Akinita" }
}

resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.app_name}-cluster"
}

resource "aws_iam_role" "execution_role" {
  name = "${var.app_name}-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "ecs-tasks.amazonaws.com" } }]
  })
}

resource "aws_ecs_task_definition" "app" {
  family                   = var.app_name
  cpu                      = var.cpu
  memory                   = var.memory
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.execution_role.arn
  container_definitions = jsonencode([{
    name      = "${var.app_name}-container"
    image     = "placeholder"
    portMappings = [{ containerPort = var.container_port }]
    environment = [
      { name = "SERVER_PORT", value = "8080" },
      { name = "SPRING_DATASOURCE_URL", value = var.db_url },
      { name = "SPRING_DATASOURCE_USERNAME", value = var.db_username },
      { name = "SPRING_DATASOURCE_PASSWORD", value = var.db_password },
      { name = "JAVA_TOOL_OPTIONS", value = "-Xms512m -Xmx1024m -XX:+UseG1GC" }
    ]
  }])
}

resource "aws_lb" "main" {
  name               = "${var.app_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id
}