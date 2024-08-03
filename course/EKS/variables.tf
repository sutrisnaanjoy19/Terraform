variable "region" {
  default = "ap-south-1"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidr_blocks" {
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "availability-zone" {
  default = "ap-south-1a"
}
variable "prefix" {
  default = "EKS"
}
