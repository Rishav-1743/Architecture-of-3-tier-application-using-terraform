<img width="1536" height="1024" alt="f681d9ed-2078-47ec-bc5c-22a7d8f53dab" src="https://github.com/user-attachments/assets/7a54834a-c352-4a4d-b16d-b40cbb41ba28" /># Architecture-of-3-tier-application-using-terraform
This project provisions a highly available and secure 3-tier architecture on AWS using Terraform.  The infrastructure includes:  Custom VPC Public and Private Subnets across multiple Availability Zones Internet Gateway NAT Gateway Route Tables Security Groups Frontend, Backend, and Database EC2 instances




**Architecture Overview**
The architecture is divided into three layers:

**1. Frontend Tier (Presentation Layer)**
Two EC2 instances deployed in public subnets
- Accessible from the internet
- Handles user/client requests
- Connected through public route table and Internet Gateway

**2. Backend Tier (Application Layer)**
- Two EC2 instances deployed in private subnets
- Processes business logic and application requests
- Accessible only from frontend servers
- Uses NAT Gateway for outbound internet access
  
**3. Database Tier (Data Layer)**
- Two database servers deployed in private DB subnets
- Accessible only from backend servers
- No direct internet exposure for enhanced security
- 
**Networking Components**
- VPC with custom CIDR block
- Internet Gateway for public internet connectivity
- NAT Gateway for secure outbound internet access from private subnets
- Route Tables for traffic routing**
- Security Groups for controlled access between tiers
  
**Security Design**
- Frontend servers allow HTTP/SSH access
- Backend servers accept traffic only from frontend tier
- Database servers accept traffic only from backend tier
- Private subnets are isolated from direct internet access
  
**Terraform Features Used**
- Resource dependencies
- Count meta-argument
- Route table associations
- Modular infrastructure design
- Infrastructure as Code (IaC)
  
**Traffic Flow**
- Internet → Frontend Tier → Backend Tier → Database Tier
  
**Tools & Technologies**
-Terraform
-AWS EC2
-AWS VPC
- NAT Gateway
- Internet Gateway
- Route Tables
- Security Groups

