output "subnet_ids" {
  value = aws_subnet.subnets[*].id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}