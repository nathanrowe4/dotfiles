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

# Bundles from robbyrussell's oh-my-zsh.
zplug "plugins/git", from:oh-my-zsh
#zplug "themes/avit", from:oh-my-zsh, as:theme

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
ZSH_THEME="avit"
source $ZSH/oh-my-zsh.sh
