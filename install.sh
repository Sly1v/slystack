#!/usr/bin/env bash
# ==============================================================================
#  slystack - Complete Automated Setup & Installer for CachyOS / Arch Linux
# ==============================================================================

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_DIR="${CONFIG_DIR}/backup_slystack_$(date +%Y%m%d_%H%M%S)"

AUTO_MODE=false
for arg in "$@"; do
    if [[ "$arg" == "--auto" || "$arg" == "-y" || "$arg" == "--all" ]]; then
        AUTO_MODE=true
    fi
done

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BLUE}${BOLD}"
echo "  ____  _             ____  _             _    "
echo " / ___|| |_   _ ___  / ___|| |_ __ _  ___| | __"
echo " \___ \| | | | / __| \___ \| __/ _\` |/ __| |/ /"
echo "  ___) | | |_| \__ \  ___) | || (_| | (__|   < "
echo " |____/|_|\__, |___/ |____/ \__\__,_|\___|_|\_\\"
echo "          |___/                                "
echo -e "${NC}"
echo -e "${YELLOW}Hardware Profile: Dell Laptop (Intel Iris Xe + NVIDIA MX350 + 1080p eDP-1)${NC}\n"

# ------------------------------------------------------------------------------
# 1. Package Installation (Full Automation)
# ------------------------------------------------------------------------------
echo -e "${BLUE}==>${NC} ${BOLD}Step 1: Installing system packages & dependencies...${NC}"

PACMAN_DEPS=(
    hyprland
    kitty
    zsh
    waybar
    thunar
    ttf-jetbrains-mono-nerd
    grim
    slurp
    wl-clipboard
    brightnessctl
    playerctl
    pamixer
    intel-media-driver
    libva-intel-driver
    nvidia-prime
    libnotify
    qt5-wayland
    qt6-wayland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
    gnome-keyring
    hyprpaper
)

DO_INSTALL="n"
if [ "$AUTO_MODE" = true ]; then
    DO_INSTALL="y"
else
    read -rp "Install missing system packages automatically via pacman & paru? [Y/n]: " reply
    DO_INSTALL="${reply:-y}"
fi

if [[ "$DO_INSTALL" =~ ^[Yy]$ ]]; then
    echo -e "Installing official packages via pacman..."
    sudo pacman -S --needed --noconfirm "${PACMAN_DEPS[@]}"

    # Install AUR helper (paru) if not present
    AUR_HELPER=""
    if command -v paru &>/dev/null; then
        AUR_HELPER="paru"
    elif command -v yay &>/dev/null; then
        AUR_HELPER="yay"
    fi

    if [ -n "$AUR_HELPER" ]; then
        echo -e "Installing Noctalia shell via ${AUR_HELPER}..."
        "$AUR_HELPER" -S --needed --noconfirm noctalia-bin || true
    else
        echo -e "${YELLOW}Notice: Neither paru nor yay found. Install noctalia-bin manually.${NC}"
    fi
else
    echo -e "${YELLOW}Skipping package installation. Proceeding with configuration deployment.${NC}"
fi

# ------------------------------------------------------------------------------
# 2. Backup Existing Configs
# ------------------------------------------------------------------------------
echo -e "\n${BLUE}==>${NC} ${BOLD}Step 2: Backing up existing configurations...${NC}"
mkdir -p "${BACKUP_DIR}"

for app in hypr kitty noctalia waybar backgrounds; do
    if [ -d "${CONFIG_DIR}/${app}" ] || [ -f "${CONFIG_DIR}/${app}" ]; then
        echo -e "  Backing up ${CONFIG_DIR}/${app} -> ${BACKUP_DIR}/${app}"
        cp -rL "${CONFIG_DIR}/${app}" "${BACKUP_DIR}/" || true
        rm -rf "${CONFIG_DIR}/${app}"
    fi
done
echo -e "${GREEN}✓ Backup completed at: ${BACKUP_DIR}${NC}"

# ------------------------------------------------------------------------------
# 3. Deploy Hardware-Tailored Dotfiles
# ------------------------------------------------------------------------------
echo -e "\n${BLUE}==>${NC} ${BOLD}Step 3: Deploying slystack configs...${NC}"
mkdir -p "${CONFIG_DIR}/backgrounds"

cp -r "${DOTFILES_DIR}/hypr" "${CONFIG_DIR}/"
cp -r "${DOTFILES_DIR}/kitty" "${CONFIG_DIR}/"
cp -r "${DOTFILES_DIR}/noctalia" "${CONFIG_DIR}/"
cp -r "${DOTFILES_DIR}/waybar" "${CONFIG_DIR}/"
cp "${DOTFILES_DIR}/backgrounds/wallpaper.png" "${CONFIG_DIR}/backgrounds/wallpaper.png"

echo -e "${GREEN}✓ Hyprland, Noctalia, Kitty, Waybar & Wallpapers deployed!${NC}"

# ------------------------------------------------------------------------------
# 4. Zsh Shell Integration
# ------------------------------------------------------------------------------
echo -e "\n${BLUE}==>${NC} ${BOLD}Step 4: Setting up Zsh environment...${NC}"
ZSHRC="$HOME/.zshrc"
touch "${ZSHRC}"

if ! grep -q "slystack configuration" "${ZSHRC}"; then
    cat << 'EOF' >> "${ZSHRC}"

# >>> slystack configuration >>>
[[ -f "$HOME/.config/slystack-zsh/cachyos.zsh" ]] && source "$HOME/.config/slystack-zsh/cachyos.zsh"
[[ -f "$HOME/.config/slystack-zsh/exports.zsh" ]] && source "$HOME/.config/slystack-zsh/exports.zsh"
[[ -f "$HOME/.config/slystack-zsh/personal.zsh" ]] && source "$HOME/.config/slystack-zsh/personal.zsh"
# <<< slystack configuration <<<
EOF
fi

mkdir -p "$HOME/.config/slystack-zsh"
cp -r "${DOTFILES_DIR}/zsh/"* "$HOME/.config/slystack-zsh/"
echo -e "${GREEN}✓ Zsh integration enabled in ${ZSHRC}${NC}"

# ------------------------------------------------------------------------------
# 5. Font Cache & Verification
# ------------------------------------------------------------------------------
if command -v fc-cache &>/dev/null; then
    echo -e "\n${BLUE}==>${NC} Refreshing font cache..."
    fc-cache -f >/dev/null 2>&1 || true
fi

echo -e "\n${GREEN}${BOLD}======================================================${NC}"
echo -e "${GREEN}${BOLD}✓ slystack is fully set up and ready to run!${NC}"
echo -e "${GREEN}${BOLD}======================================================${NC}"
echo -e "To reload Hyprland now: ${BOLD}hyprctl reload${NC}"
echo -e "To start a fresh session: log out and select Hyprland."
