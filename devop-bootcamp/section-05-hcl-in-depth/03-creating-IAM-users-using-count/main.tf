# Creating more resources using count (loop technique)
#resource "aws_iam_user" "test" {
#  name  = "x-user${count.index}"
#  count = 5
#}

variable "users" {
  type    = list(string)
  default = ["demo-user", "admin1", "john"]
}

/*
* The disadvantage of using count is that you can only
* remove the element or user at the end of the list.
* Otherwise, Terraform will return error.
*/resource "aws_iam_user" "test" {
  name  = element(var.users, count.index)
  path  = "/system"
  count = length(var.users)
}
