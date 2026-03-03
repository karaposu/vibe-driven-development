#!/bin/bash
# Install AlignStack slash commands and hooks for Claude Code
# Usage: curl -sL https://raw.githubusercontent.com/karaposu/alignstack/main/commands/install.sh | bash

set -e

REPO_URL="https://raw.githubusercontent.com/karaposu/alignstack/main"
COMMANDS_DIR="$HOME/.claude/commands"
HOOKS_DIR="$HOME/.claude/hooks"

mkdir -p "$COMMANDS_DIR"
mkdir -p "$HOOKS_DIR"

# --- Slash Commands ---

echo "Installing slash commands..."

commands=(
  elaborate.md
  task-desc.md
  task-plan.md
  critic.md
  critic-d.md
  sense-making.md
  arch-small-summary.md
  arch-intro.md
  arch-traces.md
  arch-top-improvements.md
  dead-code-index.md
  dead-code-concepts.md
)

for cmd in "${commands[@]}"; do
  echo "  downloading $cmd"
  curl -sL "$REPO_URL/commands/$cmd" -o "$COMMANDS_DIR/$cmd"
done

# --- Hooks ---

echo ""
echo "Installing hooks..."

hooks=(
  devdocs_metadata_appender.sh
)

for hook in "${hooks[@]}"; do
  echo "  downloading $hook"
  curl -sL "$REPO_URL/hooks/$hook" -o "$HOOKS_DIR/$hook"
  chmod +x "$HOOKS_DIR/$hook"
done

# --- Summary ---

echo ""
echo "Done. Installed ${#commands[@]} slash commands to $COMMANDS_DIR"
echo "Done. Installed ${#hooks[@]} hooks to $HOOKS_DIR"
echo ""
echo "Slash commands: /elaborate, /task-desc, /task-plan, /critic, /critic-d, /sense-making, /arch-small-summary, /arch-intro, /arch-traces, /arch-top-improvements, /dead-code-index, /dead-code-concepts"
echo ""
echo "To activate the devdocs metadata hook, add this to .claude/settings.json:"
echo ""
echo '  {"hooks":{"PreToolUse":[{"matcher":"Write","hooks":[{"type":"command","command":"~/.claude/hooks/devdocs_metadata_appender.sh"}]}]}}'
