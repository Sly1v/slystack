# slystack 🚀

Hardware-optimized, high-performance dotfiles for **CachyOS / Arch Linux**, featuring **Hyprland (Lua)**, **Noctalia desktop shell**, **Kitty**, **Waybar**, and **Zsh**.

Tailored for a **Dell laptop** (`1080p eDP-1`, hybrid Intel Iris Xe + NVIDIA MX350, touchpad), with an automated `install.sh` and configurable Obsidian vault sync.

---

## ⚡ 1-Command Instant Setup (Zero-Touch)

On a fresh CachyOS / Arch install, open your terminal and paste:

```bash
git clone https://github.com/Sly1v/slystack.git ~/slystack && cd ~/slystack && ./install.sh --auto
```

To point Noctalia's dynamic Obsidian CSS snippet directly to your vault during setup:

```bash
./install.sh --auto --obsidian-vault "/path/to/your/vault"
# or via environment variable:
OBSIDIAN_VAULT="/path/to/your/vault" ./install.sh --auto
```

### What this command does automatically:
1. **Installs official & extra dependencies:** Installs Hyprland, `noctalia` (Arch `extra`), Kitty, Waybar, Zsh, Thunar, Hyprpaper, JetBrainsMono Nerd Font, audio/brightness/screenshot tools (`grim`, `slurp`, `hyprshot`, `pipewire`), Intel VAAPI + NVIDIA PRIME drivers, and CLI/productivity extras (`obsidian`, `zed`, `neovim`, `bat`, `expac`, `ffmpeg`, `nvtop`, `bc`, `jq`) via `pacman`.
2. **Installs AUR extras:** Installs `zen-browser-bin`, `wl-screenrec`, `claude-code`, and `herdr-bin` via `paru` or `yay` (if available).
3. **Backs up existing configs:** Preserves any existing configs into a timestamped `~/.config/backup_slystack_*` directory.
4. **Deploys hardware configurations & Obsidian sync:** Installs Hyprland Lua, Noctalia, Kitty, Waybar, wallpaper, resolves wallpaper paths in `~/.config/noctalia/config.toml`, and writes `~/.config/noctalia/obsidian.toml` for your Obsidian vault (defaults to `~/Documents/Obsidian` in `--auto` mode, or prompts interactively).
5. **Configures hybrid GPU & Zsh:** Enables Intel Iris Xe VAAPI hardware decode, integrates Zsh scripts in `~/.zshrc`, sets up `nv <command>` for NVIDIA MX350 offload, and refreshes font caches.

Once finished, log out and select Hyprland (or run `hyprctl reload`), and your desktop is ready!

---

## 💻 Hardware Profile

| Component | Hardware Specification | Configuration |
| :--- | :--- | :--- |
| **Device** | Dell Laptop | Multi-touchpad (`natural_scroll = false`, 3-finger swipe) |
| **CPU** | 11th Gen Intel Core i7-1165G7 @ 2.80GHz | BORE / CachyOS scheduler optimized |
| **Integrated GPU** | Intel Iris Xe Graphics (TigerLake-LP GT2) | Primary Wayland compositor renderer (`LIBVA_DRIVER_NAME=iHD`) |
| **Dedicated GPU** | NVIDIA GeForce MX350 (Pascal GP107M) | On-demand PRIME render offload via `nv <command>` or `prime-run` |
| **Display** | 1920x1080@60Hz (`eDP-1`) | 1.5x fractional scale + responsive window sizing |
| **Keyboard** | English (US) + Arabic (`us, ara`) | Layout switch toggle via `Left Shift + Right Shift` |

---

## 🛠️ Stack Components

* **Window Manager:** [Hyprland](https://hypr.land) configured in modern **Lua** (`hypr/hyprland.lua` + `hypr/config/*.lua`).
* **Desktop Shell:** [Noctalia](https://github.com/noctalia-dev/noctalia) (App Launcher, Control Center, Notifications, Lockscreen, OSD, dynamic Material/Kanagawa theme engine).
* **Terminal Emulator:** [Kitty](https://sw.kovidgoyal.net/kitty/) with blurred transparency and Noctalia theme integration.
* **Status Bar:** Waybar (with custom live upload/download script) + Noctalia integrated bar.
* **Shell:** Zsh with CachyOS performance aliases, system mirror updater, AV1 recording/transcoding helpers, and Intel Iris Xe VAAPI hardware decode.

---

## 📦 Included Tools & Extras

All tools referenced by Hyprland keybindings, Waybar scripts, and Zsh helpers are installed automatically by `install.sh`:

| Tool / Package | Source | Used For |
| :--- | :--- | :--- |
| `noctalia` | Arch `extra` | Desktop shell, launcher, bar, lockscreen, notifications, theming |
| `obsidian` | Arch `extra` | Note taking (`Super + O`) & Noctalia dynamic CSS snippet sync |
| `zed` | Arch `extra` | Default `$EDITOR` (`zed`) with Noctalia theme template |
| `hyprshot` | Arch `extra` | Active window screenshot to clipboard (`Super + Shift + Ctrl + Space`) |
| `neovim` | Arch `extra` | Terminal editor (`vi` alias) with Noctalia theme template |
| `bat` | Arch `extra` | Syntax-highlighted man pages (`MANPAGER`) |
| `expac` | Arch `extra` | Package inspection aliases (`big`, `rip`) |
| `ffmpeg` | Arch `extra` | Intel VAAPI AV1 transcoding helpers (`proxy`, `decode`) |
| `nvtop` | Arch `extra` | GPU monitoring (`gputop` alias) |
| `pipewire` | Arch `extra` | Audio recording via `pw-record` (`record-audio`) |
| `bc`, `jq` | Arch `extra` | Waybar live network speed script (`waybar/scripts/network.sh`) |
| `zen-browser-bin` | AUR | Primary browser (`Super + B`, falls back to Firefox / Chromium) |
| `wl-screenrec` | AUR | Hardware-accelerated AV1 Wayland screen recording (`record`) |
| `claude-code` | AUR | Claude CLI aliases (`cc`, `ccd`) |
| `herdr-bin` | AUR | Persistent agent/terminal session manager (`shell`, `code`) |

---

## 📝 Obsidian Dynamic Theme Sync

`noctalia/obsidian.toml` configures Noctalia's user template engine to render `noctalia/Obsidian/obsidian.css` directly into your vault's `.obsidian/snippets/noctalia.css` whenever your Noctalia theme changes.

* **During installation:** Pass `--obsidian-vault "/path/to/your/vault"` (or set `OBSIDIAN_VAULT`), or enter the path when prompted interactively. Without `--obsidian-vault`, `--auto` defaults to `~/Documents/Obsidian`.
* **After installation:** You can change `output_path` anytime in `~/.config/noctalia/obsidian.toml`.
* **Enable in Obsidian:** Open Obsidian → **Settings → Appearance → CSS snippets** and toggle **`noctalia`** on.

---

## ⌨️ Essential Keybindings

| Keybinding | Action |
| :--- | :--- |
| `Super + Return` | Launch Terminal (`kitty`) |
| `Super + Space` | Noctalia Application Launcher |
| `Super + B` | Web Browser (`zen-browser` / `firefox` / `chromium`) |
| `Super + E` | File Manager (`thunar`) |
| `Super + O` | Note Taking (`obsidian`) |
| `Super + Q` / `Super + W` | Close active window (`Super + Shift + Q` kills window) |
| `Super + F` | Toggle fullscreen |
| `Super + V` | Toggle floating mode |
| `Super + Shift + V` | Clipboard history |
| `Super + S` | Toggle Control Center / Quick Settings |
| `Super + M` | Power & Session Menu |
| `Super + F4` | Lock and suspend session |
| `Super + ,` | Toggle Noctalia settings |
| `Super + Shift + BackSpace` | Toggle Noctalia bar |
| `Alt + Tab` | Window Switcher (`Super + Tab` focuses last window) |
| `Left Shift + Right Shift` | Toggle Keyboard Layout (English ⇄ Arabic) |
| `Super + Shift + Space` | Screenshot region to clipboard (Noctalia) |
| `Super + Shift + Ctrl + Space` | Screenshot active window to clipboard (`hyprshot`) |
| `Super + h / j / k / l` | Move focus (`Super + Shift + h/j/k/l` moves window) |
| `Super + R` | Enter resize submap (`h/j/k/l` to resize, `Esc` / `Super + R` to exit) |
| `Super + 1..0` | Switch workspace (`Super + Shift + 1..0` moves window) |
| `Super + C` / `Super + Shift + C` | Toggle / move window to `magic` scratchpad workspace |
| `Super + Shift + =` | Set `eDP-1` display scale to `1.5x` (comfortable) |
| `Super + Shift + -` | Set `eDP-1` display scale to `1.25x` (compact) |
| `3-finger swipe` | Switch workspaces |

---

## 🐚 Zsh Aliases & Functions

| Command / Alias | Description |
| :--- | :--- |
| `nv <cmd>` / `nvrun <cmd>` | Run `<cmd>` on NVIDIA MX350 via `prime-run` |
| `gputop` | Open GPU usage monitor (`nvtop`) |
| `cc` / `ccd` | Launch `claude` / `claude --dangerously-skip-permissions` |
| `shell` / `code` | Attach to `herdr` persistent `shell` / `code` sessions |
| `record [name]` | Record screen + audio to `~/recordings/` using AV1 (`wl-screenrec`) |
| `record-audio [name]` | Record audio to `~/recordings/` using PipeWire (`pw-record`) |
| `proxy <files...>` / `decode <files...>` | VAAPI AV1 `ffmpeg` transcoding helpers (1080p30 proxy / 8M AV1) |
| `archive <dir> <name>` / `unarchive <file>` | Create or extract `.tar.xz` archives |
| `update` / `mirror` / `cleanup` | Run `pacman -Syu`, rank CachyOS mirrors, remove orphaned packages |
| `big` / `rip` / `jctl` | List largest packages, recently installed packages (`expac`), and journal errors |

---

## 🎮 Hybrid Graphics (NVIDIA MX350 Offload)

The desktop and everyday applications run on the efficient **Intel Iris Xe Graphics** to maximize battery life and maintain rock-solid Wayland stability.

To run games, 3D workloads, or GPU-heavy apps on the dedicated **NVIDIA GeForce MX350**, prefix the command with `nv` or `prime-run`:

```bash
nv steam
# or
prime-run blender
```

---

## 🔧 Customization Notes

If you are deploying on different hardware, review these files:
* `hypr/config/monitors.lua`: Adjust `eDP-1` resolution/refresh/scale or external monitor placement.
* `hypr/config/devices.lua`: Adjust `kb_layout` (`us, ara`), layout toggle (`grp:shifts_toggle`), and touchpad settings (`natural_scroll = false` by default).
* `hypr/config/environment.lua` & `zsh/exports.zsh`: Adjust `LIBVA_DRIVER_NAME=iHD` if using non-Intel primary graphics.

---

## 📄 License
MIT
