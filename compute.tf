#===================================
#EC2 Instance
#===================================
# module "public_instance_1" {
#   source = "./modules/compute"
#   //EC2の設定
#   subnet_id = aws_subnet.public_a.id
#   key_name  = aws_key_pair.public_instance_1.key_name
#   sg        = module.sg_iaas.sg_ec2_pub
#   //EBSの設定
#   volume_type = "gp3"
#   volume_size = 10

#   instance_name = "actions-1"
# }

resource "aws_key_pair" "public_instance_1" {
  key_name   = "actions"
  public_key = file("./key/actions.pub")
}

# resource "aws_instance" "count" {
#   count                       = length(var.animals)
#   ami                         = "ami-0dafcef159a1fc745" // Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
#   subnet_id                   = aws_subnet.public_a.id
#   instance_type               = "t2.micro"
#   key_name                    = aws_key_pair.public_instance_1.key_name
#   vpc_security_group_ids      = [module.sg_iaas.sg_ec2_pub]
#   associate_public_ip_address = true

#   root_block_device {
#     volume_type           = "gp3"
#     volume_size           = 8
#     delete_on_termination = true
#     encrypted             = true
#   }

#   tags = {
#     Name = var.animals[count.index]
#   }
# }

# resource "aws_instance" "for_each" {
#   for_each                    = toset(var.instance_name)
#   ami                         = "ami-0dafcef159a1fc745" // Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
#   subnet_id                   = aws_subnet.public_a.id
#   instance_type               = "t2.micro"
#   key_name                    = aws_key_pair.public_instance_1.key_name
#   vpc_security_group_ids      = [module.sg_iaas.sg_ec2_pub]
#   associate_public_ip_address = true

#   root_block_device {
#     volume_type           = "gp3"
#     volume_size           = 8
#     delete_on_termination = true
#     encrypted             = true

#     tags = {
#       Name = "ebs-actions"
#     }
#   }

#   tags = {
#     Name = "server-${each.value}"
#   }
# }

/* resource "aws_instance" "for_each_inline" {
 #for_each                    = toset(var.instance_name)
  ami                         = "ami-0dafcef159a1fc745" // Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  subnet_id                   = aws_subnet.public_a.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.public_instance_1.key_name
  vpc_security_group_ids      = [module.sg_iaas.sg_ec2_pub]
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

 dynamic "tag"  {
    for_each = var.my_map

    content {
      Name = tag.key
      value = tag.value
    }
  }
} */

# resource "aws_instance" "count" {
#   count                       = var.bool ? 1 : 0
#   ami                         = "ami-0dafcef159a1fc745" // Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
#   subnet_id                   = aws_subnet.public_a.id
#   instance_type               = "t2.micro"
#   key_name                    = aws_key_pair.public_instance_1.key_name
#   vpc_security_group_ids      = [module.sg_iaas.sg_ec2_pub]
#   associate_public_ip_address = true

#   root_block_device {
#     volume_type           = "gp3"
#     volume_size           = 8
#     delete_on_termination = true
#     encrypted             = true
#   }

#   tags = {
#     Name = "${var.in_name}"
#   }
# }

# module "create_instance" {
#   source = "./modules/compute/"
#   create_instance = true
#   subnet_id = aws_subnet.public_a.id
#   key_name = aws_key_pair.public_instance_1.key_name
#   sg = aws_security_group.ecs.id
#   volume_type = "gp3"
#   volume_size = "8"
#   instance_name = "index"
# }

resource "aws_instance" "test" {
  #count = 2
  ami                         = "ami-027a31eff54f1fe4c" // 「Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type」のAMI
  subnet_id                   = aws_subnet.public_a.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true 
  key_name = aws_key_pair.public_instance_1.key_name

  //ユーザーデータでEC2インスタンスの中でhttpdが起動してドキュメントルートにindex.htmlファイルが置かれるよう設定
  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd
                echo "Hello World!" > /var/www/html/index.html
                EOF
  //EC2インスタンスにデフォルトでアタッチされるEBSボリュームの設定
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = false
    encrypted             = true
  }

  tags = {
    Name = "tls-instance"
  }
} 