output "api_gateway_url" {
  description = "URL of the API Gateway endpoint"
  value       = "${aws_api_gateway_stage.todo_api.invoke_url}/tasks"
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.tasks.name
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.todo_api.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.todo_api.arn
}

output "api_endpoints" {
  description = "Available API endpoints"
  value = {
    "GET /tasks"         = "${aws_api_gateway_stage.todo_api.invoke_url}/tasks"
    "POST /tasks"        = "${aws_api_gateway_stage.todo_api.invoke_url}/tasks"
    "DELETE /tasks/{id}" = "${aws_api_gateway_stage.todo_api.invoke_url}/tasks/{id}"
  }
}
