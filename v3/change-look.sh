#!/bin/bash

# List available themes
echo "Available themes:"
themes=$(apt search ^regolith-look- | grep -oP '(?<=^regolith-look-).*(?=/)')
themes_array=($themes)

# Print themes with numbers
for i in "${!themes_array[@]}"; do
    printf "%s) %s\n" "$((i + 1))" "${themes_array[$i]}"
done

# Prompt the user to select a theme
read -p "Please enter the number of the theme you want to install: " theme_number

# Check if the selected theme is available
if ((theme_number > 0 && theme_number <= ${#themes_array[@]})); then
    theme=${themes_array[$((theme_number - 1))]}
    # Install, set, and refresh the selected theme
    sudo apt install "regolith-look-$theme"
    regolith-look set "$theme"
    regolith-look refresh
else
    echo "Invalid selection. Please run the script again and select a valid number."
fi
