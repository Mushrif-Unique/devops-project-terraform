# ----------------------------------------
# VPC
# ----------------------------------------

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "devops-project2-vpc"
  }
}


# ----------------------------------------
# Public Subnet
# ----------------------------------------

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "devops-project2-public-subnet"
  }
}


# ----------------------------------------
# Internet Gateway
# ----------------------------------------

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "devops-project2-igw"
  }
}


# ----------------------------------------
# Public Route Table
# ----------------------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "devops-project2-public-route-table"
  }
}


# ----------------------------------------
# Route Table Association
# ----------------------------------------

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ----------------------------------------
# EC2 Security Group
# ----------------------------------------

resource "aws_security_group" "ec2" {
  name        = "devops-project2-ec2-sg"
  description = "Security group for DevOps Project 2 EC2 instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project2-ec2-sg"
  }
}

# ----------------------------------------
# EC2 Key Pair
# ----------------------------------------

resource "aws_key_pair" "deployer" {
  key_name   = "devops-project2-key"
  public_key = file("C:/Users/MUSHR/.ssh/Demo1.pem.pub")

  tags = {
    Name = "devops-project2-key"
  }
}

# ----------------------------------------
# EC2 Instance
# ----------------------------------------

resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  tags = {
    Name = "devops-project2-app-server"
  }
}