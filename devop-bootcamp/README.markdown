# Devops Bootcamp

* In my .zshrc script, I create alias tf for terraform.  This reduces keystrokes for same command.
* I install tflocal wrappter script.  The command would be:

before installing tflocal
```shell
terraform apply -auto-approve --endpoint-url=http://localhost:4566
```

after
```shell
tflocal apply -auto-approve
```

## Section 1: Introduction
### [Install Localstack CLI](https://docs.localstack.cloud/getting-started/installation/)
MacOS:
```shell
brew install localstack/tap/localstack-cli

localstack --version
3.1.0
```
 
### [Alternatives](https://docs.localstack.cloud/getting-started/installation/#alternatives)
In my case, I installed [LocalStack Desktop](https://docs.localstack.cloud/getting-started/installation/#localstack-desktop)

### [Quickstart](https://docs.localstack.cloud/getting-started/quickstart/)
A quickstart guide is a guide to walk you through the process of starting LocalStack on your local machine and 
deploying a **serverless image resizer application**.  For more details, click the link on [Quickstart](https://docs.localstack.cloud/getting-started/quickstart/)

* Starting a LocalStack instance on your local machine.
* Deploying an AWS serverless application infrastructure locally.
* Running an automated integration test suite against local infrastructure.
* Exploring the LocalStack Web Application to view deployed resources.
* Destroying the local infrastructure you have provisioned.

![img.png](img.png)

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

### Data Source

Data source is to fetch dynamic value of latest AMI, whereas tfvariable is static.

```terraform
# Creating a data source to fetch the latest Amazon Linux 2 Image in your region
data "aws_ami" "latest_amazon_linux2"{
  owners = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
```

### Output Values
* Output values are used to export structured data about resources
* Output value are like functions' return values
* Root module can use outputs to print values at the terminal after running terraform apply

### Terraform State
* Terraform stores state information about your managed infrastructure
* State is used by Terraform to map real-world resources to your configuration, keep track of metadata and to 
  improve performance

### User Data
* Passes the commands to the cloud provider which runs them on the instance.
* Idiomatic and native to the cloud providers.
* Viewable in the AWS console.

### Cloud-Init
* The standard for customizing cloud instances.
* It runs on most Linux distributions and cloud providers.
* c.oud-init can run "per-instance" or "per-boot" configurations.

## Section 4: Challenge: Provisioning AWS with Terraform
There are 14 challenges/exercises to provisioning AWS resources.  I added the challenge question in main.tf.
I skipped challenge #1.  Its question is about configure the provider & access key.  You could find the solution 
inside the main.tf.

Challenge #1

Create a Terraform configuration file with an AWS provider block. Set the region where the AWS operations will take place to us-west-1

Set the credentials (access and secret keys) of the IAM user to authenticate to AWS.

Initialize the provider plugin.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #2

Provision a new resource of type AWS VPC called production

Set the IPv4 CIDR block for the VPC to 192.168.0.0/24

Tag the new resource and use the key-value map Name = "Production VPC"

Run terraform init, terraform plan and terraform apply to provision the VPC.

Go to the AWS Management Console -> Select "us-west-1" Region -> VPC Dashboard and notice that the new VPC was created.

Change the AWS region to another one and notice that the VPC does not exist in the new region.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #3

Provision a new subnet for the production VPC with the local name webapps

Set the IPv4 CIDR block for the subnet to 192.168.0.32/27

Set the availability zone for the subnet to us-west-1b

Tag the new resource and use the key-value map Name = "Web Applications Subnet"

Apply the configuration to provision the infrastructure on AWS.

Go to the AWS Management Console -> VPC Dashboard and notice that both the VPC and the subnet were provisioned.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #4

Consider the following Terraform configuration file which provisions a resource of type AWS VPC and a subnet in the VPC. However, when you want to apply the configuration you get some errors.

Your job is to identify any errors and change the configuration so that it applies successfully.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #5

Consider the following Terraform configuration file which provisions a resource of type AWS VPC and a subnet in the VPC. However, when you want to apply the configuration you get some errors.

Your job is to identify any errors and change the configuration so that it applies successfully.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #6

Consider the following Terraform configuration file used to provision a resource of type AWS EC2 instance.

Declare output values to print out both the public and the private IP addresses.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #7

Consider the following Terraform configuration file used to provision two identical resources of type AWS EC2 instance.

Declare output values to print out both the public and the private IP addresses of both instances.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #8

Consider the following partial Terraform configuration.

Make the necessary changes to open ports 22, 25, and 80 for the incoming traffic.

Allow outgoing traffic to all protocols and all destination IP addresses.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #9

Consider the following partial Terraform configuration.

Generate an SSH key pair for authentication.

Add the Terraform code that will spin up an EC2 instance in the VPC. Run the latest version of Amazon Linux 2 or use amid="ami-04a50faf2a2ec1901"

Set the instance type to t2.micro

Associate the Default Security Group to the instance.

Configure the instance to use the SSH key pair you've just created for authentication.

Associate a public IP address to the instance.

Apply the configuration and test that you can connect to the instance using SSH and the key pair. Find the public IP address of the instance on AWS Web Console.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #10

Consider the solution to the last challenge.

Add the Terraform code that prints out at the terminal both the public and the private IP addresses of the instance.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #11

Consider the solution to the last challenge.

Change the code to start an Ubuntu Server instead of Amazon Linux 2. Take the Ubuntu AMI from the AWS Management Console.

Connect using SSH to the Ubuntu Server using the username called ubuntu

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #12

Change the solution to the last challenge so that Terraform spins up the latest version of the Ubuntu Server. Use a data source to fetch the latest version of Ubuntu.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #13

Consider the solution to the last challenge.

Add the Terraform code that initializes the server at boot as follows:

install the latest Apache2 web server.

add a new group called terraform

add a new username called backup-user. It should belong to admin and terraform groups.

make sure port 80 is open for ingress traffic.

Write all the initialization commands in a script.

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.



Challenge #14

Change the solution to the previous challenge so that only your public IP address is allowed to connect to SSH (port 22). Find out your own public IP address on https://ident.me/

Test your solution and then destroy the entire infrastructure.

Are you stuck? Do you want to see the solution to this challenge? Click here.

## Section 5: Hashicorp Configuration Language (HCL) in Depth
### Variables in Depth
1. Simple: number, string, bool, null
2. Complex:
   a. Collection types: list, map, set
   b. structural types: tuple, object

Syntax:
```terraform
variable "variable_name" {
  description = "describe the variable usage"
  type = string # could be Simple or Complex
  default = "Set default values here"
} 
```

variable.tf
```terraform
variable "azs" {
  description = "AZs in the Region"
  type        = list(string)
  default = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
  ]
}
```

### Count
1. count is used to manage similar resources
2. count and for_each are looping techniques

### Dynamic Blocks
Using Dynamic blocks is to avoid duplicated code block in the Terraform.  Advantages are:
* Legible
* Easy to maintain

### Locals
* Local values (locals) are named values that you can refer to in your configuration.
* Unlike to variables, locals do not change values during a Terraform run, and are not submitted by users but 
  calculated inside the configuration.
* Locals are available only in the current module.


## Section 6: Challenge: Hashicorp Configuration Language
* You can view it in the section-06-challenge-hcl directory.

## Section 7: Terraform Remote State and Security
* Store the state remotely using the correct backend.
* Backends define how operations are executed and where the Terraform State is stored.

Using S3 Bucket to store Terraform state

## Section 8: Challenge: Terraform Remote State and Security


## Section 9: Terraform Modules


## Section 10: Where to Go from Here? 



