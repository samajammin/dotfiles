#!/bin/bash
# Quick sanity check for dotfiles setup

pass=0
fail=0

check() {
  if eval "$2" &> /dev/null; then
    echo "  ✓ $1"
    ((pass++))
  else
    echo "  ✗ $1"
    ((fail++))
  fi
}

echo "Symlinks:"
check "~/.zshrc exists"      "[ -L ~/.zshrc ]"
check "~/.zshenv exists"     "[ -L ~/.zshenv ]"
check "~/.gitconfig exists"  "[ -L ~/.gitconfig ]"
check "~/.gitignore exists"  "[ -L ~/.gitignore ]"
check "~/.inputrc exists"    "[ -L ~/.inputrc ]"
check "~/.irbrc exists"      "[ -L ~/.irbrc ]"
check "~/.pryrc exists"      "[ -L ~/.pryrc ]"
check "No broken symlinks"   "! find ~/.dotfiles/dotfiles -maxdepth 1 -exec test -L {} -a ! -e {} \; -print | grep -q ."

echo ""
echo "Source files:"
check "aliases.zsh exists"   "[ -f ~/.dotfiles/aliases.zsh ]"
check "custom.zsh exists"    "[ -f ~/.dotfiles/custom.zsh ]"
check "exports.zsh exists"   "[ -f ~/.dotfiles/exports.zsh ]"

echo ""
echo "Tools:"
check "Homebrew installed"   "command -v brew"
check "Git installed"        "command -v git"
check "Volta installed"      "command -v volta"
check "Node installed"       "command -v node"

echo ""
echo "Environment:"
check "EDITOR is set"        "[ -n \"$EDITOR\" ]"
check "VOLTA_HOME is set"    "[ -n \"$VOLTA_HOME\" ]"
check "Git user.name set"    "git config user.name"
check "Git includes global"  "git config include.path"

echo ""
echo "---"
echo "$pass passed, $fail failed"
