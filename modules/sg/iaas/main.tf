#=========================================
# Security Group
#=========================================
#ALB--------------------------------------
resource "aws_security_group" "alb" {
  name        = var.name_alb
  description = "alb for publicaccess"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_alb}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_80" {
  security_group_id = aws_security_group.alb.id
  description       = "rule of alb-80 ingress"
  cidr_ipv4         = var.cidr_ipv4
  from_port         = local.http
  to_port           = local.http
  ip_protocol       = var.ip_protocol

  tags = {
    Name = "in-alb-80"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_443" {
  security_group_id = aws_security_group.alb.id
  description       = "rule of alb-443 ingress"
  cidr_ipv4         = var.cidr_ipv4
  from_port         = local.https
  to_port           = local.https
  ip_protocol       = var.ip_protocol

  tags = {
    Name = "in-alb-443"
  }
}

resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id = aws_security_group.alb.id
  description       = "rule of alb egress"
  cidr_ipv4         = var.cidr_ipv4
  ip_protocol       = "all"

  tags = {
    Name = "out-alb-all"
  }
}
#EC2 on public--------------------------------------
resource "aws_security_group" "ec2_public" {
  name        = var.name_ec2
  description = "EC2 Instance publicaccess"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_ec2}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_22" {
  security_group_id = aws_security_group.ec2_public.id
  description       = "rule of ec2-22 ingress"
  cidr_ipv4         = "${chomp(data.http.my_ip.body)}/32"
  from_port         = local.ssh
  to_port           = local.ssh
  ip_protocol       = var.ip_protocol

  tags = {
    Name = "in-ec2-public-22"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_80" {
  security_group_id = aws_security_group.ec2_public.id
  description       = "rule of ec2-80 ingress"
  cidr_ipv4         = var.cidr_ipv4 
  from_port         = local.http
  to_port           = local.http
  ip_protocol       = "tcp"

  tags = {
    Name = "in-ec2-public-80"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_443" {
  security_group_id = aws_security_group.ec2_public.id
  description       = "rule of ec2-443 ingress"
  cidr_ipv4         = var.cidr_ipv4 
  from_port         = local.https
  to_port           = local.https
  ip_protocol       = "tcp"

  tags = {
    Name = "in-ec2-public-443"
  }
}

resource "aws_vpc_security_group_egress_rule" "ec2_egress" {
  security_group_id = aws_security_group.ec2_public.id
  description       = "rule of alb egress"
  cidr_ipv4         = var.cidr_ipv4
  ip_protocol       = "all"

  tags = {
    Name = "out-alb-all"
  }
}