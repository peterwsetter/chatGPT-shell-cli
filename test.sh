#!/bin/bash

declare -A my_array

while read line; do
    key=$(echo $line | cut -d' ' -f1)  # Extract the key (the first word)
    value=$(echo $line | cut -d' ' -f2-)  # Extract the value (the rest of the line)
    my_array[$key]=$value  # Assign the value to the key in the array
done < prompts.txt

for key in "${!my_array[@]}"; do
    echo "$key: ${my_array[$key]}"
done

# Read user input and replace keys with values from the array
while true; do
    read -p "Enter text to replace: " input_text  # Read user input

    # Check if user entered 'exit' and exit if true
    if [ "$input_text" = "exit" ]; then
        echo "Exiting..."
        exit 0
    fi

    # Loop over the keys in the array and replace them with their values in the input text
    for key in "${!my_array[@]}"; do
        input_text=${input_text//$key/${my_array[$key]}}
    done

    echo "Replaced text: $input_text"  # Print the replaced text
done
