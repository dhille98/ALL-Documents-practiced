# Create a VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "eks_vps"
  }
}

# Create subnets
resource "aws_subnet" "subntes" {
  count             = length(var.subnet_names)
  vpc_id            = aws_vpc.eks_vpc.id
  availability_zone = var.azs[count.index % length(var.azs)]
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index)
  map_public_ip_on_launch  = true

  tags = {
    "Name" = var.subnet_names[count.index]
  }
}

# Create Internet Gateway (IGW)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "eks-igw"
  }
}

# Create Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Public Subnet Associations
resource "aws_route_table_association" "pb_sub_asso_1" {
  subnet_id      = aws_subnet.subntes[0].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pb_sub_asso_2" {
  subnet_id      = aws_subnet.subntes[1].id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "pb_sub_asso_3" {
  subnet_id      = aws_subnet.subntes[2].id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "pb_sub_asso_4" {
  subnet_id      = aws_subnet.subntes[3].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "eks_cluster_sg" {
  vpc_id = aws_vpc.eks_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}

resource "aws_security_group" "eks_node_sg" {
  vpc_id = aws_vpc.eks_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-node-sg"
  }
}



