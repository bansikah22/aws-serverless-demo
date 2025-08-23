#!/usr/bin/env python3
"""
Test script for the Serverless Todo API
"""
import requests
import json
import sys
from typing import Dict, Any

def test_api(base_url: str) -> None:
    """
    Test all API endpoints
    """
    print("Testing Serverless Todo API")
    print("=" * 40)
    
    # Test 1: Create a task
    print("\n1. Creating a new task...")
    task_data = {
        "title": "Learn AWS Serverless",
        "description": "Build a serverless todo API with Lambda, API Gateway, and DynamoDB"
    }
    
    response = requests.post(f"{base_url}/tasks", json=task_data)
    print(f"Status Code: {response.status_code}")
    
    if response.status_code == 201:
        task = response.json()['task']
        task_id = task['id']
        print(f"Task created successfully! ID: {task_id}")
        print(f"Task: {task['title']}")
    else:
        print(f"Error creating task: {response.text}")
        return
    
    # Test 2: Get all tasks
    print("\n2. Getting all tasks...")
    response = requests.get(f"{base_url}/tasks")
    print(f"Status Code: {response.status_code}")
    
    if response.status_code == 200:
        tasks = response.json()['tasks']
        print(f"Found {len(tasks)} task(s)")
        for task in tasks:
            print(f"- {task['title']} (ID: {task['id']})")
    else:
        print(f"Error getting tasks: {response.text}")
    
    # Test 3: Create another task
    print("\n3. Creating another task...")
    task_data2 = {
        "title": "Deploy with Terraform",
        "description": "Learn infrastructure as code with Terraform"
    }
    
    response = requests.post(f"{base_url}/tasks", json=task_data2)
    if response.status_code == 201:
        task2 = response.json()['task']
        task2_id = task2['id']
        print(f"Second task created! ID: {task2_id}")
    else:
        print(f"Error creating second task: {response.text}")
    
    # Test 4: Get all tasks again
    print("\n4. Getting all tasks again...")
    response = requests.get(f"{base_url}/tasks")
    if response.status_code == 200:
        tasks = response.json()['tasks']
        print(f"Now we have {len(tasks)} task(s)")
        for task in tasks:
            print(f"- {task['title']} (ID: {task['id']})")
    
    # Test 5: Delete the first task
    print(f"\n5. Deleting task {task_id}...")
    response = requests.delete(f"{base_url}/tasks/{task_id}")
    print(f"Status Code: {response.status_code}")
    
    if response.status_code == 200:
        print("Task deleted successfully!")
    else:
        print(f"Error deleting task: {response.text}")
    
    # Test 6: Verify deletion
    print("\n6. Verifying deletion...")
    response = requests.get(f"{base_url}/tasks")
    if response.status_code == 200:
        tasks = response.json()['tasks']
        print(f"Remaining tasks: {len(tasks)}")
        for task in tasks:
            print(f"- {task['title']} (ID: {task['id']})")
    
    print("\n" + "=" * 40)
    print("API testing completed!")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python test_api.py <API_BASE_URL>")
        print("Example: python test_api.py https://abc123.execute-api.us-east-1.amazonaws.com/dev")
        sys.exit(1)
    
    base_url = sys.argv[1].rstrip('/')
    test_api(base_url)
