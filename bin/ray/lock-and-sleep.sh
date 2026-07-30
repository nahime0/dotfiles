#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Lock & Sleep Displays
# @raycast.mode silent
# @raycast.icon 🔒
# @raycast.packageName System
# @raycast.description Locks the screen and immediately puts the displays to sleep.

osascript -e 'tell application "System Events" to keystroke "q" using {control down, command down}'
sleep 0.3
pmset displaysleepnow
