#!/bin/bash

contributors_print_help() {
  print_header "Main > Contributors"
  print_option "1, commits" "to measure activity based on number of commits"
  print_option "2, changes" "to measure activity based on number of changes"
  print_option "h, help" "to print help with available options"
  print_option "e, exit" "to exit measure of contributors activity"
}

measure_contributors_activity() {
  __contributors_running=true
  contributors_print_help
  while $__contributors_running; do
    read -e -p "Enter option: " __contributors_user_option
    case $__contributors_user_option in
    "1" | "commits")
      echo "Commits option is not yet implemented"
      ;;
    "2" | "changes")
      echo "Changes option is not yet implemented"
      ;;
    "e" | "exit")
      echo "Exiting measure of contributors activity"
      __contributors_running=false
      print_help
      ;;
    "h" | "help")
      contributors_print_help
      ;;
    *)
      echo "Entered unknown option($__contributors_user_option). Please try again or type 'h' or 'help'."
      ;;
    esac
  done
}
