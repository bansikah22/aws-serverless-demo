import json
import boto3
import uuid
import os
from datetime import datetime
from typing import Dict, Any, List

# Initialize DynamoDB client
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])

def lambda_handler(event: Dict[str, Any], context: Any) -> Dict[str, Any]:
    """
    Main Lambda handler for the Todo API
    """
    try:
        # Parse the HTTP method and path
        http_method = event['httpMethod']
        path = event['path']
        
        # Route to appropriate handler
        if http_method == 'GET' and path == '/tasks':
            return get_all_tasks()
        elif http_method == 'POST' and path == '/tasks':
            return create_task(event)
        elif http_method == 'DELETE' and path.startswith('/tasks/'):
            task_id = path.split('/')[-1]
            return delete_task(task_id)
        else:
            return create_response(404, {'error': 'Endpoint not found'})
            
    except Exception as e:
        print(f"Error: {str(e)}")
        return create_response(500, {'error': 'Internal server error'})

def get_all_tasks() -> Dict[str, Any]:
    """
    Retrieve all tasks from DynamoDB
    """
    try:
        response = table.scan()
        tasks = response.get('Items', [])
        
        # Sort tasks by creation date (newest first)
        tasks.sort(key=lambda x: x.get('created_at', ''), reverse=True)
        
        return create_response(200, {'tasks': tasks})
        
    except Exception as e:
        print(f"Error getting tasks: {str(e)}")
        return create_response(500, {'error': 'Failed to retrieve tasks'})

def create_task(event: Dict[str, Any]) -> Dict[str, Any]:
    """
    Create a new task in DynamoDB
    """
    try:
        # Parse request body
        body = json.loads(event.get('body', '{}'))
        title = body.get('title', '').strip()
        description = body.get('description', '').strip()
        
        # Validate input
        if not title:
            return create_response(400, {'error': 'Title is required'})
        
        # Create task item
        task_id = str(uuid.uuid4())
        created_at = datetime.utcnow().isoformat()
        
        task_item = {
            'id': task_id,
            'title': title,
            'description': description,
            'completed': False,
            'created_at': created_at,
            'updated_at': created_at
        }
        
        # Save to DynamoDB
        table.put_item(Item=task_item)
        
        return create_response(201, {'task': task_item})
        
    except json.JSONDecodeError:
        return create_response(400, {'error': 'Invalid JSON in request body'})
    except Exception as e:
        print(f"Error creating task: {str(e)}")
        return create_response(500, {'error': 'Failed to create task'})

def delete_task(task_id: str) -> Dict[str, Any]:
    """
    Delete a task from DynamoDB
    """
    try:
        # Check if task exists
        response = table.get_item(Key={'id': task_id})
        
        if 'Item' not in response:
            return create_response(404, {'error': 'Task not found'})
        
        # Delete the task
        table.delete_item(Key={'id': task_id})
        
        return create_response(200, {'message': 'Task deleted successfully'})
        
    except Exception as e:
        print(f"Error deleting task: {str(e)}")
        return create_response(500, {'error': 'Failed to delete task'})

def create_response(status_code: int, body: Dict[str, Any]) -> Dict[str, Any]:
    """
    Create a standardized API Gateway response
    """
    return {
        'statusCode': status_code,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Methods': 'GET,POST,DELETE,OPTIONS'
        },
        'body': json.dumps(body, default=str)
    }
