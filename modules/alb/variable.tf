variable "vpc_id" {
  description = "VPC id"
  type        = string
  default     = null
}

variable "subnets" {
  description = "AWS alb subnets"
  type        = list(string)
  default     = []
}

variable "sec_groups" {
  description = "AWS alb sec_groups"
  type        = list(string)
  default     = []
}

variable "aws_alb_dependencies" {
  description = "AWS alb dependencies"
  type        = any
}
