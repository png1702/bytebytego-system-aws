terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  profile = var.aws_profile
}

module "vpc" {
  source = "./vpc"
}

module "eks" {
  source = "./eks"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
}

module "alb" {
  source = "./alb"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnet_ids
}

module "rds" {
  source = "./rds"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
}

module "s3" {
  source = "./s3"
}

module "redis" {
  source = "./redis"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
}

module "iam" {
  source = "./iam"
}

module "api_gateway" {
  source = "./api-gateway"
}
