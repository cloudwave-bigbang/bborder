resource "aws_iam_role" "bb_tmp_role" {
  name = "bb-${var.infra_env}-${var.tmp_name}-tmp-role"
  assume_role_policy = jsonencode({
  Version: "2012-10-17",
  Statement: [
    {
      Action: [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:ListBucket"
      ],
      Effect: "Allow",
      Resource: "*"
    }
  ]
})
  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "bb_tmp_profile" {
  name = "bb-${var.infra_env}-${var.tmp_name}-tmp-profile"
  role = aws_iam_role.bb_tmp_role.name
}

resource "aws_launch_template" "bb_tmp" {
  name = "bb-${var.infra_env}-${var.tmp_name}-tmp"
  image_id = data.aws_ami.amzn2.id
  instance_type = var.instance_type
  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.bb_tmp_profile.name
  }
  network_interfaces{
    security_groups     = var.security_groups
  }
  user_data           = filebase64sha256("${path.module}/../${var.path}")
  placement {
    availability_zone = "ap-northeast-2a"
  }
}

data "aws_ami" "amzn2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????.?-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"] # Canonical
}