output "kke_vpc_name" {
  value       = aws_vpc.main.id
  description = "The unique identifier of the deployed VPC"
}

output "kke_subnet_name" {
  value       = aws_subnet.mains.id
  description = "The unique identifier of the deployed Subnet"
}
