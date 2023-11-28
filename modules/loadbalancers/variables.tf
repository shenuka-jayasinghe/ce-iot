variable "vpc_id" {
  type = string
}

variable "instance_ids" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}