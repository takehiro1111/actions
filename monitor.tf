#=============================
#EventBridge
#=============================
#Auto Stop EC2 on Public  ----
resource "aws_cloudwatch_event_rule" "auto_stop_ec2_public" {
  state               = "ENABLED"
  schedule_expression = "cron(0 16 * * ? *)"
  name                = "ec2-public-autostop"
  tags = {
    Name = "autostop-ec2"
  }
}

resource "aws_cloudwatch_event_target" "auto_stop_ec2_public" {
  rule     = aws_cloudwatch_event_rule.auto_stop_ec2_public.name
  arn      = "arn:aws:ssm:ap-northeast-1::automation-definition/AWS-StopEC2Instance"
  role_arn = aws_iam_role.eventbridge_role.arn
  input = jsonencode({
    InstanceId = module.public_instance_1.instance_id
  })
}

