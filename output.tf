output "vpc_id" {
    description = "ID of the vpc"
    value       =aws_vpc.my_app.id
}

#Subnet output
output "public_subnet_Ids" {
  description = "ID's of public subnet"
  value = [
    aws_subnet.Web_1.id,
    aws_subnet.Web_2.id,
  ]
}
#output of private_app subnet_id
output "private_app_subnet_ids" {
    description = "ID's of private_app"
    value =[
        aws_subnet.app_1.id,
        aws_subnet.app_2.id,
    ]
  
}

#output of private_db subnet_id
output "private_db_subnet_ids" {
    description = "ID's of private_db"
    value =[
        aws_subnet.db_1.id,
        aws_subnet.db_2.id,
    ]
  
}

#output of Internet_gateway
output "ID_of_Internet_gateway" {
    description = "ID of Internet Gateway"
    value       =aws_internet_gateway.igw.id
  
}

#output of NAT_Gateway
output "nat_gateway_id" {
    description = "ID of NAT_Gateway"
    value       =aws_nat_gateway.nat.id
  
}
output "eip_id" {
    description ="Elastic_IP"
    value       =aws_eip.nat_eip.id
  
}

#Route_table output
output "public_route_table_id" {
    description = "Public Route_Table ID"
    value       =aws_route_table.Public_rt.id
  
}

output "private_route_table_id" {
    description = "Private Route Table ID"
    value       =aws_route_table.Private_rt.id
  
}

#Security_Groups output
output "frontend_sg_id" {
    description = "Frontend Security Group ID"
    value       =aws_security_group.frontend_sg.id
  
}
output "Backend_sg-id" {
    description = "Backend Security Group ID"
    value       =aws_security_group.Backend_sg.id
  
}

output "db_sg_id" {
  description = "DB Security Group ID"
  value       =aws_security_group.db_sg.id
}

#Frontend EC2 Instances
output "frontend_instance_id" {
    description = "ID's of frontend EC2 Instances"
    value       =aws_instance.frontend[*].id
  
}

output "frontend_public_ips" {
  description = "Public IPs of frontend EC2 instances"
  value       = aws_instance.frontend[*].id
}

#Backend EC2 Outputs
output "backend_instance_ids" {
  description = "IDs of backend EC2 instances"
  value       = aws_instance.backend[*].id
}

output "backend_private_ips" {
  description = "Private IPs of backend EC2 instances"
  value       = aws_instance.backend[*].private_ip
}

#Database EC2 Outputs
output "db_instance_ids" {
  description = "IDs of DB EC2 instances"
  value       = aws_instance.db_server[*].id
}

output "db_private_ips" {
  description = "Private IPs of DB EC2 instances"
  value       = aws_instance.db_server[*].private_ip
}

