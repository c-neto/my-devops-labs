#!/bin/bash

# Define the log file path
LOG_FILE="/logs/logfile.log"

# Ensure the log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Initialize the counter
i=0

# Infinite loop to generate log messages
while true; do
    LOG_MESSAGE="#$i"
    # Append the log message to the log file
    echo "$LOG_MESSAGE" >> "$LOG_FILE"
    echo "$LOG_MESSAGE"

    # Increment the counter
    ((i++))
    
    # Sleep for 1 second
    sleep 1
done
