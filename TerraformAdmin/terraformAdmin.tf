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

resource "aws_s3_bucket" "terraform_state" {
  bucket = "protag-terraform-up-and-running-state"
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "protag-terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
