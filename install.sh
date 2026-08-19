#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════
# Linux Dotfiles & Tools Installation Script
# Idempotent, mit Echo-Ausgaben und Fehlerbehandlung
# ═══════════════════════════════════════════════════════════════════════

set -e  # Exit on error

# Farben für Output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ───────────────────────────────────────────────────────────────────────
# Helper Functions
# ───────────────────────────────────────────────────────────────────────

log_info() {
    echo -e "${BLUE}ℹ ${NC}$1"
}

log_success() {
    echo -e "${GREEN}✓ ${NC}$1"
}

log_error() {
    echo -e "${RED}✗ ${NC}$1"
}

log_warning() {
    echo -e "${YELLOW}⚠ ${NC}$1"
}

# Prüfe ob Tool bereits installiert ist
is_installed() {
    command -v "$1" &> /dev/null
}

# ═══════════════════════════════════════════════════════════════════════
# START
# ═══════════════════════════════════════════════════════════════════════

echo ""
echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Linux Tools & Dotfiles Installation Script            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Update package lists
log_info "Aktualisiere Package-Listen..."
sudo apt update

# ═══════════════════════════════════════════════════════════════════════
# 1. OH-MY-ZSH
# ═══════════════════════════════════════════════════════════════════════

if [ -d "$HOME/.oh-my-zsh" ]; then
    log_success "oh-my-zsh bereits installiert"
else
    log_info "Installiere oh-my-zsh..."
    sh -c "$(curl -fsSL https://install.ohmyz.sh)" "" --unattended
    log_success "oh-my-zsh installiert"
fi

# ═══════════════════════════════════════════════════════════════════════
# 2. ZSH PLUGINS
# ═══════════════════════════════════════════════════════════════════════

log_info "Installiere zsh-autosuggestions..."
if is_installed zsh-autosuggestions; then
    log_success "zsh-autosuggestions bereits installiert"
else
    sudo apt install -y zsh-autosuggestions
    log_success "zsh-autosuggestions installiert"
fi

log_info "Installiere zsh-syntax-highlighting..."
if is_installed zsh-syntax-highlighting; then
    log_success "zsh-syntax-highlighting bereits installiert"
else
    sudo apt install -y zsh-syntax-highlighting
    log_success "zsh-syntax-highlighting installiert"
fi

# ═══════════════════════════════════════════════════════════════════════
# 3. FZF (Fuzzy Finder)
# ═══════════════════════════════════════════════════════════════════════

if is_installed fzf; then
    log_success "fzf bereits installiert"
else
    log_info "Installiere fzf..."
    sudo apt install -y fzf
    log_success "fzf installiert"
fi

# ═══════════════════════════════════════════════════════════════════════
# 4. BAT (cat replacement)
# ═══════════════════════════════════════════════════════════════════════

if is_installed bat || is_installed batcat; then
    log_success "bat/batcat bereits installiert"
else
    log_info "Installiere bat..."
    sudo apt install -y bat
    log_success "bat installiert"
fi

# ═══════════════════════════════════════════════════════════════════════
# 5. LSD (modern ls)
# ═══════════════════════════════════════════════════════════════════════

if is_installed lsd; then
    log_success "lsd bereits installiert"
else
    log_info "Installiere lsd..."
    sudo apt install -y lsd
    log_success "lsd installiert"
fi

# ═══════════════════════════════════════════════════════════════════════
# 6. ZELLIJ (Terminal Multiplexer)
# ═══════════════════════════════════════════════════════════════════════

if is_installed zellij; then
    log_success "zellij bereits installiert"
else
    log_info "Installiere zellij (via cargo)..."
    if ! is_installed cargo; then
        log_warning "cargo nicht gefunden — installiere rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        # shellcheck disable=SC1091
        source "$HOME/.cargo/env"
    fi
    cargo install zellij
    log_success "zellij installiert"
fi

# ═══════════════════════════════════════════════════════════════════════
# 7. ZED (Code Editor)
# ═══════════════════════════════════════════════════════════════════════

if is_installed zed; then
    log_success "zed bereits installiert"
else
    log_info "Installiere zed..."
    curl -f https://zed.dev/install.sh | sh
    log_success "zed installiert"
fi

# ═══════════════════════════════════════════════════════════════════════
# 8. STARSHIP (Prompt Customizer)
# ═══════════════════════════════════════════════════════════════════════

if is_installed starship; then
    log_success "starship bereits installiert"
else
    log_info "Installiere starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    log_success "starship installiert"
fi

# ═══════════════════════════════════════════════════════════════════════
# 9. KITTY (Terminal Emulator)
# ═══════════════════════════════════════════════════════════════════════

if is_installed kitty; then
    log_success "kitty bereits installiert"
else
    log_info "Installiere kitty..."
    sudo apt install -y kitty
    log_success "kitty installiert"
fi

# ═══════════════════════════════════════════════════════════════════════
# 10. NERD FONTS (Fira Code + JetBrains Mono)
# ═══════════════════════════════════════════════════════════════════════

log_info "Installiere Nerd Fonts (Fira Code + JetBrains Mono)..."

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Fira Code Nerd Font
if [ ! -f "$FONT_DIR/FiraCodeNerdFont-Regular.ttf" ]; then
    log_info "Download Fira Code Nerd Font..."
    cd /tmp
    curl -sL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip -o FiraCode.zip
    unzip -q FiraCode.zip -d FiraCode_temp
    cp FiraCode_temp/*.ttf "$FONT_DIR/" 2>/dev/null || true
    rm -rf FiraCode.zip FiraCode_temp
    log_success "Fira Code Nerd Font installiert"
else
    log_success "Fira Code Nerd Font bereits installiert"
fi

# JetBrains Mono Nerd Font
if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    log_info "Download JetBrains Mono Nerd Font..."
    cd /tmp
    curl -sL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip -o JetBrainsMono.zip
    unzip -q JetBrainsMono.zip -d JetBrainsMono_temp
    cp JetBrainsMono_temp/*.ttf "$FONT_DIR/" 2>/dev/null || true
    rm -rf JetBrainsMono.zip JetBrainsMono_temp
    log_success "JetBrains Mono Nerd Font installiert"
else
    log_success "JetBrains Mono Nerd Font bereits installiert"
fi

# Update Font Cache
log_info "Update Font-Cache..."
fc-cache -fv "$FONT_DIR" > /dev/null 2>&1
log_success "Font-Cache aktualisiert"

# ═══════════════════════════════════════════════════════════════════════
# 11. KITTY CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════

KITTY_CONFIG_DIR="$HOME/.config/kitty"
KITTY_CONFIG_FILE="$KITTY_CONFIG_DIR/kitty.conf"

mkdir -p "$KITTY_CONFIG_DIR"

log_info "Erstelle/Aktualisiere kitty.conf..."

cat > "$KITTY_CONFIG_FILE" << 'EOF'
# ── Font ──────────────────────────────────────────────────────────────
font_family      FiraCode Nerd Font
bold_font        FiraCode Nerd Font Bold
italic_font      auto
bold_italic_font auto
font_size        13.0

symbol_map U+E000-U+F8FF JetBrainsMono Nerd Font

# Systembell
enable_audio_bell no

# Ligatures an
font_features FiraCodeNF-Reg +liga +calt

# ── Cursor ────────────────────────────────────────────────────────────
cursor_shape     block
cursor_blink_interval 0
cursor           #7aa2f7

# ── Farben (Vulkan/Space) ─────────────────────────────────────────────
background            #0d0e14
foreground            #c0caf5
selection_background  #28344a
selection_foreground  #c0caf5

# Schwarztöne
color0  #15161e
color8  #414868

# Rottöne
color1  #f7768e
color9  #f7768e

# Grüntöne
color2  #9ece6a
color10 #9ece6a

# Gelbtöne
color3  #e0af68
color11 #e0af68

# Blautöne
color4  #7aa2f7
color12 #7aa2f7

# Magenta/Lila
color5  #bb9af7
color13 #bb9af7

# Cyan
color6  #7dcfff
color14 #7dcfff

# Weiß
color7  #a9b1d6
color15 #c0caf5

# ── Transparenz & Blur ────────────────────────────────────────────────
background_opacity 0.80

# ── Fenster ───────────────────────────────────────────────────────────
window_padding_width 8

# ── Performance ───────────────────────────────────────────────────────
sync_to_monitor yes
EOF

log_success "kitty.conf erstellt unter $KITTY_CONFIG_FILE"

# ═══════════════════════════════════════════════════════════════════════
# FINISH
# ═══════════════════════════════════════════════════════════════════════

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║           ✓ Installation erfolgreich abgeschlossen!        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

log_info "Nächste Schritte:"
echo "  1. Starte deine Shell neu: exec zsh"
echo "  2. Wende deine Chezmoi Dotfiles an: chezmoi apply"
echo "  3. Konfiguriere Starship: ~/.config/starship.toml"
echo ""

