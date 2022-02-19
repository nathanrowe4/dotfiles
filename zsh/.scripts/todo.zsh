export TODO=$HOME/Documents/personal/todo

get_todo_date() {
  echo $(date +"%m_%d_%y")
}

open_todo() {
  local current_todo_date=$(get_todo_date)
  local current_todo_file=$TODO/$current_todo_date/${current_todo_date}_todo.pdf

  if [[ -f "$current_todo_file" ]]; then
    zathura $TODO/$current_todo_date/${current_todo_date}_todo.pdf
  else
    echo "To-do list does not exist for $current_todo_date."
    printf "%s " "Do you wish to create a new to-do list? (y/n)"
    read do_create

    if [[ $do_create == "y" ]]; then
      create_todo
    fi
  fi
}

edit_todo() {
  local current_todo_date=$(get_todo_date)
  local current_todo_dir=$TODO/$current_todo_date
  local current_todo_file=$current_todo_dir/${current_todo_date}_todo.tex

  if [[ -f "$current_todo_file" ]]; then
    # Open current to-do file in vim and start real-time previewer
    vim -c "LLPStartPreview" $current_todo_file

    # Prompt user to see if they want to compile the tex file
    printf "%s " "Do you wish to compile ${current_todo_file}? (y/n)"
    read do_compile

    if [[ $do_compile == "y" ]]; then
      pdflatex -output-directory $current_todo_dir $current_todo_file
    fi
  else
    echo "To-do list does not exist for $current_todo_date."
    printf "%s " "Do you wish to create a new to-do list? (y/n)"
    read do_create

    if [[ $do_create == "y" ]]; then
      create_todo
    fi
  fi
}

create_todo() {
  # Create current to-do directory
  local current_todo_date=$(get_todo_date)
  local current_todo_dir=$TODO/$current_todo_date

  if [ -d $current_todo_dir ]; then
    printf "%s " "Directory for $current_todo_date already exists. Do you wish to exit? (y/n)"
    read do_exit

    if [[ $do_exit == "y" ]]; then
      return
    fi
  fi

  mkdir $current_todo_dir

  # Copy to-do tex file from template
  local current_todo_file=$current_todo_dir/${current_todo_date}_todo.tex
  cp $HOME/Documents/personal/tex_templates/todo/todo.tex $current_todo_file

  echo "Created todo .tex file: ${current_todo_file}"

  edit_todo
}

# aliases
alias ctd="create_todo"
alias etd="edit_todo"
alias otd="open_todo"
