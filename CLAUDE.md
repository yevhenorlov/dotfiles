# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Architecture

This is a personal dotfiles repository containing configuration files and setup scripts for a macOS development environment. The repository follows a modular approach with symlinks managed by the installation script.

### Core Components

- **nvim/**: Neovim configuration using Lazy plugin manager
  - `init.lua`: Entry point that sets up lazy.nvim and loads custom configuration
  - `lua/lazy_plugins/`: Plugin configurations for various tools (LSP, completion, telescope, etc.)
  - `lua/yvhn/`: Personal configuration modules (settings, keymaps, commands)
- **zsh/**: Shell configuration with modular structure
  - `.zshrc`: Sources environment variables and modular configuration files
  - `themes/`: Custom zsh theme (lambda_minimal)
- **karabiner/**: Keyboard remapping configuration (Caps Lock to Hyper key or Escape)
- **tmux utilities**: Session management and cheat sheet scripts

### Configuration Loading Pattern

The Neovim configuration follows a two-tier plugin system:

1. `lazy_plugins/` - Contains individual plugin configurations
2. `yvhn/` - Contains personal settings, keymaps, and custom commands loaded via `yvhn/init.lua`

The zsh configuration uses a modular approach where `.zshrc` sources separate module files for different concerns (aliases, settings, theme, etc.).

## Installation and Setup

```bash
# Install the dotfiles (creates symlinks to ~/.config and home directory)
cd ~/code/dotfiles
./install.sh
```

The install script creates symlinks for all configuration files and installs required global npm packages and brew dependencies.

## Key Files for Editing

- `nvim/lua/yvhn/settings.lua` - Core Neovim settings
- `nvim/lua/yvhn/keymap.lua` - Custom key mappings
- `zsh/.zshrc` - Main shell configuration entry point
- `karabiner/karabiner.json` - Keyboard remapping rules

## Dependencies

Global tools installed by the setup:

- ripgrep (for telescope search)
- prettier, tldr, typescript, @vue/language-server (npm globals)
- Neovim plugins managed by lazy.nvim
- oh-my-zsh with custom theme

## Development Workflow

When modifying configurations:

1. Edit files directly in the dotfiles repository
2. Changes are immediately reflected due to symlinks
3. For Neovim plugins, use `:Lazy` commands to manage
4. Restart relevant applications to pick up configuration changes

