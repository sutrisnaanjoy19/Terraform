terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
  }
}
provider "aws" {
  region  = "us-east-1"
  profile = "sushi-east1"

}

resource "aws_key_pair" "ec2-key" {
  key_name   = "ec2-key"
  public_key = (file("/home/sushi/.ssh/aws.pub"))

}
resource "aws_instance" "ec2-tf" {
  instance_type               = "t3.nano"
  ami                         = var.ami
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ec2-key.key_name
  vpc_security_group_ids      = ["${aws_security_group.security-tf.id}"]
  subnet_id                   = aws_subnet.public-tf.id
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/sushi/.ssh/aws")
    }
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.ec2-tf.private_ip} >> aws_ips.txt"
  }
  tags = {
    Name = "ec2-tf"
  }
}
