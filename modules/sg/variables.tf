variable "sg_name" {
  description = "The name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID"
  #type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = map(object({
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = optional(list(string), null)
    source_security_group_id = optional(string, null)
  }))
}

variable "egress_rules" {
  description = "List of egress rules"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
