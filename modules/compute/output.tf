output "ec2_arn" {
  value = aws_instance.public_instance_1[0].arn
}

# output "instance_id" {
#   value = aws_instance.public_instance_1.id
# }