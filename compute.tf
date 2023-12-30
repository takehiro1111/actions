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

resource "aws_instance" "count" {
  count = 2
  ami = "ami-0dafcef159a1fc745" // Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  subnet_id = aws_subnet.public_a.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.public_instance_1.key_name
  vpc_security_group_ids = [aws_security_group.ec2_public.id]
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    delete_on_termination = true
    encrypted             = true

    tags = {
      Name = "ebs-actions"
    }
  }

 tags = {
    Name = "server${count.index}"
 }
}

resource "aws_instance" "for_each" {
  for_each = toset(local.family)
  ami = "ami-0dafcef159a1fc745" // Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  subnet_id = aws_subnet.public_a.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.public_instance_1.key_name
  vpc_security_group_ids = [aws_security_group.ec2_public.id]
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 8
    delete_on_termination = true
    encrypted             = true

    tags = {
      Name = "ebs-actions"
    }
  }

 tags = {
    Name = "server${each.value}"
 }
}