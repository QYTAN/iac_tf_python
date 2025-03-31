terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-1"
}

# Create an ec2 instance
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-05506fa68391b4cb1"  # Replace with a valid AMI ID (this is Amazon Linux 2)
  instance_type = "t2.micro"  # Free tier instance type

  tags = {
    Name = "ec2terraforminstance"
  }

  # Attach the existing security group
  security_groups = [data.aws_security_group.existing_sg.name]

  key_name = "ec2instancekeypair_terraform"  # Replace with your SSH key pair name
}

# Data block to get the existing security group by ID or name
data "aws_security_group" "existing_sg" {
  id = "sg-0e4fbbb6b594cb43d"  # Replace this with the ID of your existing security group
}