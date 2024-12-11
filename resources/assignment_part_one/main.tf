
# calling security group module for sg creation
module "sg_elb" {
  source = "../../modules/sg"

  sg_name       = var.sg_name
  vpc_id        = data.aws_vpc.default.id
  description   = var.description
  ingress_rules = var.elb_ingress_rules
  egress_rules  = var.elb_egress_rules
}

# calling security group module for sg creation
module "sg_ec2" {
  source = "../../modules/sg"

  sg_name     = var.sg_ec2_name
  vpc_id      = data.aws_vpc.default.id
  description = var.ec2_description
  ingress_rules = {
    elb_ingress = {
      from_port                = var.ec2_from_port
      to_port                  = var.ec2_to_port
      protocol                 = var.ec2_protocol
      cidr_blocks              = var.cidr_blocks
      source_security_group_id = module.sg_elb.security_group_id
    }
  }
  egress_rules = var.ec2_egress_rules

}


# calling iam module for role creation to attach in to ec2
module "iam" {
  source = "../../modules/iam"

  iam_role_name = var.iam_role_name
  policy_arns   = var.policy_arns

}

# calling ec2 module to create a ec2 instance
module "ec2" {
  source = "../../modules/ec2"

  ami_id                      = var.ami_id
  instance_type               = var.instance_type
  iam_instance_profile        = module.iam.instance_profile_name
  subnet_id                   = var.subnet
  security_group              = module.sg_ec2.security_group_id
  instance_name               = var.instance_name
  userdata                    = var.userdata
  associate_public_ip_address = var.associate_public_ip_address

}

# calling elastic load balancer module
module "elb" {
  source = "../../modules/elb"

  name                      = var.name
  internal                  = var.internal
  security_group_id         = module.sg_elb.security_group_id
  elb_subnets               = var.subnets
  tg_name                   = var.tg_name
  tg_port                   = var.port
  tg_protocol               = var.protocol
  tg_hc_path                = var.tg_hc_path
  tg_hc_interval            = var.tg_hc_interval
  tg_hc_timeout             = var.tg_hc_timeout
  tg_hc_healthy_threshold   = var.tg_hc_healthy_threshold
  tg_hc_unhealthy_threshold = var.tg_hc_unhealthy_threshold
  tg_hc_protocol            = var.tg_hc_protocol
  vpc_id                    = var.vpc_id
  lis_port                  = var.port
  lis_protocol              = var.protocol
  lis_type                  = var.lis_type
}


# calling auto scaling group module
module "asg" {
  source = "../../modules/asg"

  lt_name                     = var.lt_name
  lt_userdata                 = var.lt_userdata
  lt_ami_id                   = var.lt_ami_id
  instance_type               = var.instance_type
  instance_profile            = module.iam.instance_profile_name
  security_group_id           = module.sg_ec2.security_group_id
  asg_name                    = var.asg_name
  asg_subnets                 = var.subnets
  min_size                    = var.min_size
  max_size                    = var.max_size
  desired_capacity            = var.desired_capacity
  elb_target_group_arn        = module.elb.target_group_arn
  asg_ec2_name                = var.asg_ec2_name
  asg_propagate_at_launch     = var.asg_propagate_at_launch
  associate_public_ip_address = var.associate_public_ip_address

}
