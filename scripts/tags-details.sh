#!/bin/bash

tags_print_help() {
  print_header "Main > Tags"
  print_option "1, date" "to count commits by date"
  print_option "h, help" "to print help with available options"
  print_option "e, exit" "to exit count of commits"
}

tags_count_by_date() {
  print_sub_header "Tags in last month"
  echo "YYYYMMDD,#tags"
  get_git_tags_in_date_period "%Y%m%d" --since="last month" | awk -F\| '{print $2}' | get_uniq_sorted_count | sort -n -t, -k2 | tac
  print_sub_header "Tags in year month"
  echo "YYYYMM,#tags"
  get_git_tags_in_date_period "%Y%m" --since="last year" | awk -F\| '{print $2}' | get_uniq_sorted_count | sort -n -t, -k2 | tac
  print_sub_header "Tags by year"
  echo "YYYY,#tags"
  get_git_tags_in_date_period "%Y" | awk -F\| '{print $2}' | get_uniq_sorted_count | sort -n -t, -k2 | tac
}

measure_tags() {
  _tags_running=true
  tags_print_help
  while $_tags_running; do
    read -r -e -p "Enter option: " _tags_user_option
    case "$_tags_user_option" in
    "1" | "date")
      tags_count_by_date | export_collect_output
      ;;
    "e" | "exit")
      echo "Exiting count of commits"
      _tags_running=false
      print_help
      ;;
    "h" | "help")
      tags_print_help
      ;;
    *)
      echo "Entered unknown option($_tags_user_option). Please try again or type 'h' or 'help'."
      ;;
    esac
  done
}
