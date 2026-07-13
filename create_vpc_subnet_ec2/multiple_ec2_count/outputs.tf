output "kke_instance_names" {
  value = aws_instance.ec2[*].tags["Name"]
}
