#!/bin/bash

logDebug() {
  if [ $DEBUG_ENABLED ]; then
    echo "$(date): $1"
  fi
}
