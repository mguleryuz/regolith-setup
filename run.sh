#!/bin/bash

# Get the directory of the currently running script
script_path=$(dirname "$0")

# Function to list and run scripts
list_and_run_scripts() {
    local dir=$1

    # Find all .sh files in the selected directory excluding run.sh and prep.sh
    files=$(find "$dir" -maxdepth 1 -type f -name "*.sh" ! -name "run.sh" ! -name "prep.sh")

    # Convert files to an array
    file_array=($files)

    # Display the files with numbers
    for i in "${!file_array[@]}"; do
        echo "$((i + 1)): ${file_array[$i]}"
    done

    # Ask the user to select a file
    read -p "Enter the number of the file you want to run, or 'b' to go back: " file_num

    # Check if the user wants to go back
    if [[ $file_num == 'b' || $file_num == 'B' ]]; then
        return
    fi

    # Subtract 1 because bash arrays are 0-indexed
    file_num=$((file_num - 1))

    # Run the selected file
    bash "${file_array[$file_num]}"
}

# Find all directories starting with "v" and .sh files in the script's directory
items=$(find "$script_path" -maxdepth 1 \( -type d -name "v*" -o -type f -name "*.sh" ! -name "run.sh" ! -name "prep.sh" \))

# Convert items to an array
item_array=($items)

# Display the items with numbers
for i in "${!item_array[@]}"; do
    echo "$((i + 1)): ${item_array[$i]}"
done

# Ask the user to select an item
read -p "Enter the number of the item you want to select: " item_num

# Subtract 1 because bash arrays are 0-indexed
item_num=$((item_num - 1))

# Check if the selected item is a directory
if [[ -d "${item_array[$item_num]}" ]]; then
    # If it's a directory, list and run scripts in that directory
    list_and_run_scripts "${item_array[$item_num]}"
else
    # If it's a file, run it
    bash "${item_array[$item_num]}"
fi
