# zshrc-config

My personal Zsh configuration, managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

To apply this configuration on a new machine:

bash chezmoi init https://github.com/DIAK26/zshrc-config chezmoi apply


> **Note:** This only copies the config files. You still need to install the tools listed below manually.

## Requirements

Install the following tools before or after applying the config:

| Tool / Plugin | Purpose | Install Command |
|---------------|---------|-----------------|
| oh-my-zsh | Zsh framework and plugin manager | `sh -c "$(curl -fsSL https://install.ohmyz.sh)"` |
| zsh-autosuggestions | Fish-style command suggestions | `sudo apt install zsh-autosuggestions` |
| zsh-syntax-highlighting | Real-time syntax highlighting | `sudo apt install zsh-syntax-highlighting` |
| fzf | Fuzzy finder for history/files | `sudo apt install fzf` |
| bat | cat replacement with syntax highlighting | `sudo apt install bat` |
| lsd | Modern ls with icons/colors | `sudo apt install lsd` |
| zellij | Terminal multiplexer | `cargo install zellij` |
| zed | Fast, modern code editor | `curl -f https://zed.dev/install.sh \| sh` |

> **Debian note:** `bat` may be installed as `batcat`. Check with `which bat` or `which batcat`.

## Shell

- **Shell:** Zsh 5.9
- **Framework:** oh-my-zsh
- **Theme:** configurable

## What's Included

- Aliases for `lsd` (modern `ls` replacement)
- Plugin config for `zsh-autosuggestions` and `zsh-syntax-highlighting`
- `fzf` keybindings and completion
- Custom prompt / theme settings

## License

MIT
