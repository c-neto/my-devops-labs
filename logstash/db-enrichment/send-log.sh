#!/bin/bash

# Set the URL and headers
URL="http://127.0.0.1:8090/"
HEADER="Content-Type: application/json"

# Function to send a POST request
send_post_request() {
  local payload=$1
  curl -X POST "$URL" \
    -H "$HEADER" \
    -d "$payload"
}

# Send the appropriate payload based on the argument
if [[ "$1" == "db" ]]; then
  send_post_request '{"event": "purchase", "user_id": 3}'
else
  send_post_request '{"event": "no database query"}'
fi
