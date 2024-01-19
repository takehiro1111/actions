#=============================
#EventBridge
#=============================
#Auto Stop EC2 on Public  ----
# resource "aws_cloudwatch_event_rule" "auto_stop_ec2_public" {
#   state               = "ENABLED"
#   schedule_expression = "cron(0 17-19 * * ? *)"
#   name                = "ec2-public-autostop"
#   tags = {
#     Name = "autostop-ec2"
#   }
# }

# resource "aws_cloudwatch_event_target" "auto_stop_ec2_public" {
#   rule     = aws_cloudwatch_event_rule.auto_stop_ec2_public.name
#   arn      = "arn:aws:ssm:ap-northeast-1::automation-definition/AWS-StopEC2Instance"
#   role_arn = aws_iam_role.eventbridge_role.arn
#   input = jsonencode({
#     InstanceId = "${module.public_instance_1.instance_id}"
#   })
# }

/* resource "aws_cloudwatch_event_rule" "stop_ec2_rule" {
  name                = "stop-ec2-instance-daily"
  description         = "Stop EC2 instance daily at a specific time"
  schedule_expression = "cron(0 23 * * ? *)" # Daily at 23:00 UTC
}

resource "aws_cloudwatch_event_target" "stop_ec2_target" {
  rule      = aws_cloudwatch_event_rule.stop_ec2_rule.name
  target_id = "StopSpecificEC2Instance"
  arn       = aws_ssm_document.stop_instance.document_arn
}

resource "aws_ssm_document" "stop_instance" {
  name            = "stop-instance"
  document_type   = "Command"
  target_type     = "/AWS::EC2::Instance"
  document_format = "JSON"

  content = <<DOC
{
  "schemaVersion": "2.2",
  "description": "Stop EC2 Instance",
  "parameters": {
    "InstanceId": {
      "type": "String",
      "description": "The ID of the instance to stop."
    }
  },
  "mainSteps": [
    {
      "action": "aws:runInstances",
      "name": "stopInstance",
      "inputs": {
        "InstanceIds": ["${aws_instance.test.id}"],
        "InstanceAction": "stop"
      }
    }
  ]
}
DOC
}

resource "aws_iam_role" "ssm_role" {
  name = "ssm-role-for-stop-instance"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "ssm_role_policy" {
  name   = "ssm-policy-for-stop-instance"
  role   = aws_iam_role.ssm_role.id
  policy = data.aws_iam_policy_document.ssm_policy.json
}

data "aws_iam_policy_document" "ssm_policy" {
  statement {
    actions   = ["ssm:SendCommand"]
    resources = ["*"]
  }
}

resource "aws_cloudwatch_event_target" "ec2_stop_target" {
  rule      = aws_cloudwatch_event_rule.stop_ec2_rule.name
  target_id = "StopEC2Instance"
  arn       = aws_ssm_document.stop_instance.document_arn

  role_arn = aws_iam_role.ssm_role.arn
  input = jsonencode({
    InstanceId = "${aws_instance.test.id}"
  })
}
 */