terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # prevent unexpected upgrades
      version = "~> 3.2.0"
    }
  }
}

provider "aws" {
  profile = "dwest-protag"
  region  = "us-west-2" 

  ignore_tags {
    key_prefixes = ["kubernetes.io/"]
  }
}

resource "aws_instance" "example" {
  # ami's can be region-specific
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags          = {
    Name        = "Testing Server"
    Environment = "test"
  }

  # vpc_security_group_ids = ["sg-0077..."]
  # subnet_id              = "subnet-923a..."
}

