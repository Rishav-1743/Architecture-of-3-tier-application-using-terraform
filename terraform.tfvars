#VPC
vpc_cidr = "10.0.0.0/16"
vpc_name = "three tier vpc"

#Public Subnets
web_1_cidr = "10.0.1.0/24"
web_2_cidr = "10.0.2.0/24"

web_1_az = "ap-south-1a"
web_2_az = "ap-south-1b"

#Application Subnets
app_1_cidr = "10.0.3.0/24"
app_2_cidr = "10.0.4.0/24"

app_1_az = "ap-south-1a"
app_2_az = "ap-south-1b"

#Database Subnets
db_1_cidr = "10.0.5.0/24"
db_2_cidr = "10.0.6.0/24"

db_1_az = "ap-south-1a"
db_2_az = "ap-south-1b"

#EC2 Configuration
ami_id        = "ami-0f58b397bc5c1f2e8"
instance_type = "t2.micro"

#Instance Counts
frontend_count = 2
backend_count  = 2
db_count       = 2

#SSH Access CIDR
ssh_cidr = "43.243.81.89/32"
