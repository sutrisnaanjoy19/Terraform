resource "aws_subnet" "tf-public-subnet" {
  vpc_id            = var.vpc-id
  cidr_block        = var.vpc-public-subnet-cidr
  availability_zone = var.availability-zone
  tags = {
    name : "tf-subnet-public"
  }

}

resource "aws_internet_gateway" "tf-gateway" {
  vpc_id = var.vpc-id
  tags = {
    name : "tf-gateway"
  }
}

resource "aws_route_table" "tf-route" {
  vpc_id = var.vpc-id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-gateway.id
  }
  tags = {
    name : "tf-route"
  }
}

resource "aws_route_table_association" "tf-subnet-assin" {
  route_table_id = aws_route_table.tf-route.id
  subnet_id      = aws_subnet.tf-public-subnet.id
}
