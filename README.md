# dotfiles

🌐 dotfiles &amp; global configs

<img width="3008" alt="Screenshot 2025-06-18 at 21 43 56" src="https://github.com/user-attachments/assets/45ad2842-1c12-4270-ae93-514c41315e9b" />

## Software

1. Terminal - [Ghostty](https://ghostty.org/)
1. Shell - [oh-my-zsh](https://ohmyz.sh/)
1. Code editor - [neovim](https://github.com/neovim/neovim/) with [rose-pine theme](https://github.com/rose-pine/neovim)
1. Font - [Berkeley Mono](https://berkeleygraphics.com/typefaces/berkeley-mono/)
1. Keyboard remapper - [Karabiner](https://karabiner-elements.pqrs.org/docs/getting-started/installation/)
1. Tile manager - [Rectangle](https://rectangleapp.com/)
1. Neat terminal plugins:

- [pomodoro](https://github.com/carlmjohnson/pomodoro)

## Installation

1. [install `karabiner`](https://karabiner-elements.pqrs.org/docs/getting-started/installation/)

2. [install `neovim`](https://github.com/neovim/neovim?tab=readme-ov-file#install-from-package):

```sh
brew install neovim
```

3. [install `ghostty`](https://ghostty.org/download)

4. clone repo to `~/code`

```sh
git clone git@github.com:yevhenorlov/dotfiles.git ~/code/dotfiles
```

5. add symlinks to pick up resources from dotfiles repo (for now this will probably break, hopefully in a graceful way)

```sh
cd ~/code/dotfiles
./install.sh
```

6. Install missing dependencies until terminal stops yelling at you.
