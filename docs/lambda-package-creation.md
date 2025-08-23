# Lambda Package Creation Documentation

## Overview

The `create_lambda_package.sh` script is responsible for creating the deployment package for the AWS Lambda function. This script automates the process of packaging the Python code and dependencies into a ZIP file that can be deployed to AWS Lambda.

## Script Location

```
scripts/create_lambda_package.sh
```

## Purpose

- Creates a ZIP file containing the Lambda function code and dependencies
- Calculates the SHA256 hash for Terraform's source code tracking
- Excludes unnecessary files to keep the package size minimal
- Ensures consistent packaging across different environments

## How It Works

### 1. Package Creation Process

```bash
# Navigate to Lambda source directory
cd src/lambda

# Create ZIP file with all contents
zip -r ../../terraform/lambda_function.zip . -x "*.pyc" "__pycache__/*" "*.DS_Store"
```

### 2. Hash Calculation

The script calculates a SHA256 hash of the ZIP file for Terraform to track changes:

```bash
# macOS
SHA256_HASH=$(shasum -a 256 lambda_function.zip | cut -d' ' -f1 | base64)

# Linux
SHA256_HASH=$(sha256sum lambda_function.zip | cut -d' ' -f1 | base64)
```

### 3. File Structure

The resulting ZIP file contains:
```
lambda_function.zip
├── lambda_function.py    # Main Lambda handler
└── requirements.txt      # Python dependencies
```

## Usage

### Automated Usage (Recommended)

The script is automatically called during deployment:

```bash
./scripts/deploy.sh
```

### Manual Usage

If you need to create the package manually:

```bash
# From project root
./scripts/create_lambda_package.sh

# Or using Makefile
make package
```

### Output

The script outputs:
- Package creation status
- SHA256 hash for Terraform
- Package size
- File location

Example output:
```
Creating Lambda deployment package...
Zipping Lambda function...
Lambda package created: terraform/lambda_function.zip
SHA256 Hash: MTM5ZjIwZTlkOWE0NWU4YjA4MTk1MDhiOTc3MDkyNGI1MWM3OTNkNDc2YjU4N2JlOWRmZWU0ZjFiZDQ0ZTkyYgo=
Package size: 4.0K
```

## Integration with Terraform

The Terraform configuration uses the generated package:

```hcl
# In terraform/lambda.tf
locals {
  lambda_zip_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "todo_api" {
  filename         = local.lambda_zip_path
  source_code_hash = filebase64sha256(local.lambda_zip_path)
  # ... other configuration
}
```

## Troubleshooting

### Common Issues

1. **Permission Denied**
   ```bash
   chmod +x scripts/create_lambda_package.sh
   ```

2. **ZIP Command Not Found**
   - Ensure `zip` is installed on your system
   - On macOS: `brew install zip`
   - On Ubuntu: `sudo apt-get install zip`

3. **Hash Calculation Fails**
   - The script automatically detects macOS vs Linux
   - Ensure `shasum` (macOS) or `sha256sum` (Linux) is available

### Verification

To verify the package was created correctly:

```bash
# Check if file exists
ls -la terraform/lambda_function.zip

# View contents
unzip -l terraform/lambda_function.zip

# Verify hash
shasum -a 256 terraform/lambda_function.zip
```

## Customization

### Adding Dependencies

To include additional Python packages:

1. Add to `src/lambda/requirements.txt`
2. Install locally: `pip install -r src/lambda/requirements.txt -t src/lambda/`
3. Run the package script

### Excluding Files

To exclude additional file types, modify the zip command:

```bash
zip -r ../../terraform/lambda_function.zip . \
  -x "*.pyc" "__pycache__/*" "*.DS_Store" "*.log" "*.tmp"
```

## Best Practices

1. **Keep it Minimal**: Only include necessary files
2. **Version Control**: Don't commit the ZIP file (it's in .gitignore)
3. **Consistent Environment**: Use the same Python version as Lambda runtime
4. **Dependencies**: Use `requirements.txt` for dependency management
5. **Testing**: Verify the package works before deployment

## Related Files

- `src/lambda/lambda_function.py` - Main Lambda function code
- `src/lambda/requirements.txt` - Python dependencies
- `terraform/lambda.tf` - Terraform Lambda configuration
- `scripts/deploy.sh` - Deployment script that calls this script
- `Makefile` - Contains package target
