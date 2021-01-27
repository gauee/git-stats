#!/bin/bash

log_debug() {
  if [ $DEBUG_ENABLED ]; then
    echo "$(date): $1"
  fi
}
