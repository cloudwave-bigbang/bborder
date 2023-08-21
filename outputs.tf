output "bb_prd_vpc_id" {
    value = module.bb_prd_vpc.vpc_id
}

output "bb_prd_web_sg" {
    value = module.bb_prd_sg.bb_prd_web_asg_sg_id
}

output "bb_prd_was_sg" {
    value = module.bb_prd_sg.bb_prd_was_asg_sg_id
}

output "bb_prd_pub_subnet_ids" {
    value = module.bb_prd_subnet.public_subnet_ids
}

output "bb_prd_pri_subnets_ids" {
    value = module.bb_prd_subnet.private_subnet_ids
}

output "bb_prd_acm_cert_arn" {
    value = module.bb_prd_acm.bb_prd_acm_cert_arn
}

output "bb_prd_was_alb_sg_id" {
    value = module.bb_prd_sg.bb_prd_web_asg_sg_id
}