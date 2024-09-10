//This Terraform file will create a new EC2 instance within the ACG Sandbox available region
//Pre installed with Logstash
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.53.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

//EC2
resource "aws_instance" "TF-VM" {
  ami                    = var.ami
  instance_type          = var.instance_type
  user_data              = data.template_cloudinit_config.logstash_script.rendered
  key_name               = "HWC"
  security_groups        = [aws_security_group.TF_security_group.name]

  tags = {
    Name = "TF-VM"
  }
}
