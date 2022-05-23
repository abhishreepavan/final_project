# Create VPC
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block              = "${var.vpc-cidr}"
  instance_tenancy        = "default"
  enable_dns_hostnames    = true 

  tags      = {
    Name    = "VPC"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id    = aws_vpc.vpc.id 

  tags      = {
    Name    = "Internet Gateway"
  }
}

# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "${var.public-subnet-1-cidr}"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "Public Subnet"
  }
}

# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags       = {
    Name     = "Public Route Table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-1.id
  route_table_id      = aws_route_table.public-route-table.id
}

# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "private-subnet-1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               =  "${var.private-subnet-1-cidr}"
  availability_zone        = "ap-south-1b"
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "Private Subnet"
  }
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["one", "two"])

  name = "instances"

  ami                    = "ami-079b5e5b3971bd10d"
  instance_type          = "t2.micro"
  key_name               = "ansible_terraform"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.database-security-group.id]
  subnet_id              = aws_subnet.public-subnet-1.id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}