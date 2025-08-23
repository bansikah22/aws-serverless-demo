# Makefile Usage Guide

## Overview

The project includes a Makefile that provides convenient shortcuts for common operations. This guide explains how to use each command and when to use them.

## Available Commands

### Basic Commands

#### `make help`
**Description**: Shows all available commands with descriptions
```bash
make help
```

**Output**:
```
Serverless Todo API - Available Commands
========================================
  help           Show this help message
  init           Initialize Terraform
  plan           Plan Terraform deployment
  package        Create Lambda deployment package
  deploy         Deploy the infrastructure
  destroy        Destroy the infrastructure
  test           Test the API (requires API URL as parameter)
  format         Format Python code
  lint           Lint Python code
  clean          Clean up temporary files
```

### Infrastructure Commands

#### `make init`
**Description**: Initialize Terraform in the terraform directory
```bash
make init
```

**What it does**:
- Downloads required Terraform providers
- Initializes the Terraform working directory
- Sets up backend configuration

**When to use**: First time setup or after adding new providers

#### `make plan`
**Description**: Show what Terraform will do without making changes
```bash
make plan
```

**What it does**:
- Analyzes current state vs desired state
- Shows what resources will be created, modified, or destroyed
- Validates configuration without applying changes

**When to use**: Before deploying to review changes

#### `make package`
**Description**: Create the Lambda deployment package
```bash
make package
```

**What it does**:
- Zips the Lambda function code and dependencies
- Calculates SHA256 hash for Terraform
- Places package in `terraform/lambda_function.zip`

**When to use**: When you modify Lambda code or dependencies

#### `make deploy`
**Description**: Deploy the complete infrastructure
```bash
make deploy
```

**What it does**:
- Creates Lambda package (if needed)
- Runs Terraform apply
- Deploys all AWS resources
- Shows API Gateway URL

**When to use**: To deploy the complete application

#### `make destroy`
**Description**: Destroy all infrastructure resources
```bash
make destroy
```

**What it does**:
- Removes all AWS resources
- Deletes Lambda function, API Gateway, DynamoDB table
- Cleans up IAM roles and policies

**When to use**: To clean up and avoid charges

### Testing Commands

#### `make test`
**Description**: Test the API endpoints
```bash
make test API_URL=https://your-api-gateway-url/dev
```

**What it does**:
- Tests all API endpoints (GET, POST, DELETE)
- Creates sample tasks
- Verifies CRUD operations
- Shows test results

**When to use**: After deployment to verify functionality

**Example**:
```bash
make test API_URL=https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev
```

### Development Commands

#### `make format`
**Description**: Format Python code using Black
```bash
make format
```

**What it does**:
- Formats all Python files in the project
- Ensures consistent code style
- Uses Black formatter

**When to use**: After writing or modifying Python code

#### `make lint`
**Description**: Lint Python code using flake8
```bash
make lint
```

**What it does**:
- Checks Python code for style issues
- Identifies potential problems
- Ensures code quality

**When to use**: Before committing code

#### `make clean`
**Description**: Clean up temporary files
```bash
make clean
```

**What it does**:
- Removes Python cache files
- Deletes compiled Python files
- Removes Lambda deployment package

**When to use**: To clean up project directory

## Common Workflows

### First Time Setup
```bash
make init
make plan
make deploy
```

### After Code Changes
```bash
make format
make lint
make package
make plan
make deploy
```

### Testing After Deployment
```bash
make test API_URL=https://your-api-url/dev
```

### Cleanup
```bash
make destroy
make clean
```

## Prerequisites

Before using the Makefile, ensure you have:

1. **AWS Credentials**: Configured via `aws configure` or environment variables
2. **Terraform**: Installed and available in PATH
3. **Python**: Installed with required packages
4. **Zip**: Available for Lambda package creation

## Troubleshooting

### Common Issues

1. **Permission Denied**
   ```bash
   chmod +x scripts/*.sh
   ```

2. **Terraform Not Found**
   - Install Terraform: https://www.terraform.io/downloads.html

3. **AWS Credentials Not Found**
   ```bash
   aws configure
   # or
   export AWS_ACCESS_KEY_ID="your-key"
   export AWS_SECRET_ACCESS_KEY="your-secret"
   ```

4. **Python Dependencies Missing**
   ```bash
   pip install black flake8 requests
   ```

### Verbose Output

To see detailed output, you can run commands directly:

```bash
# Instead of make deploy
./scripts/deploy.sh

# Instead of make destroy
./scripts/cleanup.sh
```

## Customization

### Adding New Commands

To add a new command to the Makefile:

```makefile
new-command: ## Description of the new command
	@echo "Running new command..."
	# Your command here
```

### Modifying Existing Commands

You can modify any command by editing the Makefile. For example, to change the Python formatter:

```makefile
format: ## Format Python code
	find . -name "*.py" -exec autopep8 --in-place {} \;
```

## Best Practices

1. **Always run `make plan` before `make deploy`**
2. **Use `make test` after deployment**
3. **Run `make format` and `make lint` before committing**
4. **Use `make destroy` to avoid ongoing charges**
5. **Check `make help` for available commands**

## Integration with CI/CD

The Makefile commands can be used in CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Deploy Infrastructure
  run: |
    make init
    make plan
    make deploy

- name: Test API
  run: |
    make test API_URL=${{ secrets.API_URL }}
```
