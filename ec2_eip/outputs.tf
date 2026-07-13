output "KKE_instance_name" {
    value = aws_instance.devops_ec2.tags["Name"]
}

output "KKE_eip" {
    value = aws_eip.aws_eip_new.public_ip
}
