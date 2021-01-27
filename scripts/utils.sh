#!/bin/bash

log_debug() {
  if [[ $DEBUG_ENABLED ]]; then
    echo "$(date): $1"
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
