# Load machine-local / private aliases if present (gitignored — see .gitignore).
[[ -r "${0:A:h}/personal.local.zsh" ]] && source "${0:A:h}/personal.local.zsh"

alias nrd="npm run dev"
alias main="gcm && gl"

### PERSONAL ###
alias archive=archive_folder
alias unarchive=unarchive_folder
alias cc="claude"
alias ccd="claude --dangerously-skip-permissions"
alias remove="paru -Rns"
alias vi=nvim
alias gputop=nvtop
alias shell="herdr session attach shell"
alias code="herdr session attach code"
alias wii="whatisit"

function record() {
  mkdir -p ~/recordings
  wl-screenrec --audio --codec av1 --low-power=off --no-damage -v -f ~/recordings/"${1:-recording}-$(date +%Y-%m-%d-%H-%M).mp4"
}

function record-audio() {
  mkdir -p ~/recordings
  pw-record -v ~/recordings/"${1:-recording}-$(date +%Y-%m-%d-%H-%M).wav"
}

function archive_folder() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: archive <source_folder> <archive_name>"
    return 1
  fi

  if [[ ! -d "$1" ]]; then
    echo "Error: '$1' is not a valid directory"
    return 1
  fi

  sudo tar -cvpzf "$2.tar.xz" "$1"
}

unarchive_folder() {
  if [[ $# -lt 1 || $# -gt 2 ]]; then
    echo "Usage: unarchive_folder <archive.tar.xz> [destination]"
    return 1
  fi

  if [[ ! -f "$1" ]]; then
    echo "Error: '$1' not found"
    return 1
  fi

  if [[ -n "$2" ]]; then
    sudo tar -xvpJf "$1" -C "$2"
    echo "Extracted to: $2"
  else
    sudo tar -xvpJf "$1"
    echo "Extracted to current directory"
  fi
}

proxy() {
  for f in "$@"; do
  ffmpeg -hwaccel vaapi -hwaccel_output_format vaapi -i "$f" \
    -vf "scale_vaapi=w=1920:h=1080" -r 30 \
    -c:v av1_vaapi -b:v 2M \
    -c:a libmp3lame -b:a 192k \
    "${f:r}_av1proxy.mp4"
  done
}

decode() {
  for f in "$@"; do
  ffmpeg -hwaccel vaapi -hwaccel_output_format vaapi -i "$f" \
    -c:v av1_vaapi -b:v 8M \
    -c:a libmp3lame -b:a 320k \
    "${f:r}_av1.mp4"
  done
}
