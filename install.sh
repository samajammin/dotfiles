#!/bin/sh

DOTFILES=~/.dotfiles

# Add global gitconfig
git config --global include.path $DOTFILES/config/global.gitconfig

# Install Brew
echo "Checking if homebrew is installed."
type brew > /dev/null
rc=$?; if [[ $rc != 0 ]]; then
  echo "Installing homebrew."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "Verifying homebrew installation."
  type brew
  rc=$?; if [[ $rc != 0 ]]; then
    echo "Cannot find homebrew installation. Check the error log."
    exit $rc
  else
    echo "Homebrew installation is verified."
  fi
else
  echo "Homebrew is already installed."
fi

# Install Volta
echo "Checking if volta is installed."
type volta > /dev/null
rc=$?; if [[ $rc != 0 ]]; then
  echo "Installing Volta."
  brew install volta

  echo "Verifying volta installation."
  type volta
  rc=$?; if [[ $rc != 0 ]]; then
    echo "Cannot find volta installation."
    exit $rc
  else
    echo "Volta installation is verified."
  fi
else
  echo "Volta is already installed."
fi

# Install Node & Yarn using Volta
type volta > /dev/null
rc=$?; if [[ $rc == 0 ]]; then
  echo "Installing Node using Volta."
  volta install node@latest

  echo "Installing Yarn using Volta."
  volta install yarn
fi

# Brew bundle
echo "Do you want to run brew bundle from dotfiles? [Y/N]"
read choice
if [[ $choice = 'Y' ]] || [[ $choice = 'y' ]]; then
  brew tap Homebrew/bundle
  brew bundle --file=$DOTFILES/Brewfile
else
  echo "Brew bundle skipped."
fi

# Install oh my zsh
# if [ ! -n "$ZSH" ]; then
#   hijack_env() {
#     if [[ "$1" != "zsh" ]]; then
#       env "$@"
#     fi
#   }

#   alias env="hijack_env"
#   curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -so - | sh
#   unalias env
# fi

# Install Spaceship zsh theme
ZSH_CUSTOM=~/.oh-my-zsh/custom
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" > /dev/null

# Install powerline fonts
echo "Do you want to install Powerline fonts? [Y/N]"
read choice
if [[ $choice = 'Y' ]] || [[ $choice = 'y' ]]; then
  TMP_POWERLINE_FONTS=tmp-install-fonts
  env git clone --depth=1 https://github.com/powerline/fonts.git $TMP_POWERLINE_FONTS
  cd $TMP_POWERLINE_FONTS
  sh ./install.sh
  cd ..
  rm -rf $TMP_POWERLINE_FONTS
  echo "Powerline fonts installed."
else
  echo "Powerline fonts skipped."
fi

# Symlink files
echo "Symlinking dotfiles."
for i in `find ~/.dotfiles/dotfiles/* -maxdepth 1`; do
  original_file=`basename $i`

  if [[ "$original_file" != "dotfiles" ]]; then
    ln -snfv $i ~/.${original_file} > /dev/null
  fi
done

ln -snfv ~/.dotfiles/custom.zsh $ZSH_CUSTOM/custom.zsh > /dev/null
env zsh