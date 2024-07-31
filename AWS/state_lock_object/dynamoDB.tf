resource "aws_dynamodb_table" "state_dynamo_DB" {
  name           = "tfstate_dynamo_DB_table"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
}
