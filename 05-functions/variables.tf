variable "ami_id" {
    type = string
    default = "ami-0220d79f3f480ecf5"
    description = "RHEL9 joindevops image"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "zone_id" {
  type = string
  default = "Z0968816Y6XJN6LDEDWK"
}

variable "domain_name" {
    type = string
    default = "learndevopskills.shop"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the web server"
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro","t3.small","t3.medium","t3.large"], var.instance_type)
    error_message = "instance type should be either t3.micro or t3.small"
  }
}

variable "sg_name" {
  type    = string
  default = "allow_terraform_vars"
}

variable "port" {
    default = 0
    type = number
}

variable "cidr" {
    default = ["0.0.0.0/0"]
    type = list
}


variable "instances" {
    default = ["mongodb", "redis", "mysql","frontend"]
    type = list

}

variable "project" {
  default = "roboshop"
  type = string
}

variable "common-tags" {
  default = {
    Project = "roboshop"
    Environment = "dev"
  }
}



