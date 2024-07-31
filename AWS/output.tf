output "instance_private_ip" {
  value = aws_instance.ec2-tf.private_ip
}
output "instance_public_ip" {
  value = aws_instance.ec2-tf.public_ip
}
