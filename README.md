# chezmoi

My personal configuration files managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

To apply this configuration on a new machine:

    chezmoi init https://github.com/DIAK26/chezmoi
    chezmoi apply

> **Note:** This only copies the config files. You still need to install the tools listed below manually.

## Requirements

Install the following tools before or after applying the config:

| Tool / Plugin | Purpose | Install Command |
|---------------|---------|-----------------|
| oh-my-zsh | Zsh framework and plugin manager | sh -c "$(curl -fsSL https://install.ohmyz.sh)" |
| zsh-autosuggestions | Fish-style command suggestions | sudo apt install zsh-autosuggestions |
| zsh-syntax-highlighting | Real-time syntax highlighting | sudo apt install zsh-syntax-highlighting |
| fzf | Fuzzy finder for history/files | sudo apt install fzf |
| bat | cat replacement with syntax highlighting | sudo apt install bat |
| lsd | Modern ls with icons/colors | sudo apt install lsd |
| zellij | Terminal multiplexer | cargo install zellij |
| zed | Fast, modern code editor | curl -f https://zed.dev/install.sh | sh |

> **Debian note:** bat may be installed as batcat. Check with which bat or which batcat.

## Git Configuration

Global Git settings configured in ~/.gitconfig:

| Setting / Alias | Purpose | Command / Value |
|-----------------|---------|-----------------|
| user.name | Author identity for commits | Your real name or GitHub display name |
| user.email | Author email for commits | GitHub-associated email |
| co | Short for checkout | git checkout |
| ci | Short for commit | git commit -m |
| br | Short for branch | git branch |
| st | Short for status | git status |
| lg | Graphical commit history | git log --graph --pretty=format:... |
| last | Show last commit only | git log -1 HEAD |
| core.editor | Default text editor | nano |
| core.autocrlf | Line ending handling | input (for cross-platform compatibility) |
| pull.rebase | Pull strategy | false (merge instead of rebase) |
| init.defaultBranch | Default branch for new repos | main (instead of legacy master) |

> **Tip:** Use git config --global --list to view all settings locally.

## Shell

- **Shell:** Zsh 5.9
- **Framework:** oh-my-zsh
- **Theme:** configurable (currently empty)

## What's Included

### Shell (.zshrc)
- Aliases for lsd (modern ls replacement): ls, ll, la, lt, ld
- Plugin config for zsh-autosuggestions and zsh-syntax-highlighting
- fzf keybindings and completion
- Custom prompt via Starship

### Version Control (.gitconfig)
- Git user identity (name + email)
- Convenience aliases (git st, git co, git ci, etc.)
- Beautiful commit history graph (git lg)
- Modern defaults (main branch, nano editor)

## Managed Files

| File | Location | Description |
|------|----------|-------------|
| .zshrc | ~/.zshrc | Zsh shell configuration |
| .gitconfig | ~/.gitconfig | Git global configuration |
| .ssh/config | ~/.ssh/config | SSH connection settings (coming soon) |

## License

MIT
