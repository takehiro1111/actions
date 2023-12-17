#===================================
#EC2 Instance
#===================================
module "public_instance_1" {
  source = "./modules/compute"
  //EC2の設定
  subnet_id = aws_subnet.public_a.id
  key_name  = aws_key_pair.public_instance_1.key_name
  sg        = aws_security_group.ec2_public.id

  //EBSの設定
  volume_type = "gp3"
  volume_size = 10

  instance_name = "actions-1"
}

resource "aws_key_pair" "public_instance_1" {
  key_name   = "actions"
  public_key = file("./key/actions.pub")
}