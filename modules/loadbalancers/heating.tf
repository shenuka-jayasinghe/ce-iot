resource "aws_lb_target_group" "heating_target_group" {
  name     = "heating-target-group"
  port     = 3000
  protocol = "HTTP"
  protocol_version = "HTTP1"
  vpc_id   = var.vpc_id
  health_check {
    port     = 3000
    protocol = "HTTP"
    path = "/api/heating/healthcheck"
  }
}

resource "aws_lb_target_group_attachment" "heating_tg_attachment" {
  target_group_arn = aws_lb_target_group.heating_target_group.arn
  target_id        = var.instance_ids[0]
  port             = 3000
  
}

resource "aws_lb_listener_rule" "heating_rule" {
  listener_arn = aws_lb_listener.microservice.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.heating_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/heating/*"]
    }
  }
}

