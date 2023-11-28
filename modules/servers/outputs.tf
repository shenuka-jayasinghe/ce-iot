output "instance_ids" {
  value = aws_instance.app_server[*].id
}

output "public_ips" {
  value = aws_instance.app_server[*].public_ip
}