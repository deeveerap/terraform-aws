data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "devops_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  
  tags = {
    Name = "devops-ec2"
  }
}


resource aws_eip aws_eip_new {
    tags = { Name = "devops-eip" }
}


resource "aws_eip_association" "devops_eip_assoc" {
  instance_id   = aws_instance.devops_ec2.id
  allocation_id = aws_eip.aws_eip_new.id
}
