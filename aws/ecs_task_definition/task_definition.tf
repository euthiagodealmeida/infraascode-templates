resource "aws_ecs_task_definition" "this" {
  family                   = var.family
  network_mode             = var.network_mode
  requires_compatibilities = var.requires_compatibilities
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = var.container_definitions # TODO Use json files instead of inline JSON

  # TODO: Implement volume support for persistent storag

  tags = merge(
    var.tags,
    {
      Name      = var.family
      ManagedBy = "opentofu"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}
