output "server_security_group_id" {
  value = aws_security_group.app_server.id
}

output "lb_security_group_id" {
  value = aws_security_group.load_balancer.id
}