output "current" {
  value = data.aws_caller_identity.current
}

# output "instance_arn" {
#   #value = aws_instance.count[0].arn
#   value = aws_instance.count[*].arn
# }

# output "iam_users" {
#   value = values(aws_iam_user.name)[*].arn
# }

variable "map" {
  type = map(string)
  default = {
    tanaka = "takehiro"
    sports = "soccer"
    from = "fukuyama"
    from = "fukuyama"

  }
}

output "for" {
  value = [ for key in var.map : upper(key) ]
}

output "for_short" {
  value = [ for key in var.map : upper(key) if length(key) < 7 ]
}

output "for_sentence" {
  value = [ for key , value in var.map : "${key} is ${value}" ]
}

output "for_set" {
  value = { for key , value in var.map : upper(key) => upper(value) } //集合(sset)
}


variable "list" {
  type = list(string)
  default = ["soccer","baseball","tennis"]
}

output "for_directive" {
  value = "%{ for name in var.list}${name}, %{ endfor } "
}

output "for_directive_index" {
  value = "%{ for i, key in var.list}  ${key} (${i}) , %{endfor}"
}

output "for_directive_index2" {
  value = "%{ for i, key in var.list} (${i}) ${key} , %{endfor}"
}