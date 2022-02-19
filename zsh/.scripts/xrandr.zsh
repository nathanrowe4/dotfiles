fzf_xrandr_get_output_name() {
  xrandr |
    grep -v disconnected |
    grep connected |
    fzf |
    awk '{print $1}'
}

fzf_xrandr_output_on() {
  local output=$(fzf_xrandr_get_output_name)

  if [[ "$output" = "" ]]; then
    echo "No output selected."
    return
  fi

  xrandr --output $output --auto --right-of eDP-1-1 --rotate left
}

fzf_xrandr_output_off() {
  local output=$(fzf_xrandr_get_output_name)

  if [[ "$output" = "" ]]; then
    echo "No output selected."
    return
  fi

  xrandr --output $output --off
}

# aliases
alias xo="fzf_xrandr_output_on"
alias xx="fzf_xrandr_output_off"
