resource "aws_vpc" "my_vpc" {
cidr_block = var.vpc_cidr
tags = {
Name = "Snehal-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
vpc-id = aws_vpc.my_vpc.id
}
resource "aws_subnet" "public_subnet" {
vpc-id = aws_subnet.public_subnet.id
cidr_block = var.public_subnet_cidr
map_public_ip_on_launch = true
}
resource "aws_subnet" "private_subnet" {
vpc_id = aws_vpc.my_vpc.id
cidr_block = var.private_subnet_cidr
tags = {
Name = "Private-subnet"
   }
}
resource "aws_route_table" "public_rt" {
vpc_id = aws_vpc.my_vpc.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_association" {
subnet_id = aws_subnet.public_subnet.id
route_table_id = aws_route_table.public_rt.id
}

