#!/bin/bash

contributors_print_help() {
  print_header "Main > Contributors"
  print_option "1, commits" "to measure activity based on number of commits"
  print_option "2, changes" "to measure activity based on number of changes"
  print_option "h, help" "to print help with available options"
  print_option "e, exit" "to exit measure of contributors activity"
}

count_changes() {
  declare -A usersWithFileChanges
  declare -A usersWithInsertions
  declare -A usersWithDeletions
  log_debug "Start changes counting..."
  while read -r line; do
    IFS="|"
    read -r hash user details <<<"$line"
    #    log_debug "Hash: $hash, User: $user, Details: $details"
    [[ -z ${usersWithFileChanges[$user]} ]] &&
      declare -i usersWithFileChanges[$user]=0 &&
      declare -i usersWithInsertions[$user]=0 &&
      declare -i usersWithDeletions[$user]=0
    if [[ "$details" != *"insertion"* ]]; then
      details="$details, 0 insertion"
    fi
    if [[ "$details" != *"deletion"* ]]; then
      details="$details, 0 deletion"
    fi
    usersWithFileChanges[$user]+=$(echo "$details" | sed 's/.*\([0-9]\+\) file.* changed.*/\1/')
    usersWithInsertions[$user]+=$(echo "$details" | sed 's/.*\([0-9]\+\) insertion.*/\1/')
    usersWithDeletions[$user]+=$(echo "$details" | sed 's/.*\([0-9]\+\) deletion.*/\1/')
  done
  for _key in "${!usersWithFileChanges[@]}"; do
    echo "$_key,${usersWithFileChanges[$_key]},${usersWithInsertions[$_key]},${usersWithDeletions[$_key]}"
  done
  log_debug "Finished changes counting..."
}

sort_changes() {
  while read -r line; do
    echo "$line"
  done | sort -n -t, -k2
}

get_contributors_with_the_most_number_of_commits() {
  _number_of_contributors=$(($1))
  log_debug "Number of contributors to fetch: $_number_of_contributors"
  print_sub_header "Top $_number_of_contributors in last month"
  echo "Author,#commits"
  get_git_logs --since="last month" | awk -F\| '{print $4}' | get_uniq_sorted_count | get_top_n_results $_number_of_contributors
  print_sub_header "Top $_number_of_contributors in last year"
  echo "Author,#commits"
  get_git_logs --since="last year" | awk -F\| '{print $4}' | get_uniq_sorted_count | get_top_n_results $_number_of_contributors
  print_sub_header "Top $_number_of_contributors in entire history"
  echo "Author,#commits"
  get_git_logs | awk -F\| '{print $4}' | get_uniq_sorted_count | get_top_n_results $_number_of_contributors
}

get_contributors_with_the_most_number_of_changes() {
  _number_of_contributors=$(($1))
  log_debug "Number of contributors to fetch: $_number_of_contributors"
  print_sub_header "Top $_number_of_contributors in last month"
  echo "Author,#changed files,#lines inserted,#lines deleted"
  get_git_logs_with_changes --since="last month" | count_changes | sort_changes | get_top_n_results $_number_of_contributors
  print_sub_header "Top $_number_of_contributors in last year"
  echo "Author,#changed files,#lines inserted,#lines deleted"
  get_git_logs_with_changes --since="last year" | count_changes | sort_changes | get_top_n_results $_number_of_contributors
}

measure_contributors_activity() {
  __contributors_running=true
  contributors_print_help
  while $__contributors_running; do
    read -r -e -p "Enter option: " __contributors_user_option
    case $__contributors_user_option in
    "1" | "commits")
      get_contributors_with_the_most_number_of_commits 5 | export_collect_output
      ;;
    "2" | "changes")
      get_contributors_with_the_most_number_of_changes 5 | export_collect_output
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
