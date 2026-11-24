#!/usr/bin/env bash
# ==============================================================================
#  slystack - Complete Automated Setup & Installer for CachyOS / Arch Linux
# ==============================================================================

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_DIR="${CONFIG_DIR}/backup_slystack_$(date +%Y%m%d_%H%M%S)"
DEFAULT_OBSIDIAN_VAULT="${HOME}/Documents/Obsidian"

AUTO_MODE=false
OBSIDIAN_VAULT="${OBSIDIAN_VAULT:-}"

usage() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  --auto, -y, --all             Run non-interactively (installs packages and uses default vault if unset)
  --obsidian-vault <path>       Path to your Obsidian vault for Noctalia CSS snippet sync
  -h, --help                    Show this help message and exit

Environment variables:
  OBSIDIAN_VAULT                Default Obsidian vault path (overridden by --obsidian-vault)
EOF
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --auto|-y|--all)
            AUTO_MODE=true
            shift
            ;;
        --obsidian-vault)
            if [[ $# -lt 2 || -z "$2" ]]; then
                echo "Error: --obsidian-vault requires a non-empty path argument." >&2
                exit 1
            fi
            OBSIDIAN_VAULT="$2"
            shift 2
            ;;
        --obsidian-vault=*)
            OBSIDIAN_VAULT="${1#*=}"
            if [[ -z "$OBSIDIAN_VAULT" ]]; then
                echo "Error: --obsidian-vault requires a non-empty path argument." >&2
                exit 1
            fi
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Error: Unknown option: $1" >&2
            usage >&2
            exit 1
            ;;
    esac
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
    # Core Desktop & Wayland
    hyprland
    noctalia
    kitty
    zsh
    waybar
    thunar
    hyprpaper
    ttf-jetbrains-mono-nerd
    qt5-wayland
    qt6-wayland
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
    gnome-keyring

    # Audio, Brightness, Screenshots & Waybar Utils
    grim
    slurp
    hyprshot
    wl-clipboard
    brightnessctl
    playerctl
    pamixer
    pipewire
    bc
    jq
    libnotify

    # Hybrid Graphics (Intel Iris Xe + NVIDIA PRIME)
    intel-media-driver
    libva-intel-driver
    nvidia-prime

    # Productivity, CLI & Media Extras
    obsidian
    zed
    neovim
    bat
    expac
    ffmpeg
    nvtop
)

AUR_DEPS=(
    zen-browser-bin
    wl-screenrec
    claude-code
    herdr-bin
)

DO_INSTALL="n"
if [ "$AUTO_MODE" = true ]; then
    DO_INSTALL="y"
else
    read -rp "Install missing system packages automatically via pacman & AUR? [Y/n]: " reply
    DO_INSTALL="${reply:-y}"
fi

if [[ "$DO_INSTALL" =~ ^[Yy]$ ]]; then
    echo -e "Installing official packages via pacman..."
    sudo pacman -S --needed --noconfirm "${PACMAN_DEPS[@]}"

    # Detect AUR helper (paru or yay)
    AUR_HELPER=""
    if command -v paru &>/dev/null; then
        AUR_HELPER="paru"
    elif command -v yay &>/dev/null; then
        AUR_HELPER="yay"
    fi

    if [ -n "$AUR_HELPER" ]; then
        echo -e "Installing AUR packages via ${AUR_HELPER}..."
        for pkg in "${AUR_DEPS[@]}"; do
            "$AUR_HELPER" -S --needed --noconfirm "$pkg" || \
                echo -e "${YELLOW}Warning: Failed to install AUR package '${pkg}'. Install it manually later.${NC}"
        done
    else
        echo -e "${YELLOW}Notice: Neither paru nor yay found. Install AUR packages manually:${NC}"
        echo -e "  ${AUR_DEPS[*]}"
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
# 3. Deploy Hardware-Tailored Dotfiles & Configure Obsidian Sync
# ------------------------------------------------------------------------------
echo -e "\n${BLUE}==>${NC} ${BOLD}Step 3: Deploying slystack configs...${NC}"
mkdir -p "${CONFIG_DIR}/backgrounds"

cp -r "${DOTFILES_DIR}/hypr" "${CONFIG_DIR}/"
cp -r "${DOTFILES_DIR}/kitty" "${CONFIG_DIR}/"
cp -r "${DOTFILES_DIR}/noctalia" "${CONFIG_DIR}/"
cp -r "${DOTFILES_DIR}/waybar" "${CONFIG_DIR}/"
cp "${DOTFILES_DIR}/backgrounds/wallpaper.png" "${CONFIG_DIR}/backgrounds/wallpaper.png"

sed -i "s|~/.config/backgrounds|${CONFIG_DIR}/backgrounds|g" "${CONFIG_DIR}/noctalia/config.toml"

echo -e "${GREEN}✓ Hyprland, Noctalia, Kitty, Waybar & Wallpapers deployed!${NC}"

if [[ -z "${OBSIDIAN_VAULT}" ]]; then
    if [ "$AUTO_MODE" = true ]; then
        OBSIDIAN_VAULT="${DEFAULT_OBSIDIAN_VAULT}"
    else
        read -rp "Obsidian vault path for Noctalia theme sync [${DEFAULT_OBSIDIAN_VAULT}]: " vault_reply
        OBSIDIAN_VAULT="${vault_reply:-$DEFAULT_OBSIDIAN_VAULT}"
    fi
fi

OBSIDIAN_VAULT="${OBSIDIAN_VAULT/#\~/$HOME}"
if [[ "${OBSIDIAN_VAULT}" != "/" ]]; then
    OBSIDIAN_VAULT="${OBSIDIAN_VAULT%/}"
fi

cat << EOF > "${CONFIG_DIR}/noctalia/obsidian.toml"
# Noctalia dynamic theme snippet for Obsidian
[theme.templates.user.obsidian_extra]
input_path = "${CONFIG_DIR}/noctalia/Obsidian/obsidian.css"
output_path = "${OBSIDIAN_VAULT}/.obsidian/snippets/noctalia.css"
EOF

if [[ -d "${OBSIDIAN_VAULT}" ]]; then
    mkdir -p "${OBSIDIAN_VAULT}/.obsidian/snippets"
    echo -e "${GREEN}✓ Noctalia Obsidian snippet target configured: ${OBSIDIAN_VAULT}/.obsidian/snippets/noctalia.css${NC}"
else
    echo -e "${YELLOW}Notice: Obsidian vault '${OBSIDIAN_VAULT}' does not exist yet.${NC}"
    echo -e "${YELLOW}  Configured ${CONFIG_DIR}/noctalia/obsidian.toml -> ${OBSIDIAN_VAULT}/.obsidian/snippets/noctalia.css${NC}"
    echo -e "${YELLOW}  Create the vault, edit ~/.config/noctalia/obsidian.toml, or re-run with --obsidian-vault <path>.${NC}"
fi

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
