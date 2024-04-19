
variable "RDS_name"{
  default = "MyRDS"
  type = string
}
variable "RDS_username"{
  default = "Username_here"
  type = string
}
variable "RDS_password"{
  default = "yourpassword_here"
  type = string
}
variable "ssh_key_name"{
  default = "jadhav"    //must be Present in AWS EC2 in Your Region
  type = string
}
