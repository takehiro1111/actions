#===================================
#Terraform block
#===================================
terraform {
  required_version = "1.6.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.30.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.4.1"
    }
  }
  // S3バケット未作成のため、一旦localで対応。
  backend "local" {
    path = "./backend/terraform-state"
  }
}


#===================================
#Provider block
#===================================
provider "aws" {
  region  = "ap-northeast-1"
  profile = "sekigaku"

  default_tags {
    tags = {
      Name       = local.servicename
      env        = local.env
      repository = local.repo
      directory  = local.directory
    }
  }
}

provider "http" {}

#===================================
#Provider block
#===================================
module "value" {
  source = "./modules/value/"
}

#===================================
#Data block
#===================================
data "aws_caller_identity" "current" {}

data "http" "myip" {
  url = "http://ifconfig.me/"
} 