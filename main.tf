provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "fiap-tech-challenge-terraform-state"
    key            = "vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

resource "aws_vpc" "vpc-eks" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

resource "aws_subnet" "subnet-vpc-eks" {
  count      = 2
  vpc_id     = aws_vpc.vpc-eks.id
  cidr_block = cidrsubnet(aws_vpc.vpc-eks.cidr_block, 8, count.index)

  tags = {
    Name = "${var.cluster_name}-subnet-${count.index}"
  }
}
