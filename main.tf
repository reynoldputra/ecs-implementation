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
