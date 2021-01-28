#!/bin/bash

log_debug() {
  if [[ "$DEBUG_ENABLED" == "1" ]]; then
    echo >&2 "$(date): $*"
  fi
}

print_option() {
  line=$(printf '\056%.0s' {1..40})
  echo "$1 ${line:${#1}} $2"
}

print_header() {
  line=$(printf '\043%.0s' {1..20})
  left_half="${1:0:${#1}/2}"
  right_half="${1:${#1}/2}"
  log_debug "$left_half|$right_half"
  echo "${line:${#left_half}} $1 ${line:${#right_half}}"
}

print_sub_header() {
  line=$(printf '\075%.0s' {1..20})
  left_half="${1:0:${#1}/2}"
  right_half="${1:${#1}/2}"
  log_debug "$left_half|$right_half"
  echo "${line:${#left_half}} $1 ${line:${#right_half}}"
}

get_uniq_sorted_count() {
  while read -r _line; do
    echo "$_line"
  done | sort | uniq -c | sort | sed 's/^ *//' | sed 's/\([0-9]\+\) \(.*\)$/\2,\1/'
}

get_top_n_results() {
  _number_of_results=$(($1))
  while read -r _line; do
    echo "$_line"
  done | tail -n $_number_of_results | tac
}
