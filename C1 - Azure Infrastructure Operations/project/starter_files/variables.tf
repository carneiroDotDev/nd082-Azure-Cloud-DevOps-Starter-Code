variable "prefix" {  
    description = "Prefix"
    default = "p1"
}

variable "tenant_id" {
    description = "Udacity Lab tenant ID"
    default = "f958exxx6b6d07"
}

variable "client_id" {  
    description = "Udacity Lab App ID"
    default = "9aafxxx077"
}

variable "client_secret" {  
    description = "Azure secret id"
    default = "r4xxx4Ndlq"
}

variable "subscription_id" {  
    description = "Azure subscription id"
    default = "055225e5xxx76965"
}

variable "username" {
  description = "VM username"
  default = "adminuser"
}

variable "password" {
  description = "VM password"
  default = "Password1!"
}

variable "number_of_virtual_machines" {
    description = "Number of VMs to be deployed max=5"
    type = number
    default = 2
}

variable "location" {
    description = "The Azure Region where all resources will be created"
    default = "usc"
}