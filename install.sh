#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# --- Packages ---
PACMAN_PACKAGES=(
    zsh
    hyprland
    kitty
    waybar
    dunst
    btop
    tmux
    neovim
    starship
    git
)

# Flag: these are AUR packages (not in official repos)
AUR_PACKAGES=(
    lazygit
    yay  # AUR helper itself, must be installed first manually — see bootstrap below
)

# Configs to symlink: "repo-subdir -> target in ~/.config"
# Add new tools here as a new "source:target" entry
CONFIG_LINKS=(
    "hypr:hypr"
    "kitty:kitty"
    "waybar:waybar"
    "dunst:dunst"
    "btop:btop"
    "tmux:tmux"
    "lazygit:lazygit"
    "nvim:nvim"
)

# --- Helpers ---
info()    { echo "[info] $*"; }
success() { echo "[ok]   $*"; }
warn()    { echo "[warn] $*"; }
die()     { echo "[err]  $*" >&2; exit 1; }

backup_and_link() {
    local src="$1"
    local dst="$2"

    if [[ -e "$dst" || -L "$dst" ]]; then
        mkdir -p "$BACKUP_DIR"
        local name
        name="$(basename "$dst")"
        mv "$dst" "$BACKUP_DIR/$name"
        warn "Backed up existing $dst to $BACKUP_DIR/$name"
    fi

    ln -s "$src" "$dst"
    success "Linked $src -> $dst"
}

# --- Phase 1: Bootstrap yay if missing ---
bootstrap_yay() {
    if command -v yay &>/dev/null; then
        info "yay already installed, skipping"
        return
    fi

    info "Installing yay (AUR helper)..."
    # yay requires base-devel and git as prerequisites
    sudo pacman -S --needed --noconfirm base-devel git
    local tmp
    tmp="$(mktemp -d)"
    git clone https://aur.archlinux.org/yay.git "$tmp/yay"
    (cd "$tmp/yay" && makepkg -si --noconfirm)
    rm -rf "$tmp"
    success "yay installed"
}

# --- Phase 2: Install packages ---
install_packages() {
    info "Installing pacman packages..."
    sudo pacman -S --needed --noconfirm "${PACMAN_PACKAGES[@]}"

    info "Installing AUR packages..."
    # Remove yay from AUR list since it's handled by bootstrap_yay
    local aur_to_install=("${AUR_PACKAGES[@]/yay}")
    yay -S --needed --noconfirm "${aur_to_install[@]}"
}

# --- Phase 3: Symlink configs ---
link_configs() {
    info "Linking configs to ~/.config..."
    mkdir -p "$HOME/.config"

    for entry in "${CONFIG_LINKS[@]}"; do
        local src="${entry%%:*}"   # part before ':'
        local dst="${entry##*:}"   # part after ':'
        backup_and_link "$DOTFILES_DIR/$src" "$HOME/.config/$dst"
    done

    # starship.toml lives directly in ~/.config, not a subdir
    backup_and_link "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
}

# --- Phase 4: Link scripts to PATH ---
link_scripts() {
    if [[ ! -d "$DOTFILES_DIR/scripts" ]]; then
        info "No scripts/ dir found, skipping"
        return
    fi

    info "Linking scripts to ~/.local/bin..."
    mkdir -p "$HOME/.local/bin"

    for script in "$DOTFILES_DIR/scripts/"*; do
        local name
        name="$(basename "$script")"
        backup_and_link "$script" "$HOME/.local/bin/$name"
        chmod +x "$script"
    done
}

# --- Phase 5: Set zsh as default shell ---
set_shell() {
    if [[ "$SHELL" == "$(which zsh)" ]]; then
        info "zsh already default shell, skipping"
        return
    fi

    info "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
    success "Default shell set to zsh — takes effect on next login"
}

# --- Main ---
main() {
    info "Starting dotfiles install from $DOTFILES_DIR"
    info "Backups will go to $BACKUP_DIR if needed"
    echo

    bootstrap_yay
    install_packages
    link_configs
    link_scripts
    set_shell

    echo
    success "Done. Log out and back in for shell change to take effect."
    [[ -d "$BACKUP_DIR" ]] && info "Backups saved to $BACKUP_DIR"
}

main
