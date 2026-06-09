#!/bin/bash

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Consultant AI plugin..."

# Create required directories
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/consultant-ai

# Symlink each skill into ~/.claude/commands/
for skill in consult add-course framework structure research draft review; do
  target=~/.claude/commands/${skill}.md
  source="$REPO_DIR/commands/${skill}.md"
  if [ -L "$target" ]; then
    rm "$target"
  elif [ -f "$target" ]; then
    echo "Warning: $target already exists and is not a symlink — skipping"
    continue
  fi
  ln -s "$source" "$target"
  echo "  Linked: $skill"
done

# Symlink frameworks directory
frameworks_link=~/.claude/consultant-ai/frameworks
if [ -L "$frameworks_link" ]; then
  rm "$frameworks_link"
elif [ -d "$frameworks_link" ]; then
  echo "Warning: ~/.claude/consultant-ai/frameworks already exists as a directory — skipping"
else
  ln -s "$REPO_DIR/frameworks" "$frameworks_link"
  echo "  Linked: frameworks/"
fi

echo ""
echo "Done. Restart Claude Code for skills to appear."
echo "Then run /add-course to register your current courses."
