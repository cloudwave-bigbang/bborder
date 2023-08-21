terraform {
  backend "s3" {
      bucket  = "bb-s3-tfstate"
      key     = "terraform.tfstate"
      region  = "ap-northeast-2"
      encrypt = true
    }
}
