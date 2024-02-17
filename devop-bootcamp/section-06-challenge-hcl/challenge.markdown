## Challenge #1

Consider the following Terraform configuration file.  Parametrize the configuration using variables as follows:
* declare a variable of type string for the AWS region.
* declare a variable of type bool for the enable_dns_support attribute.
* set default values for both variables and use them in main.tf

Are you stuck? Do you want to see the solution to this challenge? Click [here]().

---
## Challenge #2

Consider this terraform configuration file and the following variable declarations:
```terraform
variable "aws_region" {
  type    = string
  default = "us-west-1"
}

variable "my_ami" {
  type    = map(string)
  default = {
    "eu-central-1" = "ami-0dcc0ebde7b2e00db",
    "us-west-1"    = "ami-04a50faf2a2ec1901"
  }
}

variable "my_instance" {
  type    = tuple([string, number, bool])
  default = ["t2.micro", 2, true]
}
```

* Import the variable declarations into your terraform project.
* Parametrize the configuration file (main.cf) and use variables for the following attributes: region, ami, 
  instance_type, associate_public_ip_address and count

Are you stuck? Do you want to see the solution to this challenge? Click [here]().

---
## Challenge #3
* Consider the following Terraform configuration file
* Change the configuration so that it creates three identical instances.
* Add the code that creates three IAM users (user1, user2 and user3). Use the count argument.

Are you stuck? Do you want to see the solution to this challenge? Click [here]().

---
## Challenge #4
Consider the solution from the previous challenge.
* Change the code and use for_each instead of count to create the IAM users.

Are you stuck? Do you want to see the solution to this challenge? Click [here]().


---
## Challenge #5
Consider the following Terraform configuration file
* Add the code and change the default Security Group to open ports 20, 21, 22, 23, 80, 110, 143, 443, 995, 8080, 
10100 for incoming traffic.

Are you stuck? Do you want to see the solution to this challenge? Click [here]().


---
## Challenge #6
* Change the solution to this challenge and use dynamic blocks for the ingress ports that are allowed.

Are you stuck? Do you want to see the solution to this challenge? Click [here]().


---
## Challenge #7

* Create an empty Terraform configuration file and declare a local value called time that stores the current date and 
time.
* Declare an output value to display the local value called time when running terraform apply
* Declare a second output value to display the current date and time in the following format "March 24, 2022 07:49:57 
  UTC"

Are you stuck? Do you want to see the solution to this challenge? Click [here]().


---
## Challenge #8

* Create an empty Terraform configuration file and declare two maps:
environment which maps "test" to "us-west-1" and "production" to "us-west-2"
availability_zones which maps "us-west-1" to "us-west-1a,us-west-1b,us-west-1c" and "us-west-2" to "us-west-2a,us-west-2b,us-west-2c"

* Declare an output value that displays the last availability zone ("us-west-2c") in the "us-west-2" region. Use the 
built-in functions element(), split() and lookup()

Are you stuck? Do you want to see the solution to this challenge? Click [here](https://drive.google.com/drive/folders/1S8Mn6WcTGQftiT4BOWLifDIlFaBAPTqn?usp=sharing).