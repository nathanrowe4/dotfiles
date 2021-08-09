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

# fzf configuration
export FZF_DEFAULT_OPTS='
  --color=bg+:#282A36,spinner:#BD93F9,hl:#50FA7B
  --color=fg:#ffffff,header:#8BE9FD,info:#BD93F9,border:#BD93F9,pointer:#50FA7B
  --color=marker:#8BE9FD,fg+:#ffffff,prompt:#50FA7B,hl+:#50FA7B
'

# fzf-git functions and aliases
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf_git_branch() {
  is_in_git_repo || return

  git branch --color=always --all --sort=-committerdate |
    grep -Ev "HEAD|remote" |
    fzf --ansi --no-multi --preview-window right:65% --header "Select a branch" \
        --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
    sed "s/.* //"
}

fzf_git_branch_multi() {
  is_in_git_repo || return

  git branch --color=always --all --sort=-committerdate |
    grep -Ev "HEAD|remote" |
    fzf --ansi --multi --preview-window right:65% --header "Select a branch" \
        --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
    sed "s/.* //"
}

fzf_git_mod_files() {
  is_in_git_repo || return

  git diff --name-only |
    fzf --ansi --multi --preview-window right:65% --header "Select a file" \
        --preview 'git diff --color=always --date=short -- {}'
}

fzf_git_diff() {
  is_in_git_repo || return

  local mod_files

  mod_files=$(fzf_git_mod_files)

  if [[ "$mod_files" = "" ]]; then
    echo "No file(s) selected."
    return
  fi

  echo $mod_files | xargs git diff
}

fzf_git_overwrite_local() {
  is_in_git_repo || return

  local mod_files

  mod_files=$(fzf_git_mod_files)

  if [[ "$mod_files" = "" ]]; then
    echo "No file(s) selected."
    return
  fi

  echo $mod_files | xargs git checkout --
}

# TODO: Add flag to include remote branches
fzf_git_checkout() {
  is_in_git_repo || return

  local branch

  branch=$(fzf_git_branch)
  if [[ "$branch" = "" ]]; then
      echo "No branch selected."
      return
  fi

  if [[ "$branch" = "remotes/"* ]]; then
    git checkout --track $branch
  else
    git checkout $branch
  fi
}

fzf_git_delete_branch() {
  is_in_git_repo || return

  branches=$(fzf_git_branch_multi)
  if [[ "$branches" = "" ]]; then
    echo "No branch(es) selected."
      return
  fi

  echo $branches | xargs git branch -d
}

fzf_git_force_delete_branch() {
  is_in_git_repo || return

  branches=$(fzf_git_branch_multi)
  if [[ "$branches" = "" ]]; then
    echo "No branch(es) selected."
      return
  fi

  echo $branches | xargs git branch -D
}

alias gb="fzf_git_branch"
alias gco="fzf_git_checkout"
alias gdb="fzf_git_delete_branch"
alias gDb="fzf_git_force_delete_branch"
alias gdf="fzf_git_diff"
alias gol="fzf_git_overwrite_local"

# xrandr aliases
# TODO: Write fzf function to add available monitor
alias xrandr-hori="xrandr --output HDMI-1 --auto --right-of eDP-1"
alias xrandr-vert="xrandr --output HDMI-1 --auto --right-of eDP-1 --rotate left"
alias xrandr-off="xrandr --output HDMI-1 --off"

# xclip alias
alias xclip-pwd="pwd | xclip -selection clipboard"

# misc aliases
alias lsg="ls | grep"
alias ll="ls -la"
alias llg="ll | grep"
alias grep='grep --color=auto'
alias python="python3"

# DO NOT CHANGE
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
