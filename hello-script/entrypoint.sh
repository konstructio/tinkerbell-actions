#!/usr/bin/env bash

# Store the command string from the argument
cmd_string="$COMMAND_STRING"

# Print the command to be executed
echo "Executing command: $cmd_string"

# Execute the command using eval (be cautious with eval and user inputs)
eval "$cmd_string"