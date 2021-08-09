# Root main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


module "aws_creds" {
  source      = "./aws_creds"
  environment = var.environment
  vault_addr              = var.vault_addr
  login_approle_role_id   = var.login_approle_role_id
  login_approle_secret_id = var.login_approle_secret_id
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = module.aws_creds.access_key
  secret_key = module.aws_creds.secret_key
  token      = module.aws_creds.token
}

module "vpc" {
  source             = "./vpc"
  name               = var.name
  environment        = var.environment
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
}

module "eks" {
  source          = "./eks"
  name            = var.name
  environment     = var.environment
  region          = var.region
  k8s_version     = var.k8s_version
  vpc_id          = module.vpc.id
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets
  kubeconfig_path = var.kubeconfig_path
}

module "ingress" {
  source      = "./ingress"
  name        = var.name
  environment = var.environment
  region      = var.region
  vpc_id      = module.vpc.id
  cluster_id  = module.eks.cluster_id
}
