terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.36.0"
    }
  }
  cloud {
    organization = "master-terraform" # should already exist on Terraform cloud
    workspaces {
      name = "DevOps-Production"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "eu-central-1"
  access_key = "AKIA6QEFRZJACXBRGGON"
  secret_key = "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"
}
