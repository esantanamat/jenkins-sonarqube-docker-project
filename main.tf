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
      cidr_blocks = ingress.value == 22 ? ["0.0.0.0/0"] : ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  

  ingress {
    from_port = 9000
    to_port = 9000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    from_port = 8085
    to_port = 8085
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "jenkins_sg" {
  name = "jenkins_sg"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Only allow your IP
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.my_ip]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instances" {
  for_each = var.ec2_instances
  ami = each.value.ami
  instance_type = each.value.type
  key_name = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.allow_ssh.name]
  tags = {
    Name = each.key
  }
}

resource "aws_instance" "jenkins_ec2" {
  for_each = var.jenkins_instance
  ami = each.value.ami
  instance_type = each.value.type
  key_name = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.jenkins_sg.name]
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

resource "local_file" "private_key_pem" {
  content  = tls_private_key.my_key.private_key_pem
  filename = "my-private-key.pem"
}

resource "local_file" "public_key" {
  content  = tls_private_key.my_key.public_key_openssh
  filename = "my-key.pub"
}