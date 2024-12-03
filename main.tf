terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

resource "random_id" "instance_id" {
  byte_length = 4
}

provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}
