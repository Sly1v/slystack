## CachyOS-equivalent config for Zsh
## Ported from /usr/share/cachyos-fish-config/cachyos-config.fish

# ── Man pages formatted with bat ──
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ── Common use ──
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'
alias update='sudo pacman -Syu'

# ── Hybrid Graphics (NVIDIA MX350 Offload) ──
alias nv='prime-run'
alias nvrun='prime-run'

# ── Get fastest mirrors ──
alias mirror="sudo cachyos-rate-mirrors"

# ── Help people new to Arch ──
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias tb='nc termbin.com 9999'

# ── Cleanup orphaned packages ──
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# ── Journalctl errors ──
alias jctl="journalctl -p 3 -xb"

# ── Recent installed packages ──
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# ── Functions ──
# Show command history with timestamps
function history() {
  builtin fc -li 1
}

# Backup a file
function backup() {
  cp "$1" "$1.bak"
}

# Smart copy (recursive if source is a directory)
function copy() {
  if [[ $# -eq 2 && -d "$1" ]]; then
    command cp -r "${1%/}" "$2"
  else
    command cp "$@"
  fi
}

# ── PATH additions ──
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
