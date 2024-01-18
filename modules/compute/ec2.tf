#===================================
#EC2 Instance
#===================================
resource "aws_instance" "public_instance_1" {
  count = var.create_instance ?  1 : 0
  ami = "ami-0dafcef159a1fc745" // Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  subnet_id = var.subnet_id
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [var.sg]
  associate_public_ip_address = true

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = true
    encrypted             = true

    tags = {
      Name = "ebs-actions"
    }
  }

 tags = {
    Name = var.instance_name
 }
}