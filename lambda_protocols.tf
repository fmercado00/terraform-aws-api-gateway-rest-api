####################################################################################
#                   Lambda function for get method
####################################################################################
data "archive_file" "usmis-python-lambda-protocols-get-package" {
  type        = "zip"
  source_file = "${path.cwd}/code/lambda_protocols_get.py"
  output_path = "${path.cwd}/zipfiles/lambda_protocols_get.zip"
}

resource "aws_lambda_function" "usmis-get-lambda" {
  
  filename = data.archive_file.usmis-python-lambda-protocols-get-package.output_path
  function_name = "usmis-protocols-get"
  role          = aws_iam_role.role.arn
  handler       = "lambda_protocols_get.lambda_handler"
  runtime       = "python3.9"

  source_code_hash = filebase64sha256("${path.cwd}/zipfiles/lambda_protocols_get.zip")
}


resource "aws_lambda_permission" "usmis-apigw_get-lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.usmis-get-lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.usmis-api.id}/*/${aws_api_gateway_method.usmis-get-method.http_method}${aws_api_gateway_resource.usmis-get-resource.path}"
}

####################################################################################
#                   Lambda function for post method
####################################################################################
data "archive_file" "usmis-python-lambda-protocols-post-package" {
  type        = "zip"
  source_file = "${path.cwd}/code/lambda_protocols_post.py"
  output_path = "${path.cwd}/zipfiles/lambda_protocols_post.zip"
}

resource "aws_lambda_function" "usmis-post-lambda" {
  filename = data.archive_file.usmis-python-lambda-protocols-post-package.output_path
  function_name = "usmis-protocols-post"
  role          = aws_iam_role.role.arn
  handler       = "lambda_protocols_post.lambda_handler"
  runtime       = "python3.9"

  source_code_hash = filebase64sha256("${path.cwd}/zipfiles/lambda_protocols_post.zip")
}


resource "aws_lambda_permission" "usmis-apigw_post-lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.usmis-post-lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.usmis-api.id}/*/${aws_api_gateway_method.usmis-post-method.http_method}${aws_api_gateway_resource.usmis-post-resource.path}"
}
