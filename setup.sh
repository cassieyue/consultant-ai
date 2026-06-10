#!/bin/bash

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing Consultant AI plugin..."

# Create required directories
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/consultant-ai

# Symlink root orchestrator skill
_link() {
  local target="$1"
  local source="$2"
  local label="$3"
  if [ -L "$target" ]; then
    rm "$target"
  elif [ -e "$target" ]; then
    echo "Warning: $target already exists and is not a symlink — skipping"
    return
  fi
  ln -s "$source" "$target"
  echo "  Linked: $label"
}

_link ~/.claude/commands/consult.md "$REPO_DIR/SKILL.md" "consult"

# Symlink each skill
for skill in add-course brief structure research framework draft review critique publish references compare help save load status project competitor size client; do
  _link ~/.claude/commands/${skill}.md "$REPO_DIR/skills/${skill}/SKILL.md" "$skill"
done

# Symlink frameworks reference directory
_link ~/.claude/consultant-ai/frameworks "$REPO_DIR/reference/frameworks" "reference/frameworks"

echo ""
echo "Done. Restart Claude Code for skills to appear."
echo "Then run /add-course to register your current courses."
