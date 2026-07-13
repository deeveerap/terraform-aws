# Create a local key pair 
resource "tls_private_key" "devops-kp-local" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Store the private key in a local file
resource "local_file" "ssh_key" {
  filename = "/home/bob/devops-kp.pem"
  content  = tls_private_key.devops-kp-local.private_key_pem
}

#Store the public key to AWS 
resource "aws_key_pair" "devops-kp" {
  key_name   = var.KKE_KEY_NAME
  public_key = tls_private_key.devops-kp-local.public_key_openssh
}

resource "aws_instance" "ec2" {
  count         = var.KKE_INSTANCE_COUNT
  instance_type = var.KKE_INSTANCE_TYPE
  ami           = local.AMI_ID
  key_name = aws_key_pair.devops-kp.key_name
  tags = {
    Name = "${var.KKE_INSTANCE_PREFIX}-${count.index + 1}"
  }
}
