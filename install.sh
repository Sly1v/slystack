#!/usr/bin/env bash
# ==============================================================================
#  slystack - Automated Hardware-Optimized Setup Script for CachyOS / Arch Linux
# ==============================================================================

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_DIR="${CONFIG_DIR}/backup_slystack_$(date +%Y%m%d_%H%M%S)"

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
echo -e "${YELLOW}Hardware Profile: Dell Laptop (Intel i7-1165G7 + Iris Xe + NVIDIA MX350 + 1080p eDP-1)${NC}\n"

# 1. Backup existing configurations
echo -e "${BLUE}==>${NC} ${BOLD}Step 1: Backing up existing configurations...${NC}"
mkdir -p "${BACKUP_DIR}"

for app in hypr kitty noctalia waybar backgrounds; do
    if [ -d "${CONFIG_DIR}/${app}" ] || [ -f "${CONFIG_DIR}/${app}" ]; then
        echo -e "  Backing up ${CONFIG_DIR}/${app} -> ${BACKUP_DIR}/${app}"
        cp -rL "${CONFIG_DIR}/${app}" "${BACKUP_DIR}/" || true
        rm -rf "${CONFIG_DIR}/${app}"
    fi
done
echo -e "${GREEN}✓ Backup completed at: ${BACKUP_DIR}${NC}\n"

# 2. Deploy configs
echo -e "${BLUE}==>${NC} ${BOLD}Step 2: Deploying slystack configs...${NC}"
mkdir -p "${CONFIG_DIR}/backgrounds"

cp -r "${DOTFILES_DIR}/hypr" "${CONFIG_DIR}/"
cp -r "${DOTFILES_DIR}/kitty" "${CONFIG_DIR}/"
cp -r "${DOTFILES_DIR}/noctalia" "${CONFIG_DIR}/"
cp -r "${DOTFILES_DIR}/waybar" "${CONFIG_DIR}/"
cp "${DOTFILES_DIR}/backgrounds/wallpaper.png" "${CONFIG_DIR}/backgrounds/wallpaper.png"

echo -e "${GREEN}✓ Configs deployed to ${CONFIG_DIR}${NC}\n"

# 3. Setup Zsh integration
echo -e "${BLUE}==>${NC} ${BOLD}Step 3: Setting up Zsh shell configs...${NC}"
ZSHRC="$HOME/.zshrc"
touch "${ZSHRC}"

if ! grep -q "slystack/zsh/cachyos.zsh" "${ZSHRC}"; then
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
echo -e "${GREEN}✓ Zsh integration enabled in ${ZSHRC}${NC}\n"

# 4. Check dependencies
echo -e "${BLUE}==>${NC} ${BOLD}Step 4: Checking installed packages...${NC}"
REQUIRED_PKGS=(hyprland kitty zsh waybar thunar ttf-jetbrains-mono-nerd grim slurp wl-clipboard)
MISSING_PKGS=()

for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        MISSING_PKGS+=("$pkg")
    fi
done

if [ ${#MISSING_PKGS[@]} -gt 0 ]; then
    echo -e "${YELLOW}Notice: The following packages are not yet installed: ${MISSING_PKGS[*]}${NC}"
    echo -e "You can install them via: ${BOLD}sudo pacman -S --needed ${MISSING_PKGS[*]}${NC}"
else
    echo -e "${GREEN}✓ All core Arch packages are installed!${NC}"
fi

if ! command -v noctalia &>/dev/null; then
    echo -e "${YELLOW}Notice: Noctalia desktop shell is not found in PATH.${NC}"
    echo -e "Install it from AUR via paru: ${BOLD}paru -S noctalia-bin${NC}"
fi

echo -e "\n${GREEN}${BOLD}Setup completed successfully!${NC}"
echo -e "To reload Hyprland immediately, run: ${BOLD}hyprctl reload${NC}"
echo -e "To launch a new session, log out and choose Hyprland from your display manager."
