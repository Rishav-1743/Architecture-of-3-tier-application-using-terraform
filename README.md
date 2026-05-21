
# Architecture-of-3-tier-application-using-terraform
This project provisions a highly available and secure 3-tier architecture on AWS using Terraform.  The infrastructure includes:  Custom VPC Public and Private Subnets across multiple Availability Zones Internet Gateway NAT Gateway Route Tables Security Groups Frontend, Backend, and Database EC2 instances

**Architecture Overview**

The architecture is divided into three layers:

<img width="1536" height="1024" alt="f681d9ed-2078-47ec-bc5c-22a7d8f53dab" src="https://github.com/user-attachments/assets/7a54834a-c352-4a4d-b16d-b40cbb41ba28" />

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


**Workflow of the 3-Tier Architecture**

This architecture follows a secure layered communication model where each tier communicates only with the required tier.

**Step-by-Step Workflow**

1. User Accesses the Application
A user sends a request from the internet:

User → Internet

The request enters the AWS environment through the:

- Internet Gateway (IGW)

**2. Request Reaches Frontend Tier**
The Internet Gateway forwards traffic to the frontend servers located in the public subnets.

**Frontend Tier:**

Frontend Server 1

Frontend Server 2

These servers:

- Host web application/UI
- Accept HTTP/HTTPS requests
- Are publicly accessible

Traffic Flow:

Internet → Internet Gateway → Frontend Servers

Public Route Table:

0.0.0.0/0 → Internet Gateway

This allows internet access.

**3. Frontend Communicates with Backend Tier**

After receiving user requests, frontend servers send application/API requests to backend servers.

Backend Tier:

Backend Server 1

Backend Server 2

These servers:

- Process business logic
- Handle APIs
- Run internal services/applications

Security:

- Backend servers are in private subnets
- No direct internet access
- Only frontend security group can access backend security group

Traffic Flow:

Frontend Tier → Backend Tier

Example:

- Frontend sends request on port 8080
- Backend processes request
  
**4. Backend Accesses Database Tier**

Backend servers communicate with database servers for:

- Reading data
- Writing data
- Authentication
- Transactions

Database Tier:

Database Server 1

Database Server 2

These servers:

- Store application data
- Are completely private
- Only accessible from backend tier

Security:

DB security group allows traffic only from backend SG on DB port (3306)

Traffic Flow:

Backend Tier → Database Tier

**5. Response Returns Back**

After processing:

Database → Backend → Frontend → User

The user receives the final response.

**NAT Gateway Workflow**

Private instances (Backend + DB) cannot directly access the internet.
But sometimes they need internet for:

OS updates

- Package installation
- Docker pulls
- API access

So traffic goes through NAT Gateway.

Outbound Internet Workflow

Private Server ->> Private Route Table ->> NAT Gateway ->> Internet Gateway ->> Internet

Private route table contains:

0.0.0.0/0 → NAT Gateway


**Complete Traffic Flow**

User ->> Internet Gateway ->> Frontend Tier (Public Subnet) ->> Backend Tier (Private Subnet) ->> Database Tier (Private DB Subnet)

**Summary**

This architecture provides:

- Secure network isolation
- Controlled communication between tiers
- Internet-facing frontend
- Private backend/database
- Outbound internet through NAT Gateway
- Infrastructure automation using Terraform
