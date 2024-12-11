############################## VPC ##############################

variable "availability_zones" {
  description = "List of availability zones to be used."
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_cidr" {
  description = "VPC CIDR block."
  default     = "10.0.0.0/16"
}
variable "vpc_name" {
  default = "assignment-vpc"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks."
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks."
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "ig_name" {
  default = "assignment-ig"
}

variable "rt_public_name" {
  default = "assignment-public-rt"
}

variable "rt_private_name" {
  default = "assignment-private-rt"
}

variable "ng_name" {
  default = "assignment-ng"
}



############################## IAM ##############################

variable "iam_role_name" {
  default = "assignment_ec2_role"
}

variable "policy_arns" {
  default = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly", "arn:aws:iam::aws:policy/SecretsManagerReadWrite"]
}



############################## ELB SG ##############################


variable "sg_name" {
  default = "assignment-elb-sg"
}

variable "description" {
  default = "SG to allow inbound and outbound traffic to ELB"
}



variable "elb_ingress_rules" {
  description = "List of ingress rules"
  default = {
    http_ingress = {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
    }
    https_ingress = {
      from_port                = 443
      to_port                  = 443
      protocol                 = "tcp"
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
    }
  }
}


variable "elb_egress_rules" {
  description = "List of egress rules"
  default = {
    elb_egress = {
      from_port                = 0
      to_port                  = 0
      protocol                 = "-1"
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
    }
  }
}


##############################  ELB ##############################
variable "name" {
  description = "Name of the LB"
  default     = "assignment-lb"
}

variable "internal" {
  description = "Is the LB is internal or external"
  default     = false
}

variable "type" {
  description = "What is the type of the LB"
  default     = "application"
}

variable "tg_name" {
  description = "Name of the target group"
  default     = "assignment-target-group"
}

variable "tg_port" {
  description = "Port target group need to reach"
  default     = 80
}

variable "tg_protocol" {
  description = "Protocol target group need to be using"
  default     = "HTTP"
}

variable "tg_hc_path" {
  default = "/"
}

variable "tg_hc_interval" {
  default = 30
}

variable "tg_hc_timeout" {
  default = 5
}

variable "tg_hc_healthy_threshold" {
  default = 2
}

variable "tg_hc_unhealthy_threshold" {
  default = 2
}

variable "tg_hc_protocol" {
  default = "HTTP"
}

variable "port" {
  default = 80
}

variable "protocol" {
  default = "HTTP"
}

variable "lis_type" {
  default = "forward"
}


############################## LT ##############################
variable "lt_name" {
  default = "assignment-launch-template"
}

variable "lt_userdata" {
  default = "/../../scripts/assignment_part_two.sh"
}
variable "lt_ami_id" {
  description = "Amazon Machine Image ID for EC2 instances"
  default     = "ami-02141377eee7defb9"
}




############################## ASG ##############################

variable "instance_type" {
  description = "Instance type for EC2 instances"
  default     = "t2.micro"
}

variable "asg_name" {
  default = "assignment-asg"
}

variable "min_size" {
  default = 2
}

variable "max_size" {
  default = 3
}

variable "desired_capacity" {
  default = 2
}

variable "asg_ec2_name" {
  default = "assignment-web-server"
}
variable "asg_propagate_at_launch" {
  default = true
}

variable "associate_public_ip_address" {
  default = false
}


############################## SM ##############################
variable "sm_name" {
  default = "assignment-rds-secret"
}

variable "rds_user" {
  default = "Administrator"
}


############################## RDS ##############################
variable "allocated_storage" {
  default = 20
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7"
}

variable "rds_name" {
  default = "assignment"
}

variable "parameter_group_name" {
  default = "default.mysql5.7"
}

variable "publicly_accessible" {
  default = false
}

variable "rds_subnet_group_name" {
  default = "assignment-subg"
}

variable "multi_az" {
  default = false
}

variable "skip_final_snapshot" {
  default = true
}


############################## SG RDS ##############################

variable "sg_rds_name" {
  default = "assignment-rds-sg"
}

variable "rds_description" {
  default = "SG to allow secured connection to RDS from the application"
}

variable "rds_ingress_rules" {
  description = "Ingress rules for the security group"
  default = {
    rds_ingress = {
      from_port                = 3306,
      to_port                  = 3306,
      protocol                 = "tcp",
      cidr_blocks              = ["10.0.0.0/16"]
      source_security_group_id = null
    }
  }
}


variable "rds_egress_rules" {
  description = "Egress rules for the security group"
  default = {
    rds_egress = {
      from_port                = 0,
      to_port                  = 0,
      protocol                 = "-1",
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
    }
  }
}


############################## SG EC2 ##############################

variable "sg_ec2_name" {
  default = "assignment-ec2-sg"
}

variable "ec2_description" {
  default = "SG to allow secured connection to ec2 instances"
}

variable "ec2_from_port" {
  default = 80
}

variable "ec2_to_port" {
  default = 80
}

variable "ec2_protocol" {
  default = "tcp"
}

variable "cidr_blocks" {
  default = null
}


variable "ec2_egress_rules" {
  description = "Egress rules for the security group"
  default = {
    ec2_egress = {
      from_port                = 0,
      to_port                  = 0,
      protocol                 = "-1",
      cidr_blocks              = ["0.0.0.0/0"]
      source_security_group_id = null
    }
  }
}
