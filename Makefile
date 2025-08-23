.PHONY: help deploy destroy test plan init

help: ## Show this help message
	@echo "Serverless Todo API - Available Commands"
	@echo "========================================"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## Initialize Terraform
	cd terraform && terraform init

plan: ## Plan Terraform deployment
	cd terraform && terraform plan

deploy: ## Deploy the infrastructure
	./scripts/deploy.sh

destroy: ## Destroy the infrastructure
	./scripts/cleanup.sh

test: ## Test the API (requires API URL as parameter)
	@if [ -z "$(API_URL)" ]; then \
		echo "Error: Please provide API_URL parameter"; \
		echo "Usage: make test API_URL=https://your-api-gateway-url/dev"; \
		exit 1; \
	fi
	python scripts/test_api.py $(API_URL)

format: ## Format Python code
	find . -name "*.py" -exec black {} \;

lint: ## Lint Python code
	find . -name "*.py" -exec flake8 {} \;

clean: ## Clean up temporary files
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	rm -f terraform/lambda_function.zip
