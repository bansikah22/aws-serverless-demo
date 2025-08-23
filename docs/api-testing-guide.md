# API Testing Guide

## Overview

This guide provides detailed instructions for testing the Serverless Todo API using curl commands. You can use these commands to manually test all API endpoints and understand how the API works.

## API Base URL

```
https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev
```

## Available Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/tasks` | List all tasks |
| POST | `/tasks` | Create a new task |
| DELETE | `/tasks/{id}` | Delete a specific task |

## Testing Commands

### 1. List All Tasks (GET /tasks)

**Command:**
```bash
curl -X GET https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks
```

**Expected Response:**
```json
{
  "tasks": []
}
```

**With Tasks:**
```json
{
  "tasks": [
    {
      "id": "4ca1aee0-09cf-4486-82bb-a0710c08b426",
      "title": "Learn AWS Serverless",
      "description": "Build a serverless todo API",
      "completed": false,
      "created_at": "2025-08-23T11:05:09.335843",
      "updated_at": "2025-08-23T11:05:09.335843"
    }
  ]
}
```

### 2. Create a New Task (POST /tasks)

**Command:**
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Learn AWS Serverless",
    "description": "Build a serverless todo API with Lambda, API Gateway, and DynamoDB"
  }'
```

**Expected Response:**
```json
{
  "task": {
    "id": "4ca1aee0-09cf-4486-82bb-a0710c08b426",
    "title": "Learn AWS Serverless",
    "description": "Build a serverless todo API with Lambda, API Gateway, and DynamoDB",
    "completed": false,
    "created_at": "2025-08-23T11:05:09.335843",
    "updated_at": "2025-08-23T11:05:09.335843"
  }
}
```

**Alternative (Single Line):**
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks -H "Content-Type: application/json" -d '{"title": "Learn AWS Serverless", "description": "Build a serverless todo API"}'
```

### 3. Create Multiple Tasks

**Task 1:**
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Deploy with Terraform", "description": "Learn infrastructure as code"}'
```

**Task 2:**
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Test API Endpoints", "description": "Verify all CRUD operations work correctly"}'
```

**Task 3:**
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Monitor Performance", "description": "Set up CloudWatch monitoring and logging"}'
```

### 4. Delete a Task (DELETE /tasks/{id})

**Command:**
```bash
curl -X DELETE https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks/4ca1aee0-09cf-4486-82bb-a0710c08b426
```

**Expected Response:**
```json
{
  "message": "Task deleted successfully"
}
```

## Complete Testing Workflow

### Step 1: Check Initial State
```bash
curl -X GET https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks
```

### Step 2: Create First Task
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "First Task", "description": "This is the first task"}'
```

### Step 3: Verify Task Created
```bash
curl -X GET https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks
```

### Step 4: Create Second Task
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Second Task", "description": "This is the second task"}'
```

### Step 5: List All Tasks
```bash
curl -X GET https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks
```

### Step 6: Delete First Task
```bash
# Replace {task-id} with the actual ID from step 3
curl -X DELETE https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks/{task-id}
```

### Step 7: Verify Deletion
```bash
curl -X GET https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks
```

## Error Testing

### 1. Create Task Without Title (Should Fail)
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"description": "Task without title"}'
```

**Expected Response:**
```json
{
  "error": "Title is required"
}
```

### 2. Create Task with Empty Title (Should Fail)
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "", "description": "Empty title"}'
```

### 3. Delete Non-existent Task (Should Fail)
```bash
curl -X DELETE https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks/non-existent-id
```

**Expected Response:**
```json
{
  "error": "Task not found"
}
```

### 4. Invalid JSON (Should Fail)
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Invalid JSON", "description": "Missing closing brace'
```

## Advanced Testing

### 1. Test with Different Content Types
```bash
# Test without Content-Type header
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -d '{"title": "No Content-Type", "description": "Testing without header"}'
```

### 2. Test Large Payload
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Very Long Title That Exceeds Normal Length", "description": "This is a very long description that contains many words and should test how the API handles larger payloads. It includes various characters and formatting to ensure robust handling of different input types."}'
```

### 3. Test Special Characters
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Task with Special Chars: @#$%^&*()", "description": "Testing special characters: éñüçåß"}'
```

## Response Headers

The API includes CORS headers for web applications:

```bash
curl -I https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks
```

**Expected Headers:**
```
Access-Control-Allow-Origin: *
Access-Control-Allow-Headers: Content-Type
Access-Control-Allow-Methods: GET,POST,DELETE,OPTIONS
Content-Type: application/json
```

## Performance Testing

### 1. Concurrent Requests
```bash
# Create multiple tasks simultaneously
for i in {1..5}; do
  curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
    -H "Content-Type: application/json" \
    -d "{\"title\": \"Concurrent Task $i\", \"description\": \"Testing concurrent requests\"}" &
done
wait
```

### 2. Response Time Testing
```bash
# Test response time
time curl -X GET https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks
```

## Troubleshooting

### Common Issues

1. **Connection Refused**
   - Check if the API Gateway URL is correct
   - Verify the API is deployed and active

2. **401 Unauthorized**
   - Check API Gateway configuration
   - Verify Lambda permissions

3. **500 Internal Server Error**
   - Check CloudWatch logs for Lambda errors
   - Verify DynamoDB table exists and is accessible

4. **Timeout Errors**
   - Check Lambda timeout configuration
   - Verify DynamoDB performance

### Debug Commands

```bash
# Test API Gateway directly
curl -v https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks

# Check response headers
curl -I https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks

# Test with verbose output
curl -v -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Debug Test", "description": "Testing with verbose output"}'
```

## Automation

### Shell Script for Complete Testing
```bash
#!/bin/bash

API_URL="https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev"

echo "=== Testing Serverless Todo API ==="

echo "1. Initial state:"
curl -s "$API_URL/tasks" | jq '.'

echo -e "\n2. Creating task:"
TASK_RESPONSE=$(curl -s -X POST "$API_URL/tasks" \
  -H "Content-Type: application/json" \
  -d '{"title": "Test Task", "description": "API Testing"}')
echo "$TASK_RESPONSE" | jq '.'

TASK_ID=$(echo "$TASK_RESPONSE" | jq -r '.task.id')

echo -e "\n3. Listing tasks:"
curl -s "$API_URL/tasks" | jq '.'

echo -e "\n4. Deleting task:"
curl -s -X DELETE "$API_URL/tasks/$TASK_ID" | jq '.'

echo -e "\n5. Final state:"
curl -s "$API_URL/tasks" | jq '.'

echo -e "\n=== Testing Complete ==="
```

Save this as `test-api.sh` and run:
```bash
chmod +x test-api.sh
./test-api.sh
```
