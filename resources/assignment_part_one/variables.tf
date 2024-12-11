#################################  EC2 #################################

variable "instance_name" {
  default = "assignment_ec2_instance"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-02141377eee7defb9"
}

variable "subnet" {
  default = "subnet-02c6adae06b209730"
}

variable "userdata" {
  default = "../../scripts/assignment_part_one.sh"
}

variable "associate_public_ip_address" {
  default = true
}

#################################  SG EC2 #################################
variable "sg_ec2_name" {
  default = "assignment-ec2-sg"
}

variable "ec2_description" {
  default = "SG to allow secured connection to ec2 instances"
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



#################################  SG ELB #################################
variable "sg_name" {
  default = "assignment-sg-elb"
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


#################################  ELB #################################

variable "name" {
  default = "assignment-lb"
}

variable "internal" {
  default = false
}

variable "type" {
  default = "application"
}

variable "tg_name" {
  default = "assignment-target-group"
}

variable "tg_port" {
  default = 80
}

variable "tg_protocol" {
  default = "HTTP"
}

variable "vpc_id" {
  default = "vpc-042e0b0fc42dfbf73"
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



#################################  LT #################################
variable "lt_name" {
  default = "assignment-launch-template"
}

variable "lt_userdata" {
  default = "/../../scripts/assignment_part_one.sh"
}
variable "lt_ami_id" {
  default = "ami-02141377eee7defb9"
}




#################################  ASG #################################

variable "asg_name" {
  default = "assignment-asg"
}

variable "subnets" {
  default = ["subnet-02c6adae06b209730", "subnet-0177e6ebd2c9f02e7", "subnet-0beb7922e1c8fef4c"]
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

#################################  IAM #################################
variable "iam_role_name" {
  default = "ec2-role"
}

variable "policy_arns" {
  default = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"]
}
