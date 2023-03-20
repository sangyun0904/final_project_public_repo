resource "aws_api_gateway_rest_api" "admin_api" {
  name = "admin_api"
}

resource "aws_api_gateway_resource" "admin_api_parnet" {
  rest_api_id = aws_api_gateway_rest_api.admin_api.id
  parent_id   = aws_api_gateway_rest_api.admin_api.root_resource_id
  path_part   = "products"
}

resource "aws_api_gateway_resource" "admin_api" {
  rest_api_id = aws_api_gateway_rest_api.admin_api.id
  parent_id   = aws_api_gateway_resource.admin_api_parnet.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "admin_api" {
  rest_api_id   = aws_api_gateway_rest_api.admin_api.id
  resource_id   = aws_api_gateway_resource.admin_api.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "admin_api" {
  rest_api_id             = aws_api_gateway_rest_api.admin_api.id
  resource_id             = aws_api_gateway_resource.admin_api.id
  http_method             = aws_api_gateway_method.admin_api.http_method
  integration_http_method = "PUT"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.product-adjustment_lambda.invoke_arn
}

resource "aws_api_gateway_deployment" "admin_api" {
  rest_api_id = aws_api_gateway_rest_api.admin_api.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.admin_api.id,
      aws_api_gateway_method.admin_api.id,
      aws_api_gateway_integration.admin_api.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "admin_api" {
  deployment_id = aws_api_gateway_deployment.admin_api.id
  rest_api_id   = aws_api_gateway_rest_api.admin_api.id
  stage_name    = "admin_api"
}