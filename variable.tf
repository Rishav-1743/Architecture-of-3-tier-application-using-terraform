#VPC Variables
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
}

#Public Subnet Variables
variable "web_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
}

variable "web_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
}

variable "web_1_az" {
  description = "Availability Zone for public subnet 1"
  type        = string
}

variable "web_2_az" {
  description = "Availability Zone for public subnet 2"
  type        = string
}

#Application Subnet Variables
variable "app_1_cidr" {
  description = "CIDR block for app subnet 1"
  type        = string
}

variable "app_2_cidr" {
  description = "CIDR block for app subnet 2"
  type        = string
}

variable "app_1_az" {
  description = "Availability Zone for app subnet 1"
  type        = string
}

variable "app_2_az" {
  description = "Availability Zone for app subnet 2"
  type        = string
}

#DB Subnet Variables
variable "db_1_cidr" {
  description = "CIDR block for db subnet 1"
  type        = string
}

variable "db_2_cidr" {
  description = "CIDR block for db subnet 2"
  type        = string
}

variable "db_1_az" {
  description = "Availability Zone for db subnet 1"
  type        = string
}

variable "db_2_az" {
  description = "Availability Zone for db subnet 2"
  type        = string
}

#EC2 Variables
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

#Frontend Instance Count
variable "frontend_count" {
  description = "Number of frontend instances"
  type        = number
}

#Backend Instance Count
variable "backend_count" {
  description = "Number of backend instances"
  type        = number
}

#DB Instance Count
variable "db_count" {
  description = "Number of db instances"
  type        = number
}

#SSH Access
variable "ssh_cidr" {
  description = "CIDR block allowed for SSH access"
  type        = string
}
