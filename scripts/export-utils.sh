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
  declare -A _charts_data
  while read -r _line; do
    echo "$_line"
    if [[ -n "$EXPORT_ACTIVATED" ]]; then
      EXPORT_DIR=$(export_get_dir)
      mkdir -p "$EXPORT_DIR"
      if [[ "$_line" =~ $__title_regex ]]; then
        _title="${BASH_REMATCH[1]}"
        log_debug "Matched title: $_title"
        _csv_file="$(export_create_file_name "$_title").csv"
        _png_file="$(export_create_file_name "$_title").png"
        _charts_data[$_png_file]="$_title|"
        touch "$EXPORT_DIR/$_csv_file"
        _files+=("$_csv_file", "$_png_file")
      else
        echo "$_line" >>"$EXPORT_DIR/$_csv_file"
        if [[ "$_line" != *"#"* ]]; then
          _charts_data[$_png_file]+="${_line//,/:},"
        fi
      fi
    fi
  done
  if [[ -n "$EXPORT_ACTIVATED" ]]; then
    for key in "${!_charts_data[@]}"; do
      _details="${_charts_data[$key]//*|/}"
      log_debug "/apps/git-stats/scripts/generate_chart.py '${_charts_data[$key]//|*/}' '$EXPORT_DIR/$key' '${_details::-1}'"
      /apps/git-stats/scripts/generate_chart.py "${_charts_data[$key]//|*/}" "$EXPORT_DIR/$key" "${_details::-1}"
    done
    echo "Generated in $EXPORT_DIR files: ${_files[*]}"
  fi
}
