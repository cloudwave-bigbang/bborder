resource "aws_acm_certificate" "bb-prd-acm-cert" {
  domain_name       = "*.bbrails.com"  # 등록할 도메인 입력
  validation_method = "EMAIL"

  tags = {
    Name = "bb-prd-acm-cert"
  }
}