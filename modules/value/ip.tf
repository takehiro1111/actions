output "vpc_ip" {
    value =  "192.168.0.0/16"
}

output "subnet_ip" {
    value = {
       public_a = "192.168.1.0/24"
       public_c = "192.168.2.0/24"
       public_d = "192.168.3.0/24"

       private_a = "192.168.5.0/24"
       private_c = "192.168.6.0/24"
       private_d = "192.168.7.0/24"
    }
}

output "gateway_ip" {
    value = {
        igw = "0.0.0.0/0"
        nat = "0.0.0.0/0"
    }
}