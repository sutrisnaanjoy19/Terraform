output "tf-vpc-id" {
  value = aws_vpc.tf-vpc.id
}

output "aws-ami-id" {
  value = data.aws_ami.amazon-linux-2.id
}

output "instance-public-ip" {
  value = module.tf-server.ec2-output.public_ip
}
