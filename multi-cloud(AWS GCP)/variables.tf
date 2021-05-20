#string
variable "x"{
default = "t2.micro"
type = string
}

#
variable "instance_type" {}
variable "machine_type" {}


#boolen
variable "y"{
    type=bool
}

output "o1"{
    value = var.y
}

variable "isprod" {
  type = bool
  default = true
  
}


#list
variable "az_name" {
  type    = list
  default = [  "ap-south-1a" , "ap-south-1b", "ap-south-1c" ]
}

#map
variable "types" {
    type = map
    default = {
        us-east-1 = "t2.nano",
        ap-south-1 = "t2.micro",
        us-west-1 = "t2.medium"
    }
}

output "o3" {
    value = var.types["ap-south-1"]
}