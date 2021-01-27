#!/bin/bash

init_repo() {
  read -r -e -p "Please enter the location of git repository: " _repo_location
  _is_git_repo=$(
    cd "$_repo_location" &&
      if [ -d .git ]; then echo "yes"; else echo "no"; fi
  )
  log_debug "$_is_git_repo"
  while [ "yes" != "$_is_git_repo" ]; do
    invalid_repo_location=$_repo_location
    echo "Previously entered location ($invalid_repo_location) is not a git repo."a
    read -r -e -p "Please enter the location of git repository: " _repo_location
    _is_git_repo=$(
      cd "$_repo_location" &&
        if [ -d .git ]; then echo "yes"; else echo "no"; fi
    )
    log_debug "$_is_git_repo"
  done
  log_debug "Changing location to: $_repo_location"
  cd "$_repo_location" && echo "Repo HEAD $(git log HEAD -1 --date=iso-strict --pretty=format:'commit: %H, Author: %an, Date: %cd' | head -n 1)"
}

print_help() {
  print_header "Main"
  echo "Please select the option to execute:"
  if [ -z "$_repo_location" ]; then
    print_option "i, init" "to init the git repo"
  else
    print_option "ri, reinit" "to change the git repo"
    print_option "1, contributors" "to measure contributors activity"
    print_option "2, commits" "to count commit details"
  fi
  print_option "h, help" "to print help with available options"
  print_option "e, exit" "to exit the program"
}
