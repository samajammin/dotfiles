#!/bin/bash

DOTFILES=~/.dotfiles

# Add global gitconfig
git config --global include.path "$DOTFILES/config/global.gitconfig"

# Install Brew
echo "Checking if homebrew is installed."
if ! command -v brew &> /dev/null; then
  echo "Installing homebrew."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if ! command -v brew &> /dev/null; then
    echo "Cannot find homebrew installation. Check the error log."
    exit 1
  fi
  echo "Homebrew installation is verified."
else
  echo "Homebrew is already installed."
fi

# Install Volta
echo "Checking if volta is installed."
if ! command -v volta &> /dev/null; then
  echo "Installing Volta."
  brew install volta

  if ! command -v volta &> /dev/null; then
    echo "Cannot find volta installation."
    exit 1
  fi
  echo "Volta installation is verified."
else
  echo "Volta is already installed."
fi

# Install Node & Yarn using Volta
if command -v volta &> /dev/null; then
  echo "Installing Node using Volta."
  volta install node@latest

  echo "Installing Yarn using Volta."
  volta install yarn
fi

# Brew bundle
echo "Do you want to run brew bundle from dotfiles? [Y/N]"
read choice
if [[ "$choice" = 'Y' ]] || [[ "$choice" = 'y' ]]; then
  brew bundle --file="$DOTFILES/Brewfile"
else
  echo "Brew bundle skipped."
fi

# Install Spaceship zsh theme
ZSH_CUSTOM=~/.oh-my-zsh/custom
if [ ! -d "$ZSH_CUSTOM/themes/spaceship-prompt" ]; then
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
  ln -snf "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
else
  echo "Spaceship theme is already installed."
fi

# Install powerline fonts
echo "Do you want to install Powerline fonts? [Y/N]"
read choice
if [[ "$choice" = 'Y' ]] || [[ "$choice" = 'y' ]]; then
  TMP_POWERLINE_FONTS=$(mktemp -d)
  env git clone --depth=1 https://github.com/powerline/fonts.git "$TMP_POWERLINE_FONTS"
  sh "$TMP_POWERLINE_FONTS/install.sh"
  rm -rf "$TMP_POWERLINE_FONTS"
  echo "Powerline fonts installed."
else
  echo "Powerline fonts skipped."
fi

# Symlink files
echo "Symlinking dotfiles."
for file in "$DOTFILES"/dotfiles/*; do
  ln -snfv "$file" "$HOME/.$(basename "$file")"
done

ln -snfv "$DOTFILES/custom.zsh" "$ZSH_CUSTOM/custom.zsh"
env zsh
