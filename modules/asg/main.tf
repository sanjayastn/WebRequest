# DEfining  the launch template to be used in auto scaling group
resource "aws_launch_template" "lt" {
  name          = var.lt_name
  image_id      = var.lt_ami_id
  instance_type = var.instance_type
  user_data     = base64encode(file(var.lt_userdata))

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = [var.security_group_id]
  }

  iam_instance_profile {
    name = var.instance_profile
  }

}


# Defining autoscaling group
resource "aws_autoscaling_group" "asg" {
  name                = var.asg_name
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.asg_subnets
  target_group_arns   = [var.elb_target_group_arn]
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = var.asg_ec2_name
    propagate_at_launch = var.asg_propagate_at_launch
  }
}
