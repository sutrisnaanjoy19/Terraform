resource "aws_vpc" "vpc-tf" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name = "vpc-tf"
  }
}

resource "aws_subnet" "public-tf" {
  cidr_block = "172.31.0.0/24"
  vpc_id     = aws_vpc.vpc-tf.id
  tags = {
    "Name" = "public-tf"
  }

}
resource "aws_subnet" "private-tf" {
  cidr_block = "172.31.1.0/24"
  vpc_id     = aws_vpc.vpc-tf.id
  tags = {
    "Name" = "private-tf"
  }

}

resource "aws_internet_gateway" "gateway-tf" {
  vpc_id = aws_vpc.vpc-tf.id

  tags = {
    Name = "gateway-tf"
  }
}

resource "aws_route_table" "route-tf" {
  vpc_id = aws_vpc.vpc-tf.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway-tf.id
  }

  tags = {
    Name = "route-tf"
  }
}

resource "aws_route_table_association" "route-public-subnet" {
  subnet_id      = aws_subnet.public-tf.id
  route_table_id = aws_route_table.route-tf.id
}
