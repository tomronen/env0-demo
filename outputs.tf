output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.loadbalancer.alb_dns_name
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.compute.instance_public_ip
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "another_instance_public_ip" {
  description = "Public IP of the another EC2 instance"
  value       = module.compute.another_instance_public_ip
}
