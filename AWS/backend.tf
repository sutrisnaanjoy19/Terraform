terraform {
  backend "s3" {
    encrypt        = true
    region         = "us-east-1"
    bucket         = "tfstate-store-s3"
    dynamodb_table = "tfstate_dynamo_DB_table"
    key            = "terraform.tfstate"
  }
}
