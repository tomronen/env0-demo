output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = aws_security_group.ec2.id
}

output "another_instance_id" {
  description = "ID of the another EC2 instance"
  value       = aws_instance.another_instance.id
}

output "another_instance_public_ip" {
  description = "Public IP of the another EC2 instance"
  value       = aws_instance.another_instance.public_ip
}
