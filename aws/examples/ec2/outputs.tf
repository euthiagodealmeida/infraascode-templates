output "instance_id" {
  description = "EC2 instance ID"
  value       = module.lab-ec2.instance_id
}

output "public_ip" {
  description = "Public IP address of the web server"
  value       = module.lab-ec2.public_ip
}

output "private_ip" {
  description = "Private IP address of the web server"
  value       = module.lab-ec2.private_ip
}

output "public_dns" {
  description = "Public DNS name of the web server"
  value       = module.lab-ec2.public_dns
}

output "web_server_url" {
  description = "URL to access the web server"
  value       = "http://${module.lab-ec2.public_ip}"
}

output "web_server_dns_url" {
  description = "URL to access the web server using DNS"
  value       = "http://${module.lab-ec2.public_dns}"
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ec2-user@${module.lab-ec2.public_ip}"
}

output "security_group_id" {
  description = "Security group ID"
  value       = module.lab-ec2.security_group_id
}

output "availability_zone" {
  description = "Availability zone where the instance is running"
  value       = module.lab-ec2.availability_zone
}

output "instance_details" {
  description = "Summary of the deployed web server"
  value = {
    name              = var.instance_name
    type              = var.instance_type
    region            = var.aws_region
    availability_zone = module.lab-ec2.availability_zone
    public_ip         = module.lab-ec2.public_ip
    web_url           = "http://${module.lab-ec2.public_ip}"
  }
}