variable "vpc_id" {
    description = "VPCのIDをRootModule側で指定"
}

variable "name_alb" {
    description = "ALB用SGの名前をRootModule側で指定"
}

variable "name_ec2" {
    description = "EC2用のSGの名前をRootModule側で指定"
}


variable "ip_protocol" {
    description = "SGで穴空けする際のプロトコルのデフォルトを指定"
    default = "tcp"
}

variable "cidr_ipv4" {
    description = "SGで穴空けするIPのデフォルトを指定"
    default = "0.0.0.0/0"
}

