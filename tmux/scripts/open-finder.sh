#!/usr/bin/env bash

set -e
set -u
set -o pipefail

if [ -z "${TMUX:-}" ]; then
  open .
  exit 0
fi

CURRENT_PATH=$(tmux display-message -p '#{pane_current_path}')
TARGET_PATH=$CURRENT_PATH

if [ -z "$TARGET_PATH" ] || [ ! -d "$TARGET_PATH" ]; then
  echo "Error: Could not determine current pane directory." >&2
  exit 1
fi

open "$TARGET_PATH"
echo "Opened Finder: $TARGET_PATH"
