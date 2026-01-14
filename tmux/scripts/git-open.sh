#!/usr/bin/env bash

set -e
set -u
set -o pipefail

if [ -n "$TMUX" ]; then
  cd "$(tmux display-message -p '#{pane_current_path}')"
fi

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "Error: Not inside a Git repository." >&2
  exit 1
fi

REMOTE_URL=$(git config --get remote.origin.url)

if [ -z "$REMOTE_URL" ]; then
  echo "Error: Could not find a remote URL for 'origin'." >&2
  exit 1
fi

HTTP_URL=$(echo "$REMOTE_URL" | sed \
  -e 's/^git@\([^:]*\):/https:\/\/\1\//' \
  -e 's/\.git$//')

echo "Opening Remote Repository: $HTTP_URL"

# This is a wsl thing to refer to explorer to open URL
"open" "$HTTP_URL" || true

exit 0
