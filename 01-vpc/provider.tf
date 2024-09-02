
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.61.0"
    }
  }
  backend "s3" {
    bucket         = "hussain-roboshop-state"
    key            = "roboshop-vpc-final"
    dynamodb_table = "roboshop-locking"
    region         = "us-east-1"
  }
}



provider "aws" {
  # Configuration options
  region = "us-east-1"

}
