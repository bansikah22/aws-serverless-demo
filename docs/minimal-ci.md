# Minimal CI Pipeline

This project uses a minimal CI pipeline that runs only on pull requests to check basic code quality without modifying your existing working code.

## What it does

The CI pipeline runs automatically when someone creates a pull request and checks:

1. **Python Code Formatting** - Ensures code follows Black formatting standards
2. **Python Linting** - Checks for code style issues with Flake8
3. **Terraform Validation** - Validates Terraform configuration syntax and formatting

## What it doesn't do

- No AWS credentials required
- No deployment automation
- No testing (your existing code already works)
- No changes to your working codebase
- No complex dependencies

## How to use

Simply create a pull request and the CI will automatically run these checks. If any checks fail, you'll see the issues in the GitHub interface.

## Local checks (optional)

If you want to run the same checks locally before creating a PR:

```bash
# Install tools
pip install flake8 black

# Check formatting
black --check --line-length=127 src/

# Check linting
flake8 src/ --max-line-length=127 --max-complexity=10 --ignore=E203,W503

# Check Terraform
cd terraform
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

That's it! Simple and minimal.
