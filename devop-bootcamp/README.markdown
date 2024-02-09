# Devops Bootcamp

In my .zshrc script, I create alias tf for terraform.  This reduces keystrokes for same command.

## Section 1: Introduction


## Section 2: Terraform and AWS Introduction
main.tf - the main terraform code

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
```shell
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
 - aws_vpc is the provider resource type
 - main is the local name. 

### EC2
create EC2 Computer using Terraform
```terraform
# Create an EC2 instance
resource "aws_instance" "server" {
  ami = "ami-06ec8443c2a35b0ba"
  instance_type = "t2.micro"
  tags = {
    "Name" = "server"
  }
}
```

### Variables
* Input variables make the Terraform configuration more flexible.
* It is like function arguments

```terraform
# Configure the variables
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  description = "CIDR Block for the VPC"
  type = string
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "Main VPC"
  }
}
```

Create a variable.tf file
```terraform
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  description = "CIDR Block for the VPC"
  type = string
}

variable "web_subnet" {
  # default = "10.0.10.0/24"
  description = "Web Subnet"
  type = string
}

variable "subnet_zone" {

}

variable "main_vpc_name" {

}
```

By default, Terraform uses terraform.tfvars.  You could override it by -var-file=prod.tfvars parameter.

use prod.tf
```shell
terraform apply -auto-approve -var-file=prod.tfvars
```

**Variable Precedence:**<br/>
1: -var and -var-file<br/>
2: terraform.tfvars<br/>
3: environment variables (TF_VAR_*)<br/>


### Route Table
* Route table = virtual router within VPC
* A route table contains routes that determine where the network traffic is directed.



### Security Group and Firewalls



## Section 4: Challenge: Provisioning AWS with Terraform


## Section 5: Hashicorp Configuration Language (HCL) in Depth


## Section 6: Challenge: Hashicorp Configuration Language


## Section 7: Terraform Remote State and Security


## Section 8: Challenge: Terraform Remote State and Security


## Section 9: Terraform Modules


## Section 10: Where to Go from Here? 



