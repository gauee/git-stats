#!/bin/bash

__title_regex="^=+ (.*) =+$"

export_deactivate() {
  unset EXPORT_ACTIVATED
  log_debug "EXPORT_ACTIVATED: $EXPORT_ACTIVATED"
}

export_activate() {
  EXPORT_ACTIVATED=true
  log_debug "EXPORT_ACTIVATED: $EXPORT_ACTIVATED"
}

export_get_dir() {
  echo "$_repo_location/git-stats-exports"
}

export_create_file_name() {
  _title=$1
  _camelCaseTitle=$(echo "$_title" | tr ' ' '\n' | while read -r _word; do echo "${_word^}"; done | tr '\n' ',' | sed 's/,//g')
  _camelCaseTitle=${_camelCaseTitle,}
  _file_name="$_camelCaseTitle-$(date +'%Y%m%d_%H%M%S')"
  log_debug "File name: $_file_name"
  echo "$_file_name"
}

export_collect_output() {
  _files=()
  while read -r _line; do
    echo "$_line"
    if [[ -n "$EXPORT_ACTIVATED" ]]; then
      EXPORT_DIR=$(export_get_dir)
      mkdir -p "$EXPORT_DIR"
      if [[ "$_line" =~ $__title_regex ]]; then
        log_debug "Matched title: ${BASH_REMATCH[1]}"
        _csv_file="$(export_create_file_name "${BASH_REMATCH[1]}").csv"
        touch "$EXPORT_DIR/$_csv_file"
        _files+=("$EXPORT_DIR/$_csv_file")
      else
        echo "$_line" >>"$EXPORT_DIR/$_csv_file"
      fi
    fi
  done
  if [[ -n "$EXPORT_ACTIVATED" ]]; then
    echo "Data exported to: ${_files[*]}"
  fi
}
