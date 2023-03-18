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


# resource "aws_dynamodb_table_item" "attendance_1" {
#   table_name = aws_dynamodb_table.attendance.name
#   hash_key   = aws_dynamodb_table.attendance.hash_key

#   item = <<ITEM
# {
#   "id": {"S": "something"},
#   "date": {"N": "11111"},
#   "user_id": {"N": "22222"},
# }
# ITEM
# }


# resource "aws_dynamodb_table_item" "attendance_2" {
#   table_name = aws_dynamodb_table.attendance.name  

#   hash_key = "id"
#   hash_value = "2"

#   item {
#     date = 3
#     user_id = "3"
#   }
# }

# resource "aws_dynamodb_table_item" "attendance_3" {
#   table_name = aws_dynamodb_table.attendance.name

#   hash_key = "id"
#   hash_value = "3"

#   item {
#     date = 5
#     user_id = "2"
#   }
# }

# resource "aws_dynamodb_table_item" "attendance_4" {
#   table_name = aws_dynamodb_table.attendance.name

#   hash_key = "id"
#   hash_value = "4"

#   item {
#     date = 5
#     user_id = "4"
#   }
# }

# resource "aws_dynamodb_table" "products" {
#   name = "Products"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key = "id"

#   attribute {
#     name = "id"
#     type = "N"
#   }

#   attribute {
#     name = "condition"
#     type = "N"
#   }

#   attribute {
#     name = "name"
#     type = "S"
#   }

#   attribute {
#     name = "remain"
#     type = "S"
#   }

#   key {
#     name = "id"
#     type = "HASH"
#   }
# }

# resource "aws_dynamodb_table_item" "product_1" {
#   table_name = aws_dynamodb_table.products.name

#   hash_key = "id"
#   hash_value = "1"

#   item {
#     condition = 10
#     name = "nike"
#     remain = 7
#   }
# }

# resource "aws_dynamodb_table_item" "product_2" {
#   table_name = aws_dynamodb_table.products.name

#   hash_key = "id"
#   hash_value = "2"

#   item {
#     condition = 15
#     name = "adidas"
#     remain = 20
#   }
# }

# resource "aws_dynamodb_table_item" "product_3" {
#   table_name = aws_dynamodb_table.products.name

#   hash_key = "id"
#   hash_value = "3"

#   item {
#     condition = 15
#     name = "newbalance"
#     remain = 25
#   }
# }

# resource "aws_dynamodb_table" "rewards" {
#   name = "rewards"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key = "id"

#   attribute {
#     name = "id"
#     type = "N"
#   }

#   attribute {
#     name = "product_id"
#     type = "N"
#   }

#   attribute {
#     name = "reward_time"
#     type = "N"
#   }

#   attribute {
#     name = "user_id"
#     type = "S"
#   }

#   key {
#     name = "id"
#     type = "HASH"
#   }
# }

# resource "aws_dynamodb_table_item" "reward_1" {
#   table_name = aws_dynamodb_table.rewards.name

#   hash_key = "id"
#   hash_value = "1"

#   item {
#     product_id = 3
#     reward_time = 17
#     user_id = "4"
#   }
# }

# resource "aws_dynamodb_table_item" "reward_2" {
#   table_name = aws_dynamodb_table.rewards.name

#   hash_key = "id"
#   hash_value = "2"

#   item {
#     product_id = 2
#     reward_time = 15
#     user_id = "3"
#   }
# }

# resource "aws_dynamodb_table_item" "reward_3" {
#   table_name = aws_dynamodb_table.rewards.name

#   hash_key = "id"
#   hash_value = "3"

#   item {
#     product_id = 1
#     reward_time = 3
#     user_id = "1"
#   }
# }

# resource "aws_dynamodb_table_item" "reward_4" {
#   table_name = aws_dynamodb_table.rewards.name

#   hash_key = "id"
#   hash_value = "4"

#   item {
#     product_id = 6
#     reward_time = 7
#     user_id = "2"
#   }
# }

# resource "aws_dynamodb_table" "users" {
#   name = "users"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key = "id"

#   attribute {
#     name = "id"
#     type = "N"
#   }

#   attribute {
#     name = "username"
#     type = "S"
#   }

#   attribute {
#     name = "count"
#     type = "N"
#   }

#   attribute {
#     name = "user_point"
#     type = "N"
#   }

#   key {
#     name = "id"
#     type = "HASH"
#   }
# }

# resource "aws_dynamodb_table_item" "user_1" {
#   table_name = aws_dynamodb_table.users.name

#   hash_key = "id"
#   hash_value = "1"

#   item {
#     username = "sang"
#     count = 3
#     user_point = 40000
#   }
# }

# resource "aws_dynamodb_table_item" "user_2" {
#   table_name = aws_dynamodb_table.users.name

#   hash_key = "id"
#   hash_value = "2"

#   item {
#     username = "hoon"
#     count = 5
#     user_point = 20000
#   }
# }

# resource "aws_dynamodb_table_item" "user_3" {
#   table_name = aws_dynamodb_table.users.name

#   hash_key = "id"
#   hash_value = "3"

#   item {
#     username = "geon"
#     count = 3
#     user_point = 30000
#   }
# }

# resource "aws_dynamodb_table_item" "user_4" {
#   table_name = aws_dynamodb_table.users.name

#   hash_key = "id"
#   hash_value = "4"

#   item {
#     username = "tae"
#     count = 5
#     user_point = 40000
#   }
# }

