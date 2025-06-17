resource "aws_ecs_cluster" "this" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  configuration {
    execute_command_configuration {
      logging = var.enable_execute_command ? "DEFAULT" : "NONE"
    }
  }

  tags = merge(
    var.tags,
    {
      Name      = var.cluster_name
      ManagedBy = "opentofu"
    }
  )
}
