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

resource "aws_vpc" "main" {
    cidr_block = "10.11.0.0/16"
}

resource "aws_subnet" "public_subnets" {
 count      = length(var.public_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.public_subnet_cidrs, count.index)
 
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}
 
resource "aws_subnet" "private_subnets" {
 count      = length(var.private_subnet_cidrs)
 vpc_id     = aws_vpc.main.id
 cidr_block = element(var.private_subnet_cidrs, count.index)
 
 tags = {
   Name = "Private Subnet ${count.index + 1}"
 }
}