variable "image_url" {
  description = "Base image for create container"
  type        = string
  default     = null
}

variable "port" {
  description = "Exposed port"
  type        = number
  default     = null
}

variable "aws_role_task_def_arn" {
  description = "Task definition role"
  type        = string
  default     = null
}

variable "subnets" {
  description = "AWS service subnets"
  type        = list(string)
  default     = []
}

variable "sec_groups" {
  description = "AWS service sec_groups"
  type        = list(string)
  default     = []
}

variable "alb_target_group_arn" {
  description = "ALB target group for ecs service"
  type        = string
  default     = null
}
