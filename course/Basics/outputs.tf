output "tf-vpc-id" {
  value = aws_vpc.tf-vpc.id
}

output "aws-ami-id" {
  value = data.aws_ami.amazon-linux-2.id
}

output "instance-public-ip" {
  value = aws_instance.tf-ec2.public_ip
}
