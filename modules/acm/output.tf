output "bb_prd_acm_cert_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.bb-prd-acm-cert.arn
}