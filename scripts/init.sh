#!/bin/bash

print_option() {
  echo -e "$1 \t: $2"
}

init_repo() {
  read -e -p "Please enter the location of git repository: " _repo_location
  _is_git_repo=$(
    cd $_repo_location
    if [ -d .git ]; then echo "yes"; else echo "no"; fi
  )
  log_debug $_is_git_repo
  while [ "yes" != "$_is_git_repo" ]; do
    invalid_repo_location=$_repo_location
    echo "Previously entered location ($invalid_repo_location) is not a git repo."a
    read -e -p "Please enter the location of git repository: " _repo_location
    _is_git_repo=$(
      cd $_repo_location
      if [ -d .git ]; then echo "yes"; else echo "no"; fi
    )
    log_debug $_is_git_repo
  done
  log_debug "Changing location to: $_repo_location"
}

print_help() {
  echo "Please select the option to execute:"
  if [ -z "$_repo_location" ]; then
    print_option "i, init" "to init the git repo"
  else
    print_option "ri, reinit" "to change the git repo"
  fi
  print_option "1, contributors-performance" "to exit the program"
  print_option "h, help" "to print help with available options"
  print_option "e, exit" "to exit the program"
}
