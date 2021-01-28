#!/bin/bash

export_deactivate() {
  unset EXPORT_ACTIVATED
  log_debug "EXPORT_ACTIVATED: $EXPORT_ACTIVATED"
}

export_activate() {
  EXPORT_ACTIVATED=true
  log_debug "EXPORT_ACTIVATED: $EXPORT_ACTIVATED"
}
