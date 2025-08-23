# DynamoDB table for storing todo tasks
resource "aws_dynamodb_table" "tasks" {
  name         = "${var.project_name}-tasks-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "${var.project_name}-tasks-${var.environment}"
  }
}

# IAM policy for Lambda to access DynamoDB
resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name        = "${var.project_name}-lambda-dynamodb-policy-${var.environment}"
  description = "IAM policy for Lambda to access DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Resource = aws_dynamodb_table.tasks.arn
      }
    ]
  })
}
