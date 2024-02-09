# Devops Bootcamp

In my .zshrc script, I create alias tf for terraform.  This reduces keystrokes for same command.

## Section 1: Introduction


## Section 2: Terraform and AWS Introduction

Configure the cloud provider

```terraform
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = "some-access-key"
  secret_key = "secret key"
}
```



## Section 3: Provisioning AWS Infrastructure with Terraform

The Terraform commands to initialize, validate, plan, apply or destroy the resources.
```terraform
terraform init
terraform validate
terraform fmt -recursive
terraform apply -auto-approve
terraform destroy
```

### VPC
create VPC using terraform
````terraform
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "Main VPC"
  }
}
````



### EC2


## Section 4: Challenge: Provisioning AWS with Terraform


## Section 5: Hashicorp Configuration Language (HCL) in Depth


## Section 6: Challenge: Hashicorp Configuration Language


## Section 7: Terraform Remote State and Security


## Section 8: Challenge: Terraform Remote State and Security


## Section 9: Terraform Modules


## Section 10: Where to Go from Here? 



