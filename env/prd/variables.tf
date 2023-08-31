variable "public_subnets" {
    description = "Public subnets"
    default = [
        {
        name              = "sub_pub_a_01",
        cidr_block        = "10.2.0.0/28",
        availability_zone = "a"
        },
        {
        name              = "sub_pub_c_01",
        cidr_block        = "10.2.16.0/28",
        availability_zone = "c"
        }
    ]
}

variable "private_subnets" {
  description = "Private subnets"
  default = [
    {
      name              = "sub_pri_a_01",
      cidr_block        = "10.2.128.0/28",
      availability_zone = "a"
    },
    {
      name              = "sub_pri_c_01",
      cidr_block        = "10.2.144.0/28",
      availability_zone = "c"
    },
    {
      name              = "sub_pri_a_02",
      cidr_block        = "10.2.160.0/28",
      availability_zone = "a"
    },
    {
      name              = "sub_pri_c_02",
      cidr_block        = "10.2.176.0/28",
      availability_zone = "c"
    }
  ]
}
