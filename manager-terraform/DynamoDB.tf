resource "aws_dynamodb_table" "attendance" {
  name = "attendance"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "id"

  attribute {
    name = "id"
    type = "N"
  }

  attribute {
    name = "date"
    type = "N"
  }

  attribute {
    name = "user_id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "attendance_1" {
  table_name = aws_dynamodb_table.attendance.name
  hash_key   = aws_dynamodb_table.attendance.hash_key

    item = <<ITEM
    {
        "id": { "N": "1"},
        "date": {"N" : "3"},
        "user_id": {"S" : "1}"},
    }
    ITEM
}
