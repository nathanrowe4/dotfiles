# if you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/go/bin:$PATH

# check if z-plug is installed or not. If not, install it:
# https://github.com/zplug/zplug
if [[ ! -d ~/.zplug ]]; then
  echo "z-plug not installed. Installing it."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

source ~/.zplug/init.zsh

# list of plugins to load
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"

# install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# source plugins and add commands to $PATH
zplug load

# setup pure prompt
fpath+=$HOME/.pure
autoload -U promptinit; promptinit
prompt pure

# editor aliases
export VISUAL=vim
export EDITOR="$VISUAL"
export TERMINAL="gnome-terminal"
export BROWSER="google-chrome"
export READER="zathura"

export CODE_PATH="${HOME}/code"

# wright group stuff
# bart aliases
export TOOLBOX_PATH="${CODE_PATH}/wright-group/bart"
export PYTHONPATH="${TOOLBOX_PATH}/python:$PYTHONPATH"

# view alias
alias view="${CODE_PATH}/wright-group/view/view"

# fzf configuration
export FZF_DEFAULT_OPTS="
  --color=fg:#D8DEE9,bg:#2E3440,hl:#4C566A,fg+:#d8dee9,bg+:#3B4252,hl:#d8dee9
  --color=hl+:#81A1C1,info:#81A1C1,border:#81A1C1,prompt:#81A1C1,pointer:#81A1C1
  --color=marker:#81A1C1,spinner:#81A1C1,header:#4C566A,preview-fg:#D8DEE9
"

# configure colour of auto-suggested text
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=67"
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)

# source efficienzsh files
export efficienzsh="${CODE_PATH}/efficienzsh"
[ -f $efficienzsh/fzf-git.zsh ] && source $efficienzsh/fzf-git.zsh
[ -f $efficienzsh/fzf-kubectl.zsh ] && source $efficienzsh/fzf-kubectl.zsh
[ -f $efficienzsh/fzf-gh.zsh ] && source $efficienzsh/fzf-gh.zsh

# xrandr functions and aliases
[ -f ~/.scripts/xrandr.zsh ] && source ~/.scripts/xrandr.zsh

# to-do list functions and aliases
[ -f ~/.scripts/todo.zsh ] && source ~/.scripts/todo.zsh

# python venv functions and aliases
[ -f ~/.scripts/venv.zsh ] && source ~/.scripts/venv.zsh

# clockify-cli functions and aliases
[ -f ~/.scripts/clockify.zsh ] && source ~/.scripts/clockify.zsh

# xclip alias
alias cpwd="pwd | xclip -selection clipboard"

# misc aliases
alias lsg="ls | grep"
alias ll="ls -la"
alias llg="ll | grep"
alias grep='grep --color=auto'
alias python="python3"

# source fzf file if it exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function env_mlflow_vysio() {
  export MLFLOW_TRACKING_URI="http://mlflow.vysio.ca"
  export MLFLOW_TRACKING_USERNAME="admin"
  export MLFLOW_TRACKING_PASSWORD="guhfugpass"
  export GOOGLE_APPLICATION_CREDENTIALS="/home/nathanrowe/code/vysio/mlflow/mlflow/vysio-330718-0ceb5e77143e.json"
}
