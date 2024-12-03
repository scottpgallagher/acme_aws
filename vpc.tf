/// VPC

resource "aws_vpc" "acme_corp_vpc" {
  cidr_block = "10.0.0.0/16"

}

resource "aws_internet_gateway" "acme_corp_gateway" {
  vpc_id = aws_vpc.acme_corp_vpc.id

}

resource "aws_route" "acme_corp_internet_access" {
  route_table_id         = aws_vpc.acme_corp_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.acme_corp_gateway.id
}

resource "aws_subnet" "acme_corp_subnet" {
  vpc_id                  = aws_vpc.acme_corp_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

}

/// Security Group 

resource "aws_security_group" "acme_corp" {
  name        = "acme_corp_${random_id.instance_id.hex}"
  description = "base rules for national parks demo"
  vpc_id      = aws_vpc.acme_corp_vpc.id

}

resource "aws_security_group_rule" "ingress_allow_22_tcp_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.acme_corp.id
}
