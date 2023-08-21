variable "vpc_id" {}

variable "availability_zone_prefix" {
    description = "The prefix of the availability zone"
    type        = string
    default     = "ap-northeast-2"    
}

variable "public_subnets" {
  description = "Public subnets"
  default = [
    {
      name              = "bb-prd-sub-pub-a-01",
      cidr_block        = "10.0.0.0/28",
      availability_zone = "a"
    },
    {
      name              = "bb-prd-sub-pub-c-01",
      cidr_block        = "10.0.16.0/28",
      availability_zone = "c"
    }
  ]
}

variable "private_subnets" {
  description = "Private subnets"
  default = [
    {
      name              = "bb-prd-sub-pri-a-01",
      cidr_block        = "10.0.128.0/28",
      availability_zone = "a"
    },
    {
      name              = "bb-prd-sub-pri-c-01",
      cidr_block        = "10.0.144.0/28",
      availability_zone = "c"
    },
    {
      name              = "bb-prd-sub-pri-b-02",
      cidr_block        = "10.0.192.0/28",
      availability_zone = "b"
    },
    {
      name              = "bb-prd-sub-pri-a-02",
      cidr_block        = "10.0.160.0/28",
      availability_zone = "a"
    },
    {
      name              = "bb-prd-sub-pri-c-02",
      cidr_block        = "10.0.176.0/28",
      availability_zone = "c"
    }
  ]
}