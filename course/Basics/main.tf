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

resource "aws_subnet" "tf-public-subnet" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = var.vpc-public-subnet-cidr
  availability_zone = var.availability-zone
  tags = {
    name : "tf-subnet-public"
  }

}

resource "aws_internet_gateway" "tf-gateway" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    name : "tf-gateway"
  }
}

resource "aws_route_table" "tf-route" {
  vpc_id = aws_vpc.tf-vpc.id
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

resource "aws_security_group" "tf-security-gp" {
  name   = "tf-security"
  vpc_id = aws_vpc.tf-vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = [var.my_ip]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
}

resource "aws_key_pair" "tf-key-pair" {
  key_name   = "instance-key"
  public_key = (file(var.my-public-key-location))

}
resource "aws_instance" "tf-ec2" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.tf-public-subnet.id
  vpc_security_group_ids      = [aws_security_group.tf-security-gp.id]
  availability_zone           = var.availability-zone
  associate_public_ip_address = true
  key_name                    = aws_key_pair.tf-key-pair.key_name
  user_data                   = file("startup.sh")

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.my-private-key-location)
  }
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo yum update -y && sudo yum install -y docker",
  #     "sudo systemctl start docker",
  #     "sudo usermod -aG docker ec2-user",
  #     "newgrp docker",
  #     "docker run -d -p 8080:80 nginx:latest"
  #   ]
  # }
  # provisioner "file" {
  #   source      = "startup.sh"
  #   destination = "/home/ec2-user/startup.sh"
  # }
  # provisioner "remote-exec" {
  #   script = file("startup.sh")
  # }

  tags = {
    name : "tf-ec2"
  }
}


