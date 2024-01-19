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
