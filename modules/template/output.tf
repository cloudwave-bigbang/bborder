output "bb_prd_web_tmp_launch_configuration_name" {
  description = "The name of the web launch configuration."
  value       = aws_launch_configuration.bb-prd-web-tmp.name
}

output "bb_prd_web_tmp_launch_configuration_id" {
  description = "The ID of the web launch configuration."
  value       = aws_launch_configuration.bb-prd-web-tmp.id
}

output "bb_prd_was_tmp_launch_configuration_name" {
  description = "The name of the was launch configuration."
  value       = aws_launch_configuration.bb-prd-was-tmp.name
}

output "bb_prd_was_tmp_launch_configuration_id" {
  description = "The ID of the was launch configuration."
  value       = aws_launch_configuration.bb-prd-was-tmp.id
}