#모듈의 변수 쓰는 법 module.모듈의 이름.그 모듈이 쓰는 resource의 output의 이름

provider "aws" {
    region = "ap-northeast-2"
}

module "bb_prd_vpc" {
    source               = "./modules/vpc"
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
        Name = "bb-prd-vpc"
    }
}

module "bb_prd_subnet" {
    source = "./modules/subnet"
    vpc_id = module.bb_prd_vpc.vpc_id
}

module "bb_prd_sg" {
    source = "./modules/sg"
    vpc_id = module.bb_prd_vpc.vpc_id
}

module "bb_prd_template" {
    source = "./modules/template"
    web_security_groups = [module.bb_prd_sg.bb_prd_web_asg_sg_id]
    was_security_groups = [module.bb_prd_sg.bb_prd_was_asg_sg_id]
    #TODO: usedata path를 s3한테서 받아서 보내준다라는 컨셉 추가
}

module "bb_prd_acm" {
    source = "./modules/acm"
}

module "bb_prd_alb" {
    source = "./modules/alb"
    vpc_id = module.bb_prd_vpc.vpc_id
    bb_prd_web_alb_sg_id = [module.bb_prd_sg.bb_prd_web_asg_sg_id]
    public_subnet_ids = module.bb_prd_subnet.public_subnet_ids
    private_subnet_ids = [module.bb_prd_subnet.private_subnet_ids[0], module.bb_prd_subnet.private_subnet_ids[1]]
    bb_prd_acm_cert_arn = module.bb_prd_acm.bb_prd_acm_cert_arn
    bb_prd_was_alb_sg_id = [module.bb_prd_sg.bb_prd_web_asg_sg_id]
}

module "bb_prd_was" {
    source = "./modules/was"
    launch_configuration    = module.bb_prd_template.bb_prd_was_tmp_launch_configuration_name
    private_subnet_ids      = [module.bb_prd_subnet.private_subnet_ids[0], module.bb_prd_subnet.private_subnet_ids[1]]
    lb_target_group_arn     = module.bb_prd_alb.bb_prd_was_alb_tg_arn
}

module "bb_prd_web" {
    source = "./modules/web"
    launch_configuration    = module.bb_prd_template.bb_prd_web_tmp_launch_configuration_name
    private_subnet_ids      = [module.bb_prd_subnet.private_subnet_ids[0], module.bb_prd_subnet.private_subnet_ids[1]]
    lb_target_group_arn     = module.bb_prd_alb.bb_prd_web_alb_tg_arn
}
/*
module "bb_prd_rds" {
    source = "./modules/rds"
    #b-02, a-02, c-02 <-- index 순서
    private_subnet_ids      = [module.bb_prd_subnet.private_subnet_ids[2], module.bb_prd_subnet.private_subnet_ids[3], module.bb_prd_subnet.private_subnet_ids[4]] 
}
*/