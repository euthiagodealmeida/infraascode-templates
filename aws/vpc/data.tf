data "aws_availability_zones" "available" {
  # Region will be determined by the provider configuration
  state = "available"
}