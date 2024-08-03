provider "aws" {
  region     = "ap-south-1"
  access_key = var.access-key
  secret_key = var.secret-key
}

resource "aws_vpc" "tf-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    name : "tf-vpc"
  }
}

module "tf-subnet" {
  source                 = "./modules/subnet"
  vpc-public-subnet-cidr = var.vpc-public-subnet-cidr
  availability-zone      = var.availability-zone
  vpc-id                 = aws_vpc.tf-vpc.id
}

module "tf-server" {
  source                  = "./modules/webserver"
  vpc_id                  = aws_vpc.tf-vpc.id
  my-public-key-location  = var.my-public-key-location
  my-private-key-location = var.my-private-key-location
  availability-zone       = var.availability-zone
  my_ip                   = var.my_ip
  ami_id                  = data.aws_ami.amazon-linux-2.id
  subnet_id               = module.tf-subnet.subnet.id
}
