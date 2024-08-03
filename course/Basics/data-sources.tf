# data "aws_vpc" "tf-imported-vpc" {
#   default = true
# }

# resource "aws_subnet" "tf-imported-vpc-subnet" {
#   vpc_id            = data.aws_vpc.tf-imported-vpc.id
#   cidr_block        = var.imported-vpc-subnet-cidr
#   availability_zone = "ap-south-1a"
#   tags = {
#     name : "imported-vpc-subnet"
#   }
# }

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
