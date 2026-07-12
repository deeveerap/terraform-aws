resource "aws_vpc" "main" {
  cidr_block = var.KKE_VPC_CIDR
  tags = {
    Name = "xfusion-priv-vpc"
  }
}

resource "aws_subnet" "mains" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.KKE_SUBNET_CIDR
  map_public_ip_on_launch = false
  depends_on = [aws_vpc.main]
  tags = {
    Name = "xfusion-priv-subnet"
  }
}

resource aws_instance ec2 {
    instance_type = "t2.micro"
    ami = "ami-08982f1c5bf93d976"
    subnet_id = aws_subnet.mains.id 
    tags = {
        Name = "xfusion-priv-ec2"
    }
}


resource "aws_security_group" "vpc_restricted_sg" {
  name        = "xfusion-priv-sg"
  description = "Allows inbound traffic strictly from within the internal VPC CIDR block"
  vpc_id      = aws_vpc.main.id

  # Inbound Rule: Restricts all protocols and ports strictly to the internal VPC network
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # "-1" means all protocols
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  # Outbound Rule: Standard rule allowing outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/16"] # Restricted out to overall internal subnet or Internet if needed
  }

  tags = {
    Name = "xfusion-priv-sg"
  }
}
