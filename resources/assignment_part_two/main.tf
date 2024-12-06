
module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  ig_name              = var.ig_name
  rt_public_name       = var.rt_public_name
  rt_private_name      = var.rt_private_name
  ng_name              = var.ng_name
}


module "iam" {
  source = "../../modules/iam"

  iam_role_name = var.iam_role_name
  policy_arns   = var.policy_arns
}


module "sg_elb" {
  source = "../../modules/sg"

  sg_name       = var.sg_name
  vpc_id        = module.vpc.vpc_id
  description   = var.description
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
}

module "sg_ec2" {
  source = "../../modules/sg"

  sg_name       = var.sg_ec2_name
  vpc_id        = module.vpc.vpc_id
  description   = var.ec2_description
  ingress_rules = var.ec2_ingress_rules
  egress_rules  = var.ec2_egress_rules
}


module "sg_rds" {
  source = "../../modules/sg"

  sg_name       = var.sg_rds_name
  vpc_id        = module.vpc.vpc_id
  description   = var.rds_description
  ingress_rules = var.rds_ingress_rules
  egress_rules  = var.rds_egress_rules
}


module "elb" {
  source = "../../modules/elb"

  name                      = var.name
  internal                  = var.internal
  security_group_id         = module.sg_elb.security_group_id
  elb_subnets               = module.vpc.public_subnet_ids
  tg_name                   = var.tg_name
  tg_port                   = var.port
  tg_protocol               = var.protocol
  tg_hc_path                = var.tg_hc_path
  tg_hc_interval            = var.tg_hc_interval
  tg_hc_timeout             = var.tg_hc_timeout
  tg_hc_healthy_threshold   = var.tg_hc_healthy_threshold
  tg_hc_unhealthy_threshold = var.tg_hc_unhealthy_threshold
  tg_hc_protocol            = var.tg_hc_protocol
  vpc_id                    = module.vpc.vpc_id
  lis_port                  = var.port
  lis_protocol              = var.protocol
  lis_type                  = var.lis_type
}


module "asg" {
  source = "../../modules/asg"

  lt_name                     = var.lt_name
  lt_userdata                 = var.lt_userdata
  lt_ami_id                   = var.lt_ami_id
  instance_type               = var.instance_type
  instance_profile            = module.iam.instance_profile_name
  security_group_id           = module.sg_ec2.security_group_id
  asg_name                    = var.asg_name
  asg_subnets                 = module.vpc.public_subnet_ids
  min_size                    = var.min_size
  max_size                    = var.max_size
  desired_capacity            = var.desired_capacity
  elb_target_group_arn        = module.elb.target_group_arn
  asg_ec2_name                = var.asg_ec2_name
  asg_propagate_at_launch     = var.asg_propagate_at_launch
  associate_public_ip_address = var.associate_public_ip_address

}

module "sm" {
  source = "../../modules/sm"

  sm_name  = var.sm_name
  rds_user = var.rds_user
}

module "rds" {
  source = "../../modules/rds"

  allocated_storage     = var.allocated_storage
  instance_class        = var.instance_class
  engine                = var.engine
  engine_version        = var.engine_version
  rds_name              = var.rds_name
  rds_username          = var.rds_user
  rds_password          = local.rds_credentials.password
  parameter_group_name  = var.parameter_group_name
  publicly_accessible   = var.publicly_accessible
  rds_sg                = module.sg_rds.security_group_id
  rds_subnet_group_name = var.rds_subnet_group_name
  subnet_ids            = module.vpc.private_subnet_ids
  multi_az              = var.multi_az
  skip_final_snapshot   = var.skip_final_snapshot

}


