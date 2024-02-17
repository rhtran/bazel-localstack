variable "users" {
  type    = list(string)
  default = ["demo-user", "admin1", "john"]
}

/*
* for_each allows to remove the element from any in the list
* and not allow the duplication.
*/
resource "aws_iam_user" "test" {
  for_each = toset(var.users) # converts a list to a set
  name     = each.key
}