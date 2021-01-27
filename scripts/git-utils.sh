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

get_git_logs_with_date_format() {
  __extra_params="$1"
  __date_format="$2"
  [[ -z $__date_format ]] && __date_format='%a,%Y-%m-%d %H:%M:%S %z'
  log_debug "Extra params: '$__extra_params', Date format: '$___date_format'"
  if [[ -z "$__extra_params" ]]; then
    git log --date=format:$__date_format --pretty=format:"%H|%cd|%an|[%ae]|"
  else
    git log "${__extra_params}" --date=format:$__date_format --pretty=format:"%H|%cd|%an|[%ae]|"
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

get_git_tags_by_pattern() {
  __tag_pattern=$1
  git tag --sort=-creatordate -l $__tag_pattern
}
