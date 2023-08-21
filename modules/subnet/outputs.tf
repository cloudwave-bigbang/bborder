output "public_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.public_subnets.*.id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = aws_subnet.private_subnets.*.id
}

output "internet-gateway-id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.bb-prd-igw.id
}

######### eip와 nat는 리스트에 담으면 output에 출력되지 않음 #########
output "eip-nat-a" {
  description = "Elastic IP associated with NAT gateway A"
  value       = aws_eip.bb-prd-nat-a.id
}

output "eip-nat-c" {
  description = "Elastic IP associated with NAT gateway C"
  value       = aws_eip.bb-prd-nat-c.id
}

output "nat-gateway-a-id" {
  description = "The ID of NAT Gateway A"
  value       = aws_nat_gateway.bb-prd-nat-a.id
}

output "nat-gateway-c-id" {
  description = "The ID of NAT Gateway C"
  value       = aws_nat_gateway.bb-prd-nat-c.id
}