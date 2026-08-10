#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Strip #
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Utils

# Documentation:
# @raycast.description Strip leading "# " for all lines in clipboard
# @raycast.author Shan

pbpaste | sed -E 's/^# ?//' | pbcopy
echo "Stripped leading #s"
