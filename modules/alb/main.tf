resource "aws_lb" "bb-prd-web-alb" {
  name               = "bb-prd-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.bb_prd_web_alb_sg_id
  subnets            = var.public_subnet_ids
  enable_deletion_protection = false
  tags = {
    Name = "bb-prd-web-alb"
  }
}

resource "aws_lb_target_group" "bb-prd-web-alb-tg" {
  name        = "bb-prd-web-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  
    health_check {
        enabled             = true
        healthy_threshold   = 3
        interval            = 5
        matcher             = "200"
        path                = "/" 
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 2
        unhealthy_threshold = 2
    }
}

resource "aws_lb_listener" "bb-prd-web-alb-ln-01" {
  load_balancer_arn = aws_lb.bb-prd-web-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      protocol       = "HTTPS"
      port           = "443"
      status_code    = "HTTP_301" #영구 이동
    }
  }
}


resource "aws_lb_listener" "bb-prd-web-alb-ln-02" {
  load_balancer_arn = aws_lb.bb-prd-web-alb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.bb_prd_acm_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bb-prd-web-alb-tg.arn
  }
}

resource "aws_lb" "bb-prd-was-alb" {
  name               = "bb-prd-was-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.bb_prd_was_alb_sg_id
  #TODO: 나중에 variables에서 리스트로 하기
  subnets            = var.private_subnet_ids
  enable_deletion_protection = false
  tags = {
    Name = "bb-prd-was-alb"
  }
}



resource "aws_lb_target_group" "bb-prd-was-alb-tg" {
  name        = "bb-prd-was-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  
    health_check {
        enabled             = true
        healthy_threshold   = 3
        interval            = 5
        matcher             = "200"
        path                = "/" 
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = 2
        unhealthy_threshold = 2
    }
}

resource "aws_lb_listener" "bb-prd-was-alb-ln-01" {
  load_balancer_arn = aws_lb.bb-prd-was-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      protocol       = "HTTPS"
      port           = "443"
      status_code    = "HTTP_301" #영구 이동
    }
  }
}

resource "aws_lb_listener" "bb-prd-was-alb-ln-02" {
  load_balancer_arn = aws_lb.bb-prd-was-alb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.bb_prd_acm_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bb-prd-was-alb-tg.arn
  }
}