# API Quick Reference

## Base URL
```
https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev
```

## Endpoints

### GET /tasks
**List all tasks**
```bash
curl https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks
```

### POST /tasks
**Create a new task**
```bash
curl -X POST https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Task Title", "description": "Task Description"}'
```

### DELETE /tasks/{id}
**Delete a specific task**
```bash
curl -X DELETE https://1707r6jcga.execute-api.us-east-1.amazonaws.com/dev/tasks/{task-id}
```

## Request/Response Examples

### Create Task
**Request:**
```json
{
  "title": "Learn AWS Serverless",
  "description": "Build a serverless todo API"
}
```

**Response:**
```json
{
  "task": {
    "id": "4ca1aee0-09cf-4486-82bb-a0710c08b426",
    "title": "Learn AWS Serverless",
    "description": "Build a serverless todo API",
    "completed": false,
    "created_at": "2025-08-23T11:05:09.335843",
    "updated_at": "2025-08-23T11:05:09.335843"
  }
}
```

### List Tasks
**Response:**
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

### Delete Task
**Response:**
```json
{
  "message": "Task deleted successfully"
}
```

## Error Responses

### 400 Bad Request
```json
{
  "error": "Title is required"
}
```

### 404 Not Found
```json
{
  "error": "Task not found"
}
```

### 500 Internal Server Error
```json
{
  "error": "Internal server error"
}
```

## Status Codes

| Code | Description |
|------|-------------|
| 200 | Success (GET, DELETE) |
| 201 | Created (POST) |
| 400 | Bad Request |
| 404 | Not Found |
| 500 | Internal Server Error |

## Headers

### Request Headers
- `Content-Type: application/json` (required for POST)

### Response Headers
- `Content-Type: application/json`
- `Access-Control-Allow-Origin: *`
- `Access-Control-Allow-Headers: Content-Type`
- `Access-Control-Allow-Methods: GET,POST,DELETE,OPTIONS`
