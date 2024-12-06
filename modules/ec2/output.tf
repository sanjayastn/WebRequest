output "public_ips" {
  description = "Public IPs of EC2 instances"
  value       = aws_instance.ec2.public_ip
}

output "instance_id" {
  value = aws_instance.ec2.id
}
