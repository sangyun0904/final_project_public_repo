resource "aws_iam_role" "cron_lambda_role" {
  name = "test_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "cron_lambda_policy" {
  name        = "cron_lambda_policy"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:GetItem",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:dynamodb:ap-northeast-2:*:table/products"
      },
    ]
  })
}

resource "aws_lambda_function" "cron_lambda" {
  filename      = "../check-lambda.zip"
  function_name = "check-stock-quantity"
  role          = aws_iam_role.cron_lambda_role.arn
  handler       = "handler.handler"
  runtime       = "nodejs14.x"
  environment {
    variables = {
      TABLE_NAME = "products"
    }
  }
}

resource "aws_lambda_permission" "my_permission" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cron_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cron_check.arn
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = aws_iam_policy.cron_lambda_policy.arn
  role       = aws_iam_role.cron_lambda_role.name
}
