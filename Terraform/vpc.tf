provider "aws" {
  region = var.region
}

resource "aws_vpc" "team2_vpc_2" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "team2-vpc-2"
  }
}

resource "aws_subnet" "team2_public_subnet_2" {
  vpc_id                  = aws_vpc.team2_vpc_2.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "team2-public-subnet-2"
  }
}

resource "aws_subnet" "team2_private_subnet_2" {
  vpc_id            = aws_vpc.team2_vpc_2.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name = "team2-private-subnet-2"
  }
}

resource "aws_internet_gateway" "team2_igw_2" {
  vpc_id = aws_vpc.team2_vpc_2.id

  tags = {
    Name = "team2-igw-2"
  }
}

resource "aws_route_table" "team2_public_rt_2" {
  vpc_id = aws_vpc.team2_vpc_2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.team2_igw_2.id
  }

  tags = {
    Name = "team2-public-rt-2"
  }
}

resource "aws_route_table_association" "team2_public_rt_assoc_2" {
  subnet_id      = aws_subnet.team2_public_subnet_2.id
  route_table_id = aws_route_table.team2_public_rt_2.id
}

resource "aws_eip" "team2_eip_2" {
  domain = "vpc"

  tags = {
    Name = "team2-eip-2"
  }
}

resource "aws_nat_gateway" "team2_nat_gateway_2" {
  allocation_id = aws_eip.team2_eip_2.id
  subnet_id     = aws_subnet.team2_public_subnet_2.id

  tags = {
    Name = "team2-nat-gateway-2"
  }
}

resource "aws_route_table" "team2_private_rt_2" {
  vpc_id = aws_vpc.team2_vpc_2.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.team2_nat_gateway_2.id
  }

  tags = {
    Name = "team2-private-rt-2"
  }
}

resource "aws_route_table_association" "team2_private_rt_assoc_2" {
  subnet_id      = aws_subnet.team2_private_subnet_2.id
  route_table_id = aws_route_table.team2_private_rt_2.id
}

//eks control plane sec group

