locals {
  servicename = "ecs-github-actions"
  env         = "actions"
  repo        = "actions"
  directory   = "/sekigaku/actions"

  //自宅用IP
  current_ip = chomp(data.http.myip.body)
  my_ip      = (var.my_ipv4 == null) ? "${local.current_ip}/32" : var.my_ipv4

  //try
  try_test = [
    {
      name = "try1",
      // description = "try-first"
    },
    {
      name = "try2"
    },
  ]
}