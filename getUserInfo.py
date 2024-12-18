import requests
import json
from base64 import b64encode

# Genesys Cloud API credentials; find the clientID and Client Secret in the Genesys Admin portal
client_id = 'clientID-goes-here'
client_secret = 'clientSecret-Goes-Here'
environment = 'usw2.pure.cloud'
#change the environment to match yours

# Encode credentials
credentials = f"{client_id}:{client_secret}"
encoded_credentials = b64encode(credentials.encode('utf-8')).decode('utf-8')

# Get access token
auth_url = f"https://login.{environment}/oauth/token"
auth_headers = {
    'Authorization': f'Basic {encoded_credentials}',
    'Content-Type': 'application/x-www-form-urlencoded'
}
auth_data = {
    'grant_type': 'client_credentials'
}

auth_response = requests.post(auth_url, headers=auth_headers, data=auth_data)
access_token = auth_response.json()['access_token']

# Set up API headers
api_headers = {
    'Authorization': f'Bearer {access_token}',
    'Content-Type': 'application/json'
}

# Prompt for user name
user_name = input("Enter the full name of the user to search for: ")

# Search for users
search_url = f"https://api.{environment}/api/v2/users/search"
search_body = {
    "query": [
        {
            "fields": ["name"],
            "value": user_name,
            "type": "CONTAINS"
        }
    ],
    "pageSize": 25,
    "pageNumber": 1
}

search_response = requests.post(search_url, headers=api_headers, json=search_body)

if search_response.status_code == 200:
    search_results = search_response.json()
    if search_results['total'] > 0:
        if search_results['total'] == 1:
            user = search_results['results'][0]
        else:
            print(f"Found {search_results['total']} users. Please select one:")
            for i, user in enumerate(search_results['results'], 1):
                print(f"{i}. {user['name']}")
            selection = int(input("Enter the number of the user you want to view: ")) - 1
            user = search_results['results'][selection]

        # Get detailed user information
        user_id = user['id']
        user_url = f"https://api.{environment}/api/v2/users/{user_id}"
        user_response = requests.get(user_url, headers=api_headers)

        if user_response.status_code == 200:
            user_info = user_response.json()
            print("\nUser Information:")
            print(json.dumps(user_info, indent=2))
        else:
            print(f"\nError: Unable to retrieve detailed user information. Status code: {user_response.status_code}")
            print("Response:", user_response.text)
    else:
        print("No users found matching the given name.")
else:
    print(f"\nError: Unable to search for users. Status code: {search_response.status_code}")
    print("Response:", search_response.text)
