# VPC Variables
variable "region" {
  default       = "ap-south-1"
  description   = "AWS Region"
  type          = string
}

variable "vpc-cidr" {
  default       = "10.0.0.0/16"
  description   = "VPC CIDR Block"
  type          = string
}

variable "public-subnet-1-cidr" {
  default       = "10.0.0.0/24"
  description   = "Public Subnet 1 CIDR Block"
  type          = string
}

variable "private-subnet-1-cidr" {
  default       = "10.0.2.0/24"
  description   = "Private Subnet 1 CIDR Block"
  type          = string
}

variable "ssh-location" {
  default       = "0.0.0.0/0"
  description   = "iP Address that can ssh into ec2 Instance"
  type          = string
}

variable "database-snapshot-identifier" {
  default       = "arn:aws:rds:ap-south-1:236992799653:snapshot:mysql"
  description   = "database snapshot arn"
  type          = string
}

variable "database-instance-class" {
  default       = "db.t2.micro"
  description   = "database instance type"
  type          = string
}

variable "database-instance-identifier" {
  default       = "database-1"
  description   = "database instance identifier"
  type          = string
}


variable "multi-az-deployment" {
  default       = false
  description   = "create a standby db instance"
  type          = bool
}


variable key_name {
  default = "final_project"
  description   = "key name"
  type = string
}
