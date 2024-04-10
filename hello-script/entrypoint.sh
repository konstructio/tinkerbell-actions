#!/usr/bin/env bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <command>"
    exit 1
fi

# Store the command string from the argument
cmd_string="$1"

# Print the command to be executed
echo "Executing command: $cmd_string"

# Execute the command using eval (be cautious with eval and user inputs)
eval "$cmd_string"