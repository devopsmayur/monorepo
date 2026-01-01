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
        Owner       = va
        Project     = var.project
        Terraform   = var.terraform
    }
  }
}


