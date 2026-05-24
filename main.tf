resource "aws_vpc" "my_app" {
    cidr_block = "10.0.0.0/16"

    tags = {
    Name = "three tier vpc"
    }
}

#Public subnet for Frontend
resource "aws_subnet" "Web_1" {
    vpc_id = aws_vpc.my_app.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true

    tags = {
      Name ="Public_subnet_1"
    }
  
}

resource "aws_subnet" "Web_2" {
    vpc_id = aws_vpc.my_app.id
    cidr_block = "10.0.2.0/24"
    availability_zone  = "ap-south-1b"
     map_public_ip_on_launch = true

    tags = {
      Name ="Public_subnet_2"
    }
  
}

#Private subnet for backend
resource "aws_subnet" "app_1" {
    vpc_id = aws_vpc.my_app.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = false


    tags = {
      Name ="Private_subnet_1"
    }
  
}

resource "aws_subnet" "app_2" {
    vpc_id = aws_vpc.my_app.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "ap-south-1b"
  map_public_ip_on_launch = false

    tags = {
      Name ="Private_subnet_2"
    }
  
}

#Private subnet for DB servers
resource "aws_subnet" "db_1" {
    vpc_id = aws_vpc.my_app.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = false

    tags = {
      Name ="db_subnet_1"
    }
  
}

resource "aws_subnet" "db_2" {
    vpc_id = aws_vpc.my_app.id
    cidr_block = "10.0.6.0/24"
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = false

    tags = {
      Name ="db_subnet_2"
    }
  
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my_app.id

    tags = {
      Name="main-igw"
    }
  
}

#NAT Gateway
#Elatic_ip

resource "aws_eip" "nat_eip" {
    domain = "vpc"
  
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.Web_1.id

  tags = {
    Name= "main-nat"
  }
depends_on =[aws_internet_gateway.igw]
}

#Route_Tables
#Route_Tables for Public_subnet_1
resource "aws_route_table" "Public_rt" {
  vpc_id = aws_vpc.my_app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name ="Public_rt"
  }
}

#Route_table for Private_ip
resource "aws_route_table" "Private_rt" {
  vpc_id = aws_vpc.my_app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name ="Private_rt"
  }
}

#Associate_public_route_tables
resource "aws_route_table_association" "public_asso_1" {
  subnet_id      = aws_subnet.Web_1.id
  route_table_id = aws_route_table.Public_rt.id
}
resource "aws_route_table_association" "public_asso_2" {
  subnet_id      = aws_subnet.Web_2.id
  route_table_id = aws_route_table.Public_rt.id
}

#Associate_private_route_tables
resource "aws_route_table_association" "private_asso_1" {
  subnet_id      = aws_subnet.app_1.id
  route_table_id = aws_route_table.Private_rt.id
}
resource "aws_route_table_association" "private_asso_2" {
  subnet_id      = aws_subnet.app_2.id
  route_table_id = aws_route_table.Private_rt.id
}

#Associate_db_subnets
resource "aws_route_table_association" "private_db_asso_1" {
  subnet_id      = aws_subnet.db_1.id
  route_table_id = aws_route_table.Private_rt.id
}

resource "aws_route_table_association" "private_db_asso_2" {
  subnet_id      = aws_subnet.db_2.id
  route_table_id = aws_route_table.Private_rt.id
}

#Security_Group
#Frontend
resource "aws_security_group" "frontend_sg" {
  name = "frontend_sg"
  vpc_id = aws_vpc.my_app.id

  ingress{
    from_port  =80
    to_port    =80
    protocol   ="tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port   =22
    to_port     =22
    protocol    ="tcp"
    cidr_blocks =["43.243.81.89/32"]
  }
  
  egress{
    from_port   =0
    to_port     =0
    protocol    ="-1"
    cidr_blocks =["0.0.0.0/0"]
  }
}

#Backend_sg
resource "aws_security_group" "Backend_sg" {
    name = "backend"
    vpc_id = aws_vpc.my_app.id

    ingress{
    from_port   =22
    to_port     =22
    protocol    ="tcp"
    security_groups =[aws_security_group.frontend_sg.id]
  }
  ingress{
    from_port   =8080
    to_port     =8080
    protocol    ="tcp"
    security_groups =[aws_security_group.frontend_sg.id]
  }
  egress{
    from_port   =0
    to_port     =0
    protocol    ="-1"
    cidr_blocks =["0.0.0.0/0"]
  }
}
resource "aws_security_group" "db_sg" {
  name = "db_sg"
  vpc_id = aws_vpc.my_app.id

  ingress{
    from_port   =3306
    to_port     =3306
    protocol    ="tcp"
    security_groups =[aws_security_group.Backend_sg.id]
  }
  egress{
    from_port   =0
    to_port     =0
    protocol    ="-1"
    cidr_blocks =["0.0.0.0/0"]
    }
  }

#EC2 Instances
#Frontend_instances
resource "aws_instance" "frontend" {
    count = 2
  ami  = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
  subnet_id = element(
      [
        aws_subnet.Web_1.id,
        
      aws_subnet.Web_2.id
      ],
      count.index
  )
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]


  tags = {
    Name = "frontend-(count.index +1)"
  }
}

#Backend_instances
resource "aws_instance" "backend" {
    count = 2
  ami  = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
  subnet_id = element(
    [
      aws_subnet.app_1.id,
      aws_subnet.app_2.id
      ],
      count.index
  )
  vpc_security_group_ids = [aws_security_group.Backend_sg.id]


  tags = {
    Name = "backend-(count.index +1)"
  }
}

#db_instances
resource "aws_instance" "db_server" {
    count = 2
  ami  = "ami-0f58b397bc5c1f2e8"
  instance_type = "t2.micro"
  subnet_id =element(
    [
      aws_subnet.db_1.id,
      aws_subnet.db_2.id
      ],
      count.index
  )
  vpc_security_group_ids = [aws_security_group.db_sg.id]


  tags = {
    Name = "db-(count.index +1)"
  }
}

