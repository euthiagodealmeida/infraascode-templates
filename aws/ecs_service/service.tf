resource "aws_ecs_service" "this" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count

  launch_type      = var.launch_type
  platform_version = var.launch_type == "FARGATE" ? var.platform_version : null

  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  force_new_deployment               = var.force_new_deployment
  wait_for_steady_state              = var.wait_for_steady_state

  health_check_grace_period_seconds = var.load_balancer_config != null ? var.health_check_grace_period_seconds : null

  enable_execute_command = var.enable_execute_command
  propagate_tags         = var.propagate_tags

  dynamic "network_configuration" {
    for_each = var.launch_type == "FARGATE" ? [1] : []
    content {
      subnets          = var.subnet_ids
      security_groups  = var.security_group_ids
      assign_public_ip = var.assign_public_ip
    }
  }

  dynamic "load_balancer" {
    for_each = var.load_balancer_config != null ? [var.load_balancer_config] : []
    content {
      target_group_arn = load_balancer.value.target_group_arn
      container_name   = load_balancer.value.container_name
      container_port   = load_balancer.value.container_port
    }
  }

  dynamic "service_registries" {
    for_each = var.service_registry_arn != null ? [1] : []
    content {
      registry_arn = var.service_registry_arn
    }
  }

  tags = merge(
    var.tags,
    {
      Name      = var.service_name
      ManagedBy = "opentofu"
    }
  )

  lifecycle {
    ignore_changes = [desired_count]
  }
}
