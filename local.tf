locals {
  servicename = "ecs-github-actions"
  env         = "actions"
  repo        = "actions"
  directory   = "/sekigaku/actions"

  //自宅用IP
  current-ip = chomp(data.http.ifconfig.body)
  my_ip      = (var.my_ipv4 == null) ? "${local.current-ip}/32" : var.my_ipv4
}