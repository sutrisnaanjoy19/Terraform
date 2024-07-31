terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
  }
}
provider "aws" {
  region  = "us-east-1"
  profile = "sushi-east1"

}

terraform {
  backend "s3" {
    encrypt        = true
    region         = "us-east-1"
    bucket         = "tfstate-store-s3"
    dynamodb_table = "tfstate_dynamo_DB_table"
    key            = "terraform.tfstate"
  }
}
