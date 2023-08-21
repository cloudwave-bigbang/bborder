output "bb_prd_web_alb_arn" {
  description = "The ARN of the web application load balancer."
  value       = aws_lb.bb-prd-web-alb.arn
}

output "bb_prd_web_alb_dns_name" {
  description = "The DNS name of the web application load balancer."
  value       = aws_lb.bb-prd-web-alb.dns_name
}

output "bb_prd_web_alb_zone_id" {
  description = "The canonical hosted zone ID of the web application load balancer (to be used in a Route 53 Alias record)."
  value       = aws_lb.bb-prd-web-alb.zone_id
}

output "bb_prd_web_alb_tg_arn" {
  description = "The ARN of the target group for the web application load balancer."
  value       = aws_lb_target_group.bb-prd-web-alb-tg.arn
}

output "bb_prd_web_alb_tg_name" {
  description = "The name of the target group for the web application load balancer."
  value       = aws_lb_target_group.bb-prd-web-alb-tg.name
}

output "bb_prd_web_alb_ln_01_arn" {
  description = "The ARN of the listener for the web application load balancer."
  value       = aws_lb_listener.bb-prd-web-alb-ln-01.arn
}

output "bb_prd_web_alb_ln_02_arn" {
  description = "The ARN of the listener for the web application load balancer."
  value       = aws_lb_listener.bb-prd-web-alb-ln-02.arn
}

output "bb_prd_web_alb_ln_01_default_action" {
  description = "The default action type (e.g., `forward`) for the listener."
  value       = aws_lb_listener.bb-prd-web-alb-ln-01.default_action[0].type
}

output "bb_prd_web_alb_ln_02_default_action" {
  description = "The default action type (e.g., `forward`) for the listener."
  value       = aws_lb_listener.bb-prd-web-alb-ln-02.default_action[0].type
}

output "bb_prd_was_alb_arn" {
  description = "The ARN of the was application load balancer."
  value       = aws_lb.bb-prd-was-alb.arn
}

output "bb_prd_was_alb_dns_name" {
  description = "The DNS name of the was application load balancer."
  value       = aws_lb.bb-prd-was-alb.dns_name
}

output "bb_prd_was_alb_zone_id" {
  description = "The canonical hosted zone ID of the was application load balancer (to be used in a Route 53 Alias record)."
  value       = aws_lb.bb-prd-was-alb.zone_id
}

output "bb_prd_was_alb_tg_arn" {
  description = "The ARN of the target group for the was application load balancer."
  value       = aws_lb_target_group.bb-prd-was-alb-tg.arn
}

output "bb_prd_was_alb_tg_name" {
  description = "The name of the target group for the was application load balancer."
  value       = aws_lb_target_group.bb-prd-was-alb-tg.name
}

output "bb_prd_was_alb_ln_01_arn" {
  description = "The ARN of the listener for the was application load balancer."
  value       = aws_lb_listener.bb-prd-was-alb-ln-01.arn
}

output "bb_prd_was_alb_ln_02_arn" {
  description = "The ARN of the listener for the was application load balancer."
  value       = aws_lb_listener.bb-prd-was-alb-ln-02.arn
}

output "bb_prd_was_alb_ln_01_default_action" {
  description = "The default action type (e.g., `forward`) for the listener."
  value       = aws_lb_listener.bb-prd-was-alb-ln-01.default_action[0].type
}

output "bb_prd_was_alb_ln_02_default_action" {
  description = "The default action type (e.g., `forward`) for the listener."
  value       = aws_lb_listener.bb-prd-was-alb-ln-02.default_action[0].type
}