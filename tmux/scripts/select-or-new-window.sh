#!/bin/bash

ARG="$1"
SESSION_ID=$(tmux display-message -p '#{session_id}')

# Check if argument is a relative offset (starts with + or -)
if [[ "$ARG" =~ ^[+-] ]]; then
    # Get current window index
    CURRENT_INDEX=$(tmux display-message -p '#{window_index}')
    # Calculate target index (bash arithmetic)
    TARGET_WINDOW_INDEX=$((CURRENT_INDEX + ARG))
    
    # Ensure we don't go below base-index
    BASE_INDEX=$(tmux show-option -gv base-index)
    if [ "$TARGET_WINDOW_INDEX" -lt "$BASE_INDEX" ]; then
        TARGET_WINDOW_INDEX="$BASE_INDEX"
    fi
else
    # Direct window index
    TARGET_WINDOW_INDEX="$ARG"
fi

if tmux list-windows -F "#{window_index}" | grep -q "^${TARGET_WINDOW_INDEX}$"; then
    echo "DEBUG: Window $TARGET_WINDOW_INDEX exists. Attempting to select..." >&2
    tmux select-window -t "$SESSION_ID:$TARGET_WINDOW_INDEX"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to select existing window $TARGET_WINDOW_INDEX." >&2
    fi
else
    echo "DEBUG: Window $TARGET_WINDOW_INDEX does not exist. Attempting to create and select." >&2
    tmux new-window -d -t "$SESSION_ID:$TARGET_WINDOW_INDEX" && \
    tmux select-window -t "$SESSION_ID:$TARGET_WINDOW_INDEX"
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to create or select new window $TARGET_WINDOW_INDEX." >&2
    fi
fi
