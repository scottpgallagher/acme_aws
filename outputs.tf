output "ec2_server_public_ip" {
  value = aws_instance.ec2_server.public_ip
}
