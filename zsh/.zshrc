# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/nathanrowe/.zplug/repos/robbyrussell/oh-my-zsh"

# Check if z-plug is installed or not. If not, install it:
# https://github.com/zplug/zplug
if [[ ! -d ~/.zplug ]]; then
  echo "z-plug not installed. Installing it."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

source ~/.zplug/init.zsh

# List of plugins to load

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# ZSH themes
ZSH_THEME="agnoster"
source $ZSH/oh-my-zsh.sh

export CODE_PATH="${HOME}/code"

# Bart aliases
export TOOLBOX_PATH="${CODE_PATH}/wright-group/bart"
export PYTHONPATH="${TOOLBOX_PATH}/python:$PYTHONPATH"

# View aliases
alias view="${CODE_PATH}/wright-group/view/view"

# Editor aliases
export VISUAL=vim
export EDITOR="$VISUAL"

# Show only user on terminal if user is default
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# xrandr aliases
alias xrandr-hori="xrandr --output HDMI-1 --auto --right-of eDP-1"
alias xrandr-vert="xrandr --output HDMI-1 --auto --right-of eDP-1 --rotate left"
alias xrandr-off="xrandr --output HDMI-1 --off"

# xclip alias
alias xclip-pwd="pwd | xclip -selection clipboard"

# misc aliases
alias ls="ls --color=auto"
alias ll="ls -la"
alias grep='grep --color=auto'
alias python="python3"
