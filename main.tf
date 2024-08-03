provider "aws" {
  region = var.region
}

resource "aws_vpc" "vpc-eks" {
  cid_block = var.vpc_cidr

  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

resource "aws_subnet" "subnet-vpc-eks" {
  count      = 1
  vpc_id     = aws_vpc.vpc-eks.id
  cidr_block = cidrsubnet(aws_vpc.vpc-eks.cidr_block, 8, count.index)

  tags = {
    Name = "${var.cluster_name}-subnet-${count.index}"
  }
}
