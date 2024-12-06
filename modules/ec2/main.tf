resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  iam_instance_profile        = var.iam_instance_profile
  subnet_id                   = var.subnet_id
  user_data                   = file(var.userdata)
  vpc_security_group_ids      = [var.security_group]
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name = var.instance_name
  }
}

