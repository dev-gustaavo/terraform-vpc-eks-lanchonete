output "vpc_id" {
  value = aws_vpc.vpc-eks.id
}

output "subnet_ids" {
  value = aws_subnet.subnet-vpc-eks[*].id
}
