# Serverless Todo API

A simple, serverless To-Do list API built with AWS services and Terraform. This project demonstrates how to build a complete serverless application using AWS Lambda, API Gateway, and DynamoDB.

## Architecture

The application follows a serverless architecture pattern:

- **API Gateway**: Provides HTTP endpoints for the REST API
- **Lambda Function**: Contains the business logic for task operations
- **DynamoDB**: Serverless NoSQL database for storing tasks
- **Terraform**: Infrastructure as Code for provisioning all resources

## Features

- Create new tasks with title and description
- List all tasks (sorted by creation date)
- Delete specific tasks by ID
- RESTful API design
- Serverless and scalable
- Pay-per-use pricing model

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/tasks` | List all tasks |
| POST | `/tasks` | Create a new task |
| DELETE | `/tasks/{id}` | Delete a specific task |

### Request/Response Examples

#### Create Task (POST /tasks)
```json
{
  "title": "Learn AWS Serverless",
  "description": "Build a serverless todo API"
}
```

#### List Tasks (GET /tasks)
```json
{
  "tasks": [
    {
      "id": "uuid-here",
      "title": "Learn AWS Serverless",
      "description": "Build a serverless todo API",
      "completed": false,
      "created_at": "2024-01-01T12:00:00",
      "updated_at": "2024-01-01T12:00:00"
    }
  ]
}
```

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform (version >= 1.0)
- Python 3.11+
- S3 bucket for Terraform state (optional but recommended)

## Setup Instructions

### 1. Configure AWS Credentials

```bash
aws configure
```

### 2. Update Terraform Backend (Optional)

Edit `terraform/main.tf` and update the S3 backend configuration:

```hcl
backend "s3" {
  bucket = "your-terraform-state-bucket"
  key    = "serverless-todo-api/terraform.tfstate"
  region = "us-east-1"
}
```

### 3. Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 4. Test the API

After deployment, Terraform will output the API Gateway URL. Use the test script:

```bash
python scripts/test_api.py https://your-api-gateway-url/dev
```

Or test manually with curl:

```bash
# Create a task
curl -X POST https://your-api-gateway-url/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Test Task", "description": "This is a test"}'

# List tasks
curl https://your-api-gateway-url/dev/tasks

# Delete a task (replace {id} with actual task ID)
curl -X DELETE https://your-api-gateway-url/dev/tasks/{id}
```

## Project Structure

```
aws-serverless-demo/
├── terraform/                 # Terraform infrastructure code
│   ├── main.tf               # Main configuration
│   ├── variables.tf          # Variable definitions
│   ├── dynamodb.tf           # DynamoDB table
│   ├── lambda.tf             # Lambda function
│   ├── api_gateway.tf        # API Gateway
│   └── outputs.tf            # Output values
├── src/
│   └── lambda/               # Lambda function source code
│       ├── lambda_function.py
│       └── requirements.txt
├── scripts/
│   └── test_api.py           # API testing script
├── docs/
│   └── architecture.puml     # Architecture diagram
└── README.md
```

## Cost Considerations

This serverless architecture is designed to be cost-effective:

- **Lambda**: Pay only for compute time (100ms increments)
- **API Gateway**: Pay per API call
- **DynamoDB**: Pay-per-request pricing model
- **No idle costs**: Resources scale to zero when not in use

## Cleanup

To avoid ongoing charges, destroy the infrastructure:

```bash
cd terraform
terraform destroy
```

## Learning Objectives

This project covers:

1. **Serverless Architecture**: Understanding Lambda, API Gateway, and DynamoDB
2. **Infrastructure as Code**: Using Terraform for resource provisioning
3. **API Design**: RESTful API patterns and best practices
4. **AWS IAM**: Role-based permissions and security
5. **Event-Driven Programming**: Lambda function event handling
6. **NoSQL Database**: DynamoDB operations and data modeling

## Next Steps

Consider extending this project with:

- User authentication and authorization
- Task completion status updates
- Task categories and tags
- Search and filtering capabilities
- CloudWatch monitoring and logging
- CI/CD pipeline with GitHub Actions
- Frontend web application

## Troubleshooting

### Common Issues

1. **Lambda timeout**: Increase timeout in `variables.tf`
2. **Permission errors**: Check IAM roles and policies
3. **API Gateway CORS**: CORS headers are already configured
4. **DynamoDB errors**: Verify table name and permissions

### Logs

Check CloudWatch logs for Lambda function debugging:

```bash
aws logs describe-log-groups --log-group-name-prefix "/aws/lambda/serverless-todo-api"
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
