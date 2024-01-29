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

# elastic container repository
module "ecr" {
  source = "./modules/ecr"

  ecr_name = "simple-shop-rest"
  tags = {
    "environment" = "dev"
  }
}

# all network configuration
module "network" {
  source = "./modules/network"
}

# TODO: setup policy
module "policy" {
  source = "./modules/policy"
}

# TODO: setup ecs task definition
# TODO: setup ecs service
# TODO: setup load balancer
# TODO: setup database
