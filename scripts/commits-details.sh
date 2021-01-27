#!/bin/bash

commits_print_help() {
  print_header "Main > Commits"
  print_option "1, date" "to count commits by date"
  print_option "2, release" "to count commits by release"
  print_option "h, help" "to print help with available options"
  print_option "e, exit" "to exit count of commits"
}

commits_count_by_date() {
  print_sub_header "Commits in last month"
  echo "#commits,YYYYMMDD"
  get_git_logs_with_date_format --since="last month" "%Y%m%d" | awk -F\| '{print $2}' | get_uniq_sorted_count | sort -n -t, -k2 | tac
  print_sub_header "Commits in year month"
  echo "#commits,YYYYMM"
  get_git_logs_with_date_format --since="last year" "%Y%m" | awk -F\| '{print $2}' | get_uniq_sorted_count | sort -n -t, -k2 | tac
  print_sub_header "Commits by year"
  echo "#commits,YYYY"
  get_git_logs_with_date_format "" "%Y" | awk -F\| '{print $2}' | get_uniq_sorted_count | sort -n -t, -k2 | tac
}

measure_commits() {
  _commits_running=true
  commits_print_help
  while $_commits_running; do
    read -r -e -p "Enter option: " _commits_user_option
    case "$_commits_user_option" in
    "1" | "date")
      commits_count_by_date
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
