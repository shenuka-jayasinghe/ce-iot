
resource "aws_security_group" "load_balancer" {
  name        = "load_balancer"
  description = "Security group for app servers"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "http_ipv6_lb" {
  security_group_id = aws_security_group.load_balancer.id

  cidr_ipv6   = "::/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "http_ipv4_lb" {
  security_group_id = aws_security_group.load_balancer.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}


resource "aws_vpc_security_group_ingress_rule" "ssh_lb" {
  security_group_id = aws_security_group.load_balancer.id

  cidr_ipv4   = "${chomp(data.http.myipaddr.response_body)}/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv6_lb" {
  security_group_id = aws_security_group.load_balancer.id

  cidr_ipv6   = "::/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "outgoing_ipv4_lb" {
  security_group_id = aws_security_group.load_balancer.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

