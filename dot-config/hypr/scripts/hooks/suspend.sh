#!/usr/bin/sh

PRE_DIR="$(dirname "$0")/suspend-pre.d"
POST_DIR="$(dirname "$0")/suspend-post.d"

if [ "$1" = "pre" ]; then
  if [ -d "$PRE_DIR" ]; then
    for script in "$PRE_DIR"/*; do
      if [ -x "$script" ]; then
        echo "Running pre suspend hook: $(basename "$script")"
        "$script"
      fi
    done
  fi

elif [ "$1" = "post" ]; then
  if [ -d "$POST_DIR" ]; then
    for script in "$POST_DIR"/*; do
      if [ -x "$script" ]; then
        echo "Running post suspend hook: $(basename "$script")"
        "$script"
      fi
    done
  fi
fi
