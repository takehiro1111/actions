#=========================================
# Security Group
#=========================================
#ALB--------------------------------------
resource "aws_security_group" "alb" {
  name = "alb_actions"
  description = "alb for publicaccess"
  vpc_id = aws_vpc.actions.id

  tags = {
    Name = "sg-actions-alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_80" {
  security_group_id = aws_security_group.alb.id
  description = "rule of alb-80 ingress"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"

  tags = {
    Name = "in-alb-80"
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb_443" {
  security_group_id = aws_security_group.alb.id
  description = "rule of alb-443 ingress"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  tags = {
    Name = "in-alb-443"
  }
}

resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id = aws_security_group.alb.id
  description = "rule of alb egress"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "all"

  tags = {
    Name = "out-alb-all"
  }
}

#ECS--------------------------------------
resource "aws_security_group" "ecs" {
  name = "ecs_actions"
  description = "ecs for alb"
  vpc_id = aws_vpc.actions.id

  tags = {
    Name = "sg-actions-ecs"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_8070" {
  security_group_id = aws_security_group.ecs.id
  description = "rule of ecs-8070 ingress"
  referenced_security_group_id   = aws_security_group.alb.id
  from_port   = 8070
  to_port     = 8070
  ip_protocol = "tcp"

  tags = {
    Name = "in-ecs-8070"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_8080" {
  security_group_id = aws_security_group.ecs.id
  description = "rule of ecs-8080 ingress"
  referenced_security_group_id   = aws_security_group.alb.id
  from_port   = 8080
  to_port     = 8080
  ip_protocol = "tcp"

  tags = {
    Name = "in-ecs-8080"
  }
}

resource "aws_vpc_security_group_egress_rule" "ecs_egress" {
  security_group_id = aws_security_group.ecs.id
  description = "rule of ecs egress"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "all"

  tags = {
    Name = "out-ecs-all"
  }
}

#ECR--------------------------------------
resource "aws_security_group" "link" {
  name = "link_actions"
  description = "ecr for ecs"
  vpc_id = aws_vpc.actions.id

  tags = {
    Name = "sg-actions-link"
  }
}

resource "aws_vpc_security_group_ingress_rule" "link_443" {
  security_group_id = aws_security_group.link.id
  description = "rule of ecr ingress"
  referenced_security_group_id   = aws_security_group.ecs.id
  from_port   = 443
  to_port     = 443
  ip_protocol = "tcp"

  tags = {
    Name = "in-link-443"
  }
}

resource "aws_vpc_security_group_egress_rule" "link_egress" {
  security_group_id = aws_security_group.link.id
  description = "rule of link egress"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "all"

  tags = {
    Name = "out-link-all"
  }
}