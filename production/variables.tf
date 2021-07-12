variable "environment" {
    description = "The deployment environment in use"
    type = string
}

variable "owner" {
    description = "The name of the owner"
    type = string
}

variable "project" {
    description = "The name of the project for the resource"
    type = string
}

variable "terraform" {
    description = "If the deployment is using Terraform"
    type = bool
    default = true
}