
data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    tags = merge(
        var.tags,{
            Name = "${var.region}-${var.project}-VPC"
        }
    )
  
}

# Public Subnets
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main.id
    count = length(var.public_subnet_cidrs)
    cidr_block = element(var.public_subnet_cidrs,count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = var.map_public_ip_on_launch
    tags = merge(
        var.tags,
        {
            Name = "${var.region}-${var.project}-public-subnet${count.index + 1}"
        }
    )
    
}


#Private Subnets 
#APP subnet

resource "aws_subnet" "private_app_subnet" {
    vpc_id = aws_vpc.main.id
    count = length(var.private_subnet_cidrs)
    cidr_block = element(var.private_subnet_cidrs,count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = false
    tags = merge(
        var.tags,{
            Name = "${var.region}-${var.project}-private-app-subnet${count.index + 1}"
        }
    )
}

resource "aws_subnet" "private_db_subnet" {
    vpc_id = aws_vpc.main.id
    count = length(var.private_subnet_cidrs)
    cidr_block = element(var.private_data_subnet_cidrs,count.index)
    #
    availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = merge(
        var.tags,{
            Name = "${var.region}-${var.project}-private-db-subnet${count.index + 1}"
        }
    )
}



#Internet gateway
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.main.id
    tags = merge(
        var.tags,
        {
            Name = "${var.region}-${var.project}-IGW"
        }
    )
}


#elastic IP for the NAT gateway
resource "aws_eip" "nat_eip" {
    vpc = true
}

resource "aws_nat_gateway" "nat_gateway"{
    subnet_id = aws_subnet.public_subnet[0].id
    allocation_id = aws_eip.nat_eip.id
    connectivity_type = var.connectivity_type


    tags = merge(
        var.tags,
        {
            Name = "${var.region}-${var.project}-NAT"
        }
    )

}
