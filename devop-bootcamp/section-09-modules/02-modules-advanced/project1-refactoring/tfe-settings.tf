terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.36.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = "AKIA6QEFRZJACXBRGGON"
  secret_key = "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"
}
