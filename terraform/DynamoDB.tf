resource "aws_dynamodb_table" "attendan" {
  name = "attendance"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "id"

  attribute {
    name = "id"
    type = "N"
  }
}

resource "aws_dynamodb_table_item" "attendance_1" {
  table_name = aws_dynamodb_table.attendan.name
  hash_key   = aws_dynamodb_table.attendan.hash_key

  item = jsonencode({
  "id" : {
    "N" : "1"
 }
  "date" : {
    "N" : "3"
  },
  "user_id" : {
    "S" : "1"
  },
})
}
