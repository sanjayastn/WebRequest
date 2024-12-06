variable "allocated_storage" {
  type = number
}

variable "instance_class" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "rds_name" {
  type = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "parameter_group_name" {
  type = string
}

variable "publicly_accessible" {
  type = bool
}

variable "rds_subnet_group_name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "rds_sg" {

}

variable "multi_az" {

}

variable "skip_final_snapshot" {

}
