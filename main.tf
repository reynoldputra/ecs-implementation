terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}


# === all modules ===

data "terraform_remote_state" "ecr" {
  backend = "local"

  config = {
    path = "./dev/ecr/terraform.tfstate"
  }
}

# all network configuration
module "network" {
  source = "./modules/network"
}

module "policy" {
  source = "./modules/policy"
}

module "ecs" {
  source = "./modules/ecs"

  port                  = 5000
  image_url             = data.terraform_remote_state.ecr.outputs.ecr_modul_repo_url
  aws_role_task_def_arn = module.policy.simple_shop_task_execution_role_arn

  subnets = [
    module.network.private_subnet_id
  ]

  sec_groups = [
    module.network.sg_ingress_api_id,
    module.network.sg_egress_all_id,
  ]
}

# TODO: alb for auto scale
# module "alb" {
#   source = "./modules/alb"
#
#   vpc_id = module.network.vpc_id
#   subnets = [
#     module.network.public_subnet_id
#   ]
#
#   sec_groups = [
#     module.network.sg_ingress_http,
#     module.network.sg_egress_all_id,
#     module.network.sg_ingress_https
#   ]
#
#   aws_alb_dependencies = module.network.igw
# }

# TODO: setup database
