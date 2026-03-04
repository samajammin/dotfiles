# Dotfiles for your local development environment

## Usage

Clone repository:

```sh
git clone https://github.com/samajammin/dotfiles.git ~/.dotfiles
```

Install the dotfiles:

```sh
bash ~/.dotfiles/install.sh
```

Restart your terminal and you are ready to go!

Verify everything is working:

```sh
bash ~/.dotfiles/test.sh
```

## What's included?

- [zsh](http://www.zsh.org/) with [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- [Spaceship ZSH](https://github.com/spaceship-prompt/spaceship-prompt) prompt theme
- [Powerline fonts](https://github.com/powerline/fonts) (optional)
- [Homebrew](https://brew.sh/) with bundled packages (see [Brewfile](./Brewfile))
- [Volta](https://volta.sh/) for Node.js/Yarn version management
- ZSH plugins: autosuggestions, syntax highlighting, completions

## Structure

```
├── install.sh        # Setup script (idempotent, safe to re-run)
├── test.sh           # Verify dotfiles are correctly linked
├── Brewfile          # Homebrew packages
├── aliases.zsh       # Shell aliases (git, docker, k8s, safety flags)
├── custom.zsh        # ZSH theme config, plugin loading
├── exports.zsh       # Environment variables, PATH, editor config
├── config/
│   └── global.gitconfig  # Git aliases, colors, editor
└── dotfiles/         # Symlinked to ~/ as dotfiles
    ├── zshrc
    ├── zshenv
    ├── gitconfig
    ├── gitignore
    ├── inputrc
    ├── irbrc
    └── pryrc
```

## License

Thank you [@josemarluedke](https://github.com/josemarluedke) for the [dotfiles foundation](https://github.com/josemarluedke/dotfiles) to build off (and for being an amazing mentor)!

Copyright (c) 2012-2020 Josemar Luedke, Sam Richards

Licensed under the MIT license
