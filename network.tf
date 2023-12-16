#===================================
#VPC
#===================================
#tfsec:ignore:aws-ec2-require-vpc-flow-logs-for-all-vpcs
resource "aws_vpc" "actions" {
  cidr_block           = module.value.vpc_ip
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "actions-vpc"
  }
}

#===================================
#Gateway
#===================================
resource "aws_internet_gateway" "actions" {
  vpc_id = aws_vpc.actions.id

  tags = {
    Name = "actions-igw"
  }
}

/* resource "aws_nat_gateway" "public_a" {
  subnet_id = aws_subnet.public_a.id
  allocation_id = aws_eip.actions.id

  depends_on = [aws_internet_gateway.actions]
}

resource "aws_eip" "actions" {
  
} */

#===================================
#Subnet
#===================================
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.actions.id
  cidr_block              = module.value.subnet_ip["public_a"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "actions-public-a"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.actions.id
  cidr_block              = module.value.subnet_ip["public_c"]
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false
  tags = {
    Name = "actions-public-c"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.actions.id
  cidr_block              = module.value.subnet_ip["private_a"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "actions-private-a"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id                  = aws_vpc.actions.id
  cidr_block              = module.value.subnet_ip["private_c"]
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false
  tags = {
    Name = "actions-private-c"
  }
}

#===================================
#Route Table
#===================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.actions.id

  route {
    cidr_block = module.value.gateway_ip["igw"]
    gateway_id = aws_internet_gateway.actions.id
  }

  tags = {
    Name = "route-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.actions.id

  /*   route {
    cidr_block = module.value.gateway_ip ["nat"]
    gateway_id = aws_nat_gateway.public_a.id
  } */

  tags = {
    Name = "route-private"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private.id
}