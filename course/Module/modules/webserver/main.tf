resource "aws_security_group" "tf-security-gp" {
  name   = "tf-security"
  vpc_id = var.vpc_id

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
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
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


