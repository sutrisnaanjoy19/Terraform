resource "aws_instance" "my_instance" {
  #resource goes here
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t3.nano"
  key_name      = "ec2-key"
  tags = {
    Name = "ec2-tf"
  }

}
