#!/bin/zsh

# A script to run with MacOS Automator to enable "Always open with"
#   for file types I want to open in nvim.
# Prerequisites:
# - WezTerm installed
# - nvim installed
# - Automator applet created with this script as the "Run Shell Script" action

TERM_EXEC="path/to/wezterm.app/Contents/MacOS/wezterm"
NVIM_EXEC="path/to/nvim"

# No arguments, just start a new terminal and bounce.
# - useful if placing the automator applet in the dock.
if [ -z "$1" ]; then
    exec nohup "$TERM_EXEC" > /dev/null 2>&1 &
    exit 0
fi

# Open or attach to wezterm gui instance
# nohup to disconnect automator from the application
# send stdout and stderr to /dev/null
# & to run the nvim proc in bg
exec nohup $TERM_EXEC start \
    --cwd "$(dirname "$1")" \
    --new-tab \
    -- "$NVIM_EXEC" "$@" > /dev/null 2>&1 &;
