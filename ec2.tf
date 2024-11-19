resource "aws_instance" "ec2_server" {
  
  ami           = var.ec2_ami
  instance_type = var.instance_type
  key_name               = var.aws_key_pair_name
  vpc_id                 = var.vpc_id
  subnet_id              = var.subnet_id
  security_group_id      = var.security_group_id
  ebs_optimized          = true

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ebs_size
    volume_type           = "gp2"
  }

  tags = {
    "teleport.dev/creator" = "scott@goteleport.com"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg_security-group"
  description = "AWS Security Group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ingress_allow_22_tcp_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}


resource "aws_security_group_rule" "linux_egress_allow_0-65535_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}
