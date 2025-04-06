resource "aws_vpc" "medusa_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "medusa-vpc-${var.environment}"
  }
}

resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.medusa_vpc.id
  cidr_block        = "10.0.${count.index + 1}.0/24"
  availability_zone = "${var.aws_region}a"  # You may improve later by random AZs

  tags = {
    Name = "medusa-public-${count.index + 1}-${var.environment}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.medusa_vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.medusa_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_security_group" "medusa" {
  name        = "medusa-sg-${var.environment}"
  description = "Medusa ECS Security Group"
  vpc_id      = aws_vpc.medusa_vpc.id

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.medusa_vpc.id
  cidr_block        = "10.0.${count.index + 3}.0/24"  # 10.0.3.0/24, 10.0.4.0/24
  availability_zone = "${var.aws_region}b"  # Or another AZ

  tags = {
    Name = "medusa-private-${count.index + 1}-${var.environment}"
  }
}

