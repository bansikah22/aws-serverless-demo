# API Gateway REST API
resource "aws_api_gateway_rest_api" "todo_api" {
  name        = "${var.project_name}-${var.environment}"
  description = "Serverless Todo API"
}

# API Gateway Resource for /tasks
resource "aws_api_gateway_resource" "tasks" {
  rest_api_id = aws_api_gateway_rest_api.todo_api.id
  parent_id   = aws_api_gateway_rest_api.todo_api.root_resource_id
  path_part   = "tasks"
}

# API Gateway Resource for /tasks/{id}
resource "aws_api_gateway_resource" "task_id" {
  rest_api_id = aws_api_gateway_rest_api.todo_api.id
  parent_id   = aws_api_gateway_resource.tasks.id
  path_part   = "{id}"
}

# GET /tasks - List all tasks
resource "aws_api_gateway_method" "get_tasks" {
  rest_api_id   = aws_api_gateway_rest_api.todo_api.id
  resource_id   = aws_api_gateway_resource.tasks.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_tasks" {
  rest_api_id = aws_api_gateway_rest_api.todo_api.id
  resource_id = aws_api_gateway_resource.tasks.id
  http_method = aws_api_gateway_method.get_tasks.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.todo_api.invoke_arn
}

# POST /tasks - Create new task
resource "aws_api_gateway_method" "post_tasks" {
  rest_api_id   = aws_api_gateway_rest_api.todo_api.id
  resource_id   = aws_api_gateway_resource.tasks.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "post_tasks" {
  rest_api_id = aws_api_gateway_rest_api.todo_api.id
  resource_id = aws_api_gateway_resource.tasks.id
  http_method = aws_api_gateway_method.post_tasks.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.todo_api.invoke_arn
}

# DELETE /tasks/{id} - Delete specific task
resource "aws_api_gateway_method" "delete_task" {
  rest_api_id   = aws_api_gateway_rest_api.todo_api.id
  resource_id   = aws_api_gateway_resource.task_id.id
  http_method   = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "delete_task" {
  rest_api_id = aws_api_gateway_rest_api.todo_api.id
  resource_id = aws_api_gateway_resource.task_id.id
  http_method = aws_api_gateway_method.delete_task.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.todo_api.invoke_arn
}

# API Gateway Deployment
resource "aws_api_gateway_deployment" "todo_api" {
  rest_api_id = aws_api_gateway_rest_api.todo_api.id

  depends_on = [
    aws_api_gateway_integration.get_tasks,
    aws_api_gateway_integration.post_tasks,
    aws_api_gateway_integration.delete_task
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# API Gateway Stage
resource "aws_api_gateway_stage" "todo_api" {
  deployment_id = aws_api_gateway_deployment.todo_api.id
  rest_api_id   = aws_api_gateway_rest_api.todo_api.id
  stage_name    = var.environment
}
