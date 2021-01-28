#!/bin/bash

tags_print_help() {
  print_header "Main > Tags"
  print_option "1, date" "to count commits by date"
  print_option "h, help" "to print help with available options"
  print_option "e, exit" "to exit count of commits"
}

#tags_count_by_date() {
#}

measure_tags() {
  _tags_running=true
  tags_print_help
  while $_tags_running; do
    read -r -e -p "Enter option: " _tags_user_option
    case "$_tags_user_option" in
    "1" | "date")
      echo "Tags count by date not implemented yet."
      #      tags_count_by_date
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
