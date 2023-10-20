#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <option>"
    echo "Options: short / full"
    exit 1
fi

option="$1"
json_file="path-to-your-webpack-stats/webpack-stats/ui.json"

if [ "$option" = "short" ]; then
    cat "$json_file" | jq 'if .status == "error" then "\(.error): \(.message[:18])..." else .status end' | tr -d '"'
elif [ "$option" = "full" ]; then
    cat "$json_file" | jq '{status: .status, error: .error, message: .message[:300]}'
else
    echo "Invalid option: $option"
    echo "Options: short / full"
    exit 1
fi

