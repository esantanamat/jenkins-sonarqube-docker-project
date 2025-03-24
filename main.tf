provider "aws" {
  region = var.region
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"

  dynamic "ingress" {
    for_each = [22, 80]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ingress.value == 22 ? [var.my_ip] : ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}

resource "aws_instance" "my_ec2" {
  for_each = var.ec2_instances
  ami = each.value.ami
  instance_type = each.value.type
  key_name = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.allow_ssh.name]
  tags = {
    Name = each.key
  }
}

resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = tls_private_key.my_key.public_key_openssh
}

output "private_key" {
  value     = tls_private_key.my_key.private_key_pem
  sensitive = true
}

