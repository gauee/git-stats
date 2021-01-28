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
  echo "YYYYMMDD,#commits"
  get_git_logs_with_date_format --since="last month" "%Y%m%d" | awk -F\| '{print $2}' | get_uniq_sorted_count | sort -n -t, -k2 | tac
  print_sub_header "Commits in year month"
  echo "YYYYMM,#commits"
  get_git_logs_with_date_format --since="last year" "%Y%m" | awk -F\| '{print $2}' | get_uniq_sorted_count | sort -n -t, -k2 | tac
  print_sub_header "Commits by year"
  echo "YYYY,#commits"
  get_git_logs_with_date_format "" "%Y" | awk -F\| '{print $2}' | get_uniq_sorted_count | sort -n -t, -k2 | tac
}

count_commits_between_tags() {
  _prev_tag=""
  tac | while read -r _next_tag; do
    if [[ -z $_prev_tag ]]; then
      echo "$_next_tag, 0"
    else
      echo "$_next_tag,$(git rev-list --count ${_prev_tag}..${_next_tag})"
    fi
    _prev_tag="$_next_tag"
  done | tac
}

commits_count_by_release() {
  read -r -e -p "Enter tag release pattern: " _commits_tag_release_pattern
  print_sub_header "Commits between releases"
  echo "releaseTag,#Added commits"
  get_git_tags_by_pattern "$_commits_tag_release_pattern" | count_commits_between_tags
}

measure_commits() {
  _commits_running=true
  commits_print_help
  while $_commits_running; do
    read -r -e -p "Enter option: " _commits_user_option
    case "$_commits_user_option" in
    "1" | "date")
      commits_count_by_date | export_collect_output
      ;;
    "2" | "release")
      commits_count_by_release | export_collect_output
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
