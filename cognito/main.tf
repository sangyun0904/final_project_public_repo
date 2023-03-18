provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_cognito_user_pool" "this" {
  name = "User_Pool"
}

resource "aws_cognito_user_pool_client" "this" {
  name = "User_Pool_Client"
  user_pool_id = aws_cognito_user_pool.this.id
}