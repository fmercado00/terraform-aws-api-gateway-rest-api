# API Gateway
resource "aws_api_gateway_rest_api" "usmis-api" {
  name = "usmis-simplification-api"
}

####################################################################################
#        Create resource, method and integration for get operation
####################################################################################
resource "aws_api_gateway_resource" "usmis-get-resource" {
  path_part   = "usmis-protocols-get"
  parent_id   = aws_api_gateway_rest_api.usmis-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.usmis-api.id
}

resource "aws_api_gateway_method" "usmis-get-method" {
  rest_api_id   = aws_api_gateway_rest_api.usmis-api.id
  resource_id   = aws_api_gateway_resource.usmis-get-resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "usmis-get-integration" {
  rest_api_id             = aws_api_gateway_rest_api.usmis-api.id
  resource_id             = aws_api_gateway_resource.usmis-get-resource.id
  http_method             = aws_api_gateway_method.usmis-get-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.usmis-get-lambda.invoke_arn
}

####################################################################################
#        Create resource, method and integration for post operation
####################################################################################
resource "aws_api_gateway_resource" "usmis-post-resource" {
  path_part   = "usmis-protocols-post"
  parent_id   = aws_api_gateway_rest_api.usmis-api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.usmis-api.id
}

resource "aws_api_gateway_method" "usmis-post-method" {
  rest_api_id   = aws_api_gateway_rest_api.usmis-api.id
  resource_id   = aws_api_gateway_resource.usmis-post-resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "usmis-post-integration" {
  rest_api_id             = aws_api_gateway_rest_api.usmis-api.id
  resource_id             = aws_api_gateway_resource.usmis-post-resource.id
  http_method             = aws_api_gateway_method.usmis-post-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.usmis-post-lambda.invoke_arn
}