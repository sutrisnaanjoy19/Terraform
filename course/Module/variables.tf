variable "access-key" {
  description = "access_key"
}

variable "secret-key" {
  description = "secret_key"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "vpc-public-subnet-cidr" {
  default = "10.0.0.0/24"
}

variable "imported-vpc-subnet-cidr" {
  default = "172.31.48.0/20"
}

variable "my_ip" {
  default = "106.196.16.141/32"
}

variable "availability-zone" {
  default = "ap-south-1a"
}

variable "my-public-key-location" {
  description = "my public SSH key"
}

variable "my-private-key-location" {
  description = "my private SSH key location"
}
