resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "10.0.0.0/25"
  availability_zone = "ap-southeast-1a"

  tags = {
    "Name" = "public | ap-southeast-1a"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = "10.0.1.0/25"
  availability_zone = "ap-southeast-1a"

  tags = {
    "Name" = "public | ap-southeast-1a"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    "Name" = "public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    "Name" = "private"
  }
}

resource "aws_route_table_association" "public_a_subnet" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_a.id
}

resource "aws_route_table_association" "private_a_subnet" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_a.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app_vpc.id
}


# TODO: Create private gateway

