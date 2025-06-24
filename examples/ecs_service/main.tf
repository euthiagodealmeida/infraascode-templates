module "ecs_service" {
  source = "../../aws/ecs_service"

  service_name        = var.service_name
  cluster_id          = var.cluster_id
  task_definition_arn = var.task_definition_arn
  desired_count       = var.desired_count

  launch_type      = var.launch_type
  platform_version = var.platform_version

  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
  assign_public_ip   = var.assign_public_ip

  load_balancer_config              = var.load_balancer_config
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  service_registry_arn = var.service_registry_arn

  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  force_new_deployment               = var.force_new_deployment
  wait_for_steady_state              = var.wait_for_steady_state

  enable_execute_command = var.enable_execute_command
  propagate_tags         = var.propagate_tags

  tags = var.tags
}
