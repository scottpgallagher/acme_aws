resource "aws_instance" "ec2_server" {
  
  ami                    = var.ec2_ami
  instance_type          = var.instance_type
  key_name               = var.aws_key_pair_name
  subnet_id              = var.subnet_id
  ebs_optimized          = true

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ebs_size
    volume_type           = "gp2"
  }
}
