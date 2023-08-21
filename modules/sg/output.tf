output "bb_prd_web_alb_sg_id" {
  description = "Security Group ID for bb-prd-web-alb-sg"
  value       = aws_security_group.bb-prd-web-alb-sg.id
}

output "bb_prd_pub_a_bastion_sg_id" {
  description = "Security Group ID for bb-prd-pub-a-bastion-sg"
  value       = aws_security_group.bb-prd-pub-a-bastion-sg.id
}

output "bb_prd_web_asg_sg_id" {
  description = "Security Group ID for bb-prd-web-asg-sg"
  value       = aws_security_group.bb-prd-web-asg-sg.id
}

output "bb_prd_was_alb_sg_id" {
  description = "Security Group ID for bb-prd-was-alb-sg"
  value       = aws_security_group.bb-prd-was-alb-sg.id
}

output "bb_prd_was_asg_sg_id" {
  description = "Security Group ID for bb-prd-was-asg-sg"
  value       = aws_security_group.bb-prd-was-asg-sg.id
}

output "bb_prd_rds_sg_id" {
  description = "Security Group ID for bb-prd-rds-sg"
  value       = aws_security_group.bb-prd-rds-sg.id
}