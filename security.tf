#=========================================
# Security Group
#=========================================
#ALB--------------------------------------
module "sg_iaas" {
  source      = "./modules/sg/iaas"
  vpc_id      = aws_vpc.actions.id
  name_alb = "alb"
  name_ec2 = "ec2-pub"
}

#ECS--------------------------------------
resource "aws_security_group" "ecs" {
  name        = "ecs_actions"
  description = "ecs for alb"
  vpc_id      = aws_vpc.actions.id

  tags = {
    Name = "sg-actions-ecs"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_8070" {
  security_group_id            = aws_security_group.ecs.id
  description                  = "rule of ecs-8070 ingress"
  referenced_security_group_id = module.sg_iaas.sg_alb
  from_port                    = 8070
  to_port                      = 8070
  ip_protocol                  = "tcp"

  tags = {
    Name = "in-ecs-8070"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_8080" {
  security_group_id            = aws_security_group.ecs.id
  description                  = "rule of ecs-8080 ingress"
  referenced_security_group_id = module.sg_iaas.sg_alb
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"

  tags = {
    Name = "in-ecs-8080"
  }
}

resource "aws_vpc_security_group_egress_rule" "ecs_egress" {
  security_group_id = aws_security_group.ecs.id
  description       = "rule of ecs egress"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "all"

  tags = {
    Name = "out-ecs-all"
  }
}

#ECR--------------------------------------
resource "aws_security_group" "link" {
  name        = "link_actions"
  description = "ecr for ecs"
  vpc_id      = aws_vpc.actions.id

  tags = {
    Name = "sg-actions-link"
  }
}

resource "aws_vpc_security_group_ingress_rule" "link_443" {
  security_group_id            = aws_security_group.link.id
  description                  = "rule of ecr ingress"
  referenced_security_group_id = aws_security_group.ecs.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"

  tags = {
    Name = "in-link-443"
  }
}

resource "aws_vpc_security_group_egress_rule" "link_egress" {
  security_group_id = aws_security_group.link.id
  description       = "rule of link egress"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "all"

  tags = {
    Name = "out-link-all"
  }
}

#=========================================
# IAM
#=========================================
#IAM Role---------------------------------
# resource "aws_iam_role" "eventbridge_role" {
#   name = "eventbridge_ec2_stop_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Service = "events.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "eventbridge_policy" {
#   name        = "eventbridge_ec2_stop_policy"
#   description = "Policy to allow EventBridge to stop EC2 instances"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = [
#           "ec2:RebootInstances",
#           "ec2:StopInstances",
#           "ec2:TerminateInstances"
#         ],
#         Effect   = "Allow",
#         Resource = "${module.public_instance_1.ec2_arn}"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eventbridge_policy_attachment" {
#   role       = aws_iam_role.eventbridge_role.name
#   policy_arn = aws_iam_policy.eventbridge_policy.arn
# }

#-----------------
#IAMユーザー
#-----------------
resource "aws_iam_user" "name" {
  for_each = toset(var.iam_user)
  name = each.value
  path = "/system/"

  tags = {
    tag-key = each.key
  }
}