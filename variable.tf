variable "my_ipv4" {
  type    = string
  default = null
}

variable "instance_name" {
  type = list(string)
  default = ["neo","trinity","morpheus"]
}

variable "animals" {
  type = list(string)
  default = ["cat","dog"]
}