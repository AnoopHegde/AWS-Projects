terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.87.0"
    }
  }

  backend "s3" {
    bucket         = "petfstatenpd"
    key            = "terraform/npd.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table" # Optional for state locking
  }
}

provider "aws" {
  region = "us-east-1"
}

