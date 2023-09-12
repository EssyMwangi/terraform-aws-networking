# Common Variables

variable "region" {
    description = "default region for resources"
    type = string  
}

variable "tags" {
    description = "Tags for resources"
    type = map(string)
}

variable "project" {
    description = "Project Name"
    type = string
}


# Networking Variables
variable "vpc_cidr" {
    description = "CIDR for the VPC"
    type = string
}


variable "public_subnet_cidrs" {
    description = "CIDRs for the Public subnets"
    type = list(string)
  
}

variable "private_subnet_cidrs" {
    description = "CIDRs for the Private subnets"
    type = list(string)
}

variable "private_data_subnet_cidrs" {
    description = "CIDRs for the Private subnets"
    type = list(string)
}


variable "map_public_ip_on_launch" {
    description = "Assign IP on Launch"
    type = bool
}

variable "connectivity_type" {
    description = "Connectivity Type for IGW"
    type = string
} 

