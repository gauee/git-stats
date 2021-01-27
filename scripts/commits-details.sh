#!/bin/bash

commits_print_help() {
  print_header "Main > Commits"
  print_option "1, date" "to count commits by date"
  print_option "2, release" "to count commits by release"
  print_option "h, help" "to print help with available options"
  print_option "e, exit" "to exit count of commits"
}

measure_commits() {
  _commits_running=true
  commits_print_help
  while $_commits_running; do
    read -r -e -p "Enter option: " _commits_user_option
    case "$_commits_user_option" in
    "1" | "date")
      echo "Counting by date is not implemented yet."
      ;;
    "2" | "release")
      echo "Counting by release is not implemented yet."
      ;;
    "e" | "exit")
      echo "Exiting count of commits"
      _commits_running=false
      print_help
      ;;
    "h" | "help")
      commits_print_help
      ;;
    *)
      echo "Entered unknown option($_commits_user_option). Please try again or type 'h' or 'help'."
      ;;
    esac
  done
}
