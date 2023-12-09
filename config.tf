#===================================
#Terraform block
#===================================
terraform {
    required_version = "1.6.5"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "5.30.0"
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
    region = "ap-northeast-1"
    profile = "sekigaku"

    default_tags {
      tags = {
        Name = local.servicename
        env = local.env
        repository = local.repo
        directory = local.directory
      }
    }
}

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
