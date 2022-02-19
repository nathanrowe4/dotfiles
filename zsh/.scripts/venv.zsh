fzf_get_python_venvs(){
  find ~/venv -maxdepth 2 -mindepth 2 |
    grep -Ev sandbox |
    sed 's:^/home/nathanrowe/venv/::' |
    fzf --no-multi --header "Select a python venv"
}

fzf_source_python_venv() {
  # Parse command line arguments
  while getopts h flag
  do
    case "${flag}" in
        h) echo "Fuzzy search and select python venv's."
        echo
        echo "usage: fzf_source_venv [options]"
        echo "  options:"
        echo "    -h         Print this help."
        return;;
    esac
  done

  local python_venv=$(fzf_get_python_venvs)

  if [[ "$python_venv" = "" ]]; then
    echo "No python venv selected."
    return
  fi

  source /home/nathanrowe/venv/${python_venv}/bin/activate
}

# Aliases
alias spv="fzf_source_python_venv"
