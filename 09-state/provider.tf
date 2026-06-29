terraform {
    required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "6.48.0"
        }
    }

    backend "s3" {
    bucket = "state-files-backend"
    key    = "terraform-state-files.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    region = "us-east-1"
}