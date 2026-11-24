export EDITOR=zed

# Package managers & language runtimes
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"

# Hybrid Graphics / Intel Iris Xe Hardware Video Acceleration
export LIBVA_DRIVER_NAME=iHD

# Wayland Native Toolkit flags
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export GDK_SCALE=1
export QT_SCALE_FACTOR=1
export GSK_RENDERER=cairo
export MOZ_ENABLE_WAYLAND=1
