variable "ami_id" {
    type = string
    default = "ami-0220d79f3f480ecf5"
    description = "RHEL9 joindevops image"
}

variable "environment" {
  type = string
  default = "prod"
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

variable "ec2-tags" {
  type        = map
  description = "EC2 instance tags"
  default     = {
    Name = "allow-terraform-1"
    Project = "roboshop"
    Environment = "dev"
  }
}

variable "sg_name" {
    type = string
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

variable "sg-tags" {
  type        = map
  description = "EC2 sg tags"
  default     = {
    Name = "allow-terraform"
    Project = "roboshop"
    Environment = "dev"
  }
}


