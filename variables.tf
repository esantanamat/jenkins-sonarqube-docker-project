variable "region" {
  type    = string
  default = "us-east-1"
}


variable "ec2_instances" {
  default = {
    "SonarQube"  = { type = "t3.medium", ami = "ami-08c40ec9ead489470" }
    "Docker"  = { type = "t2.micro", ami = "ami-08c40ec9ead489470" }
  }
}

variable "jenkins_instance" {
  default = {
    "jenkins" = { type = "t2.micro", ami = "ami-08c40ec9ead489470" }
  }
}

variable "my_ip" {
  type    = string
}

