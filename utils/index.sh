#!/bin/bash

ask_and_run() {
    echo "Do you want to run the command: $1? (y/n)"
    read answer
    if [ "$answer" = "y" ]; then
        echo "Running the command: $1"
        $1
        echo "Command finished."
    else
        echo "Command not run."
    fi
}

function update_key_value() {
    # Get the arguments
    local key=$1
    local value=$2
    local config_file=$3

    # Check if the key exists in the file
    if sudo grep -q "^$key" $config_file; then
        # If the key exists, replace its value
        sudo sed -i "s|^$key.*|$key$value|" $config_file
    else
        # If the key doesn't exist, add the key-value pair at the top of the file, but after the commented lines
        local comments=$(sed -n '/^#/p' $config_file)
        local content=$(sed '/^#/d' $config_file)
        echo -e "$comments\n$key$value\n$content" | sudo tee $config_file
    fi
}

function update_config_section() {
    # Get the arguments
    local section=$1
    local key=$2
    local value=$3
    local config_file=$4

    if sudo grep -q "^\[$section\]" $config_file; then
        # If the section exists, check if the exact key-value pair exists in the section
        if ! sudo grep -q "^$key=$value" $config_file; then
            # If the exact key-value pair doesn't exist, add it to the section
            sudo sed -i "/^\[$section\]/a $key=$value" $config_file
        fi
    else
        # If the section doesn't exist, add the section and the key-value pair at the top of the file, but after the commented lines
        local comments=$(sed -n '/^#/p' $config_file)
        local content=$(sed '/^#/d' $config_file)
        echo -e "$comments\n[$section]\n$key=$value\n$content" | sudo tee $config_file
    fi
}
