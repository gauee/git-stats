#!/bin/bash

get_git_logs() {
  __extra_params="$1"
  log_debug "Extra params: '$__extra_params'"
  if [[ -z "$__extra_params" ]]; then
    git log --date=format:'%a,%Y-%m-%d %H:%M:%S %z' --pretty=format:"%H|%ad[%cd]|%an|[%ae]|"
  else
    git log "${__extra_params}" --date=format:'%a,%Y-%m-%d %H:%M:%S %z' --pretty=format:"%H|%ad[%cd]|%an|[%ae]|"
  fi
}
