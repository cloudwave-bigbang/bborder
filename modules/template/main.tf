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

resource "aws_launch_configuration" "bb-prd-web-tmp" {
  #name_prefix   = "terraform-lc-example-"
  image_id      = data.aws_ami.amzn2.id
  instance_type = "t2.micro" #TODO: 모듈화하기
  #iam_instance_profile = "wantsomewalnut"
  security_groups    = var.web_security_groups
  #key_name = "bb-keypair"
  #니걸로 해
  user_data = file("/Users/park-ian/Downloads/module/modules/userdata/web-userdata.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "bb-prd-was-tmp" {
  #name_prefix   = "terraform-lc-example-"
  image_id      = data.aws_ami.amzn2.id
  instance_type = "t2.micro"
  #iam_instance_profile = "wantsomewalnut"
  security_groups    = var.was_security_groups
  #key_name = "bb-keypair"
  #니걸로 해
  user_data = file("/Users/park-ian/Downloads/module/modules/userdata/was-userdata.sh")

  lifecycle {
    create_before_destroy = true
  }
}