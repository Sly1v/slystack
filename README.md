# slystack 🚀

Hardware-optimized, high-performance dotfiles for **CachyOS / Arch Linux**, featuring **Hyprland (Lua)**, **Noctalia desktop shell**, **Kitty**, and **Waybar**.

Tailored specifically to run safely, smoothly, and tear-free on hybrid Intel + NVIDIA laptops.

---

## ⚡ 1-Command Instant Setup (Zero-Touch)

On a fresh CachyOS / Arch install, simply open your terminal and paste:

```bash
git clone https://github.com/Sly1v/slystack.git ~/slystack && cd ~/slystack && ./install.sh --auto
```

### What this single command does automatically:
1. **Installs all dependencies:** Installs Hyprland, Kitty, Waybar, Zsh, Noctalia shell, JetBrains Nerd Fonts, audio/brightness tools, and video drivers via `pacman` and `paru`.
2. **Backs up existing configs:** Preserves any current configs into a timestamped `~/.config/backup_slystack_*` directory.
3. **Deploys hardware configurations:** Places your optimized Hyprland Lua, Noctalia, Kitty, and Waybar configs.
4. **Sets up wallpaper & fonts:** Installs the bundled wallpaper and refreshes font caches.
5. **Configures hybrid GPU & shell:** Configures Intel Iris Xe VAAPI hardware decode and sets up `nv <command>` for NVIDIA MX350 offload in Zsh.

Once the command finishes, log out and select Hyprland (or run `hyprctl reload`), and your desktop is fully ready!

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
