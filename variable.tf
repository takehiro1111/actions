variable "my_ipv4" {
  type    = string
  default = null
}

variable "in_name" {
  type = string
  default = "count"
}

variable "instance_name" {
  type = list(string)
  default = ["neo","trinity","morpheus"]
}

variable "animals" {
  type = list(string)
  default = ["cat","dog"]
}

variable "iam_user" {
  type = list(string)
  default = []
}

variable "my_map" {
  type    = map(string)
  default = {
    key = "tanaka"
    value = "takehiro"
  }
}

variable "bool" {
  type = bool
  default = true
}
