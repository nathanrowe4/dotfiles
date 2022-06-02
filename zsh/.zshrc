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
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# editor aliases
export VISUAL=nvim
export EDITOR="$VISUAL"

export CODE_PATH="${HOME}/code"

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

# python venv functions and aliases
[ -f ~/.scripts/venv.zsh ] && source ~/.scripts/venv.zsh

# Misc aliases
alias grep='grep --color=auto'
alias python="python3"
# alias ig='ig --editor neovim'

# source fzf file if it exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export BAT_THEME="gruvbox-dark"
bindkey -v

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
