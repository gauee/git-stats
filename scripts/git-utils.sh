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

get_git_logs_with_changes() {
  __extra_params="$1"
  log_debug "Extra params: '$__extra_params'"
  if [[ -z "$__extra_params" ]]; then
    git log --shortstat --pretty=format:"CommitHash: %H|[%ae]" |
      grep -v "^$" |
      sed 's/^ /Changes: /' |
      tr '\n' '|' |
      sed 's/|$/\n/' |
      sed 's/|CommitHash/\nCommitHash/g' |
      grep -E "CommitHash.*Changes" |
      sed 's/\(CommitHash\|Changes\): //g'
  else
    git log "${__extra_params}" --shortstat --pretty=format:"CommitHash: %H|[%ae]" |
      grep -v "^$" |
      sed 's/^ /Changes: /' |
      tr '\n' '|' |
      sed 's/|$/\n/' |
      sed 's/|CommitHash/\nCommitHash/g' |
      grep -E "CommitHash.*Changes" |
      sed 's/\(CommitHash\|Changes\): //g'
  fi
  log_debug "Finished"
}
