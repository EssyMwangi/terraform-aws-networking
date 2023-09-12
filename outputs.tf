
output "vpc_id"{
    description = "ID of the Main VPC"
    value = aws_vpc.main.id
}

output "private_subnet_id"{
    description = "Private Subnet ID"
    value = aws_subnet.private_app_subnet[*].id
}

output "public_subnet_id"{
    description = "Private Subnet ID"
    value = aws_subnet.public_subnet[*].id
}

output "igw_id" {
    description = "IGW ID"
    value = aws_internet_gateway.igw.id
}

output "nat_id" {
    description = "NAT gateway ID"
    value = aws_nat_gateway.nat_gateway.id
}

output "private_db_subnet" {
    description = "Private Db Subnets"
    value = aws_subnet.private_db_subnet[*].id
  
}



