resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.KKE_VPC_NAME
  }
}

resource "aws_subnet" "mains" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  depends_on = [aws_vpc.main]

  tags = {
    Name = var.KKE_SUBNET_NAME
  }
}


output "kke_vpc_name" {
  value       = aws_vpc.main.id
  description = "The unique identifier of the deployed VPC"
}

output "kke_subnet_name" {
  value       = aws_subnet.mains.id
  description = "The unique identifier of the deployed Subnet"
}
