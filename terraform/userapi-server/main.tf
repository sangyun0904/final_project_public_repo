terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
  
}

provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_vpc" "Kim-vpc" {
    cidr_block = "10.11.0.0/16"
}