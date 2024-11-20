terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39"
    }
  }


}

provider "aws" {
 profile = var.aws_profile
 region  = var.aws_region
 default_tags {
   tags = {
     "teleport.dev/creator" = "scott@goteleport.com"
   }
 }
}
