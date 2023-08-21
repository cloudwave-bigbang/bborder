resource "aws_security_group" "bb-prd-pub-a-bastion-sg" {
    name            = "bb-prd-pub-a-bastion-sg"
    description     = "Allow web-alb-sg inbound traffic"
    vpc_id          = var.vpc_id

    ingress {
        description = "web from VPC"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "web from VPC"
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bb-prd-pub-a-bastion-sg"
    }
}

resource "aws_security_group" "bb-prd-web-alb-sg" {
    name        = "bb-prd-web-alb-sg"
    description = "Allow web-alb-sg inbound traffic"
    vpc_id      = var.vpc_id

    ingress {
        description = "web from VPC"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "web from VPC"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bb-prd-web-alb-sg"
    }
}

resource "aws_security_group" "bb-prd-web-asg-sg" {
    name        = "bb-prd-web-asg-sg"
    description = "Allow web-asg-sg inbound traffic"
    vpc_id      = var.vpc_id

    ingress {
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        security_groups = [aws_security_group.bb-prd-web-alb-sg.id] ## 기존 보안 그룹 참조 
    }
    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        security_groups = [aws_security_group.bb-prd-web-alb-sg.id] ## 기존 보안 그룹 참조 
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bb-prd-web-asg-sg"
    }
}

resource "aws_security_group" "bb-prd-was-alb-sg" {
    name        = "bb-prd-was-alb-sg"
    description = "Allow was-alb-sg inbound traffic"
    vpc_id      = var.vpc_id

    ingress {
        from_port       = 80   ## 8443
        to_port         = 80   ## 8443
        protocol        = "tcp"
        security_groups = [aws_security_group.bb-prd-web-asg-sg.id] 
    }

    ingress {
    from_port       = -1     
    to_port         = -1     
    protocol        = "icmp" 
    cidr_blocks     = ["0.0.0.0/0"] 
    }


    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bb-prd-was-alb-sg"
    }
}

resource "aws_security_group" "bb-prd-was-asg-sg" {
    name        = "bb-prd-was-asg-sg"
    description = "Allow was-asg-sg inbound traffic"
    vpc_id      = var.vpc_id

    ingress {
        from_port       = 80   ## 8443
        to_port         = 80   ## 8443
        protocol        = "tcp"
        security_groups = [aws_security_group.bb-prd-was-alb-sg.id] 
    }

    ingress {
    from_port       = -1     
    to_port         = -1     
    protocol        = "icmp" 
    cidr_blocks     = ["0.0.0.0/0"] 
    }


    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bb-prd-was-asg-sg"
    }
}

resource "aws_security_group" "bb-prd-rds-sg" {
    name        = "bb-prd-rds-sg"
    description = "Allow rds-sg inbound traffic"
    vpc_id      = var.vpc_id

    ingress {
        from_port       = 3306   
        to_port         = 3306
        protocol        = "tcp"
        security_groups = [aws_security_group.bb-prd-was-asg-sg.id] 
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bb-prd-rds-sg"
    }
}

resource "aws_security_group_rule" "bb-prd-rds-sg-rule" {
    type        = "ingress" // 인바운드 규칙
    from_port   = 3306 // 허용할 포트 범위
    to_port     = 3306
    protocol    = "tcp" // 프로토콜
    cidr_blocks = ["0.0.0.0/0"] // 허용할 IP 범위
    security_group_id = aws_security_group.bb-prd-rds-sg.id // 규칙을 적용할 보안 그룹 ID
}