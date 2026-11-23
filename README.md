# slystack 🚀

Hardware-optimized, high-performance dotfiles for **CachyOS / Arch Linux**, featuring **Hyprland (Lua)**, **Noctalia desktop shell**, **Kitty**, and **Waybar**.

Tailored specifically to run safely, smoothly, and tear-free on hybrid Intel + NVIDIA laptops.

---

## 💻 Hardware Profile

| Component | Hardware Specification | Configuration |
| :--- | :--- | :--- |
| **Device** | Dell Laptop | Multi-touchpad with natural scrolling & 3-finger gestures |
| **CPU** | 11th Gen Intel Core i7-1165G7 @ 2.80GHz | BORE / CachyOS scheduler optimized |
| **Integrated GPU** | Intel Iris Xe Graphics (TigerLake-LP GT2) | Primary Wayland compositor renderer (`LIBVA_DRIVER_NAME=iHD`) |
| **Dedicated GPU** | NVIDIA GeForce MX350 (Pascal GP107M) | On-demand PRIME render offload via `nv <command>` or `prime-run` |
| **Display** | 1920x1080@60Hz (`eDP-1`) | 1.5x fractional scale + responsive window sizing |
| **Keyboard** | English (US) + Arabic (`us, ara`) | Layout switch toggle via `Alt + Shift` |

---

## 🛠️ Stack Components

* **Window Manager:** [Hyprland](https://hypr.land) configured in modern **Lua** (`hyprland.lua`).
* **Desktop Shell:** [Noctalia](https://github.com/noctalia-dev/noctalia) (App Launcher, Control Center, Notifications, Lockscreen, dynamic Material/Kanagawa theme engine).
* **Terminal Emulator:** [Kitty](https://sw.kovidgoyal.net/kitty/) with blurred transparency and Noctalia theme integration.
* **Status Bar:** Waybar + Noctalia integrated bar.
* **Shell:** Zsh with CachyOS performance aliases, system mirror updater, and Intel Iris Xe VAAPI hardware decode.

---

## 📦 Quick Installation

### 1. Install Required Packages
On CachyOS / Arch Linux:

```bash
sudo pacman -S --needed hyprland kitty zsh waybar thunar ttf-jetbrains-mono-nerd grim slurp wl-clipboard
paru -S --needed noctalia-bin
```

*(Optional apps configured in keybindings: `zen-browser-bin`, `obsidian`, `zed`)*

### 2. Clone & Run the Installer
```bash
git clone https://github.com/<your-username>/slystack.git ~/slystack
cd ~/slystack
chmod +x install.sh
./install.sh
```

The installer will:
1. Automatically backup your existing `~/.config/{hypr,kitty,noctalia,waybar}` configurations with a timestamp.
2. Deploy the hardware-tailored configuration files.
3. Set up the bundled high-resolution wallpaper.
4. Hook the shell configurations into `~/.zshrc`.

---

## ⌨️ Essential Keybindings

| Keybinding | Action |
| :--- | :--- |
| `Super + Return` | Launch Terminal (`kitty`) |
| `Super + Space` | Noctalia Application Launcher |
| `Super + B` | Web Browser (`zen-browser` / `firefox`) |
| `Super + E` | File Manager (`thunar`) |
| `Super + O` | Note Taking (`obsidian`) |
| `Super + Q` | Close active window |
| `Super + S` | Toggle Control Center / Quick Settings |
| `Super + M` | Power & Session Menu |
| `Super + V` | Toggle floating mode |
| `Super + Shift + V` | Clipboard history |
| `Alt + Tab` | Window Switcher |
| `Alt + Shift` | Toggle Keyboard Layout (English ⇄ Arabic) |
| `Super + Shift + Space` | Screenshot area to clipboard |
| `Super + Shift + =` | Toggle display scale to 1.5x (comfortable) |
| `Super + Shift + -` | Toggle display scale to 1.25x (compact) |
| `3-finger swipe` | Switch workspaces |

---

## 🎮 Hybrid Graphics (NVIDIA MX350 Offload)

The desktop and everyday applications run on the efficient **Intel Iris Xe Graphics** to maximize battery life and maintain rock-solid Wayland stability.

To run games, 3D workloads, or GPU-heavy apps on the dedicated **NVIDIA GeForce MX350**, simply prefix the command with `nv` or `prime-run`:

```bash
nv steam
# or
prime-run blender
```

---

## 📄 License
MIT
