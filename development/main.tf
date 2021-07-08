terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider and default tags
provider "aws" {
  region = "ap-southeast-2"
  
  default_tags {   
    tags = {     
        Environment = var.environment     
        Owner       = var.owner   
        Project     = var.project
        Terraform   = var.terraform
    }
  }
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "pcarey-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "pcarey-cluster"
  instance_count         = 1

  ami                    = "ami-05064bb33b40c33a2"
  instance_type          = "t2.micro"
  key_name               = "pcarey-one"
  monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

}

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "pcarey-one"
  public_key = tls_private_key.this.public_key_openssh
}