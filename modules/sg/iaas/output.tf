output "my_global_ip" {
  value = data.http.my_ip.body
}

output "sg_alb" {
  value = aws_security_group.alb.id
}

output "sg_ec2_pub" {
  value = aws_security_group.ec2_public.id
}