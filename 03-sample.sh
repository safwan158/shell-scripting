#!/bin/bash

read -p 'Enter some input: ' input

if [ -z "$input" ]; then 
    echo "No Input"
    exit 1
fi
echo "Input - $input"

if [ $input == "ABC" ]; then 
    echo "Provide ABC"
fi
echo "input - $input"
if [ $? -eq 0 ]; then
    echo Success
else
    echo failure
fi

