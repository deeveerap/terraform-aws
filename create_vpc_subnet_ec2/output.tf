output "KKE_vpc_name" {
  value       = aws_vpc.main.tags["Name"]
  description = "The unique identifier of the deployed VPC"
}

output "KKE_subnet_name" {
  value       = aws_subnet.mains.tags["Name"]
  description = "The unique identifier of the deployed Subnet"
}

output "KKE_ec2_private" {
  value       = aws_instance.ec2.tags["Name"]
  description = "The unique identifier of the deployed Subnet"
}
