#!/bin/bash

contributors_print_help() {
  print_header "Main > Contributors"
  print_option "1, commits" "to measure activity based on number of commits"
  print_option "2, changes" "to measure activity based on number of changes"
  print_option "h, help" "to print help with available options"
  print_option "e, exit" "to exit measure of contributors activity"
}

get_contributors_with_the_most_number_of_commits() {
  __number_of_contrubtors=$1
  print_sub_header "Top 10 in last month"
  get_git_logs --since="last month" | awk -F\| '{print $4}' | get_top_n_results
  print_sub_header "Top 10 in last year"
  get_git_logs --since="last year" | awk -F\| '{print $4}' | get_top_n_results
  print_sub_header "Top 10 in entire history"
  get_git_logs | awk -F\| '{print $4}' | get_top_n_results
}

measure_contributors_activity() {
  __contributors_running=true
  contributors_print_help
  while $__contributors_running; do
    read -e -p "Enter option: " __contributors_user_option
    case $__contributors_user_option in
    "1" | "commits")
      get_contributors_with_the_most_number_of_commits 10
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
