locals {
    subnets = {
        "pub" : ["a-01", "c-01"],
        "pri-a" : ["01", "02"],
        "pri-c" : ["01", "02"]
        "pri-b" : ["02"]
    }
}

######### Public Subnet #########
resource "aws_subnet" "public_subnets" {
    count                   = length(var.public_subnets)
    vpc_id                  = var.vpc_id
    cidr_block              = var.public_subnets[count.index].cidr_block
    availability_zone       = "${var.availability_zone_prefix}${var.public_subnets[count.index].availability_zone}"
    map_public_ip_on_launch = true
    tags = {
        Name = var.public_subnets[count.index].name
    }
}

######### Private Subnet 01 ~ 05 #########
resource "aws_subnet" "private_subnets" {
    count                   = length(var.private_subnets)
    vpc_id                  = var.vpc_id
    cidr_block              = var.private_subnets[count.index].cidr_block
    availability_zone       = "${var.availability_zone_prefix}${var.private_subnets[count.index].availability_zone}"
    tags = {
        Name = var.private_subnets[count.index].name
    }
}

######### Internet Gateway #########
resource "aws_internet_gateway" "bb-prd-igw" {
    vpc_id = var.vpc_id

    tags = {
        Name = "bb-prd-igw"
    }
}

######### NAT Gateway && EIP #########
resource "aws_eip" "bb-prd-nat-a" {
    vpc = true
}
resource "aws_eip" "bb-prd-nat-c" {
    vpc = true
}

resource "aws_nat_gateway" "bb-prd-nat-a" {
    allocation_id = aws_eip.bb-prd-nat-a.id
    subnet_id     = aws_subnet.public_subnets[0].id

    tags = {
        Name = "bb-prd-nat-a"
    }
}
resource "aws_nat_gateway" "bb-prd-nat-c" {
    allocation_id = aws_eip.bb-prd-nat-c.id
    subnet_id     = aws_subnet.public_subnets[1].id

    tags = {
        Name = "bb-prd-nat-c"
    }
}

######### route table && association #########
resource "aws_route_table" "bb-prd-rtb-pub" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bb-prd-igw.id
  }

  tags = {
    Name = "bb-prd-rtb-pub"
  }
}
resource "aws_route_table_association" "public" {
  count          = length(local.subnets.pub)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.bb-prd-rtb-pub.id
}

resource "aws_route_table" "private-a" {
  count  = length(local.subnets["pri-a"])
  
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.bb-prd-nat-a.id
  }
  tags = {
    Name = "bb-prd-rtb-pri-a-${local.subnets["pri-a"][count.index]}"
  }
}
resource "aws_route_table_association" "private-a" {
  count          = length(local.subnets["pri-a"])
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private-a[count.index].id
}

resource "aws_route_table" "private-c" {
  count  = length(local.subnets["pri-c"])
  
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.bb-prd-nat-c.id
  }
  tags = {
    Name = "bb-prd-rtb-pri-c-${local.subnets["pri-c"][count.index]}"
  }
}
resource "aws_route_table_association" "private-c" {
  count          = length(local.subnets["pri-c"])
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index + length(local.subnets["pri-a"]))
  route_table_id = aws_route_table.private-c[count.index].id
}