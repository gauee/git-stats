#!/bin/bash

DEBUG_ENABLED=1
RUNNING=true
BASE_DIR=$(dirname $(realpath $0))
source $BASE_DIR/utils.sh
source $BASE_DIR/init.sh

log_debug "BASE_DIR: $BASE_DIR"

cat $BASE_DIR/welcome-header.txt
print_help
while $RUNNING; do
  read -e -p "Enter option: " _user_option
  case $_user_option in
  "e" | "exit")
    echo "Entered exit. Goodbye."
    RUNNING=false
    ;;
  "i" | "ri" | "init" | "reinit")
    init_repo
    ;;
  "1" | "contributors-performance")
    echo"124"
    ;;
  "h" | "help")
    print_help
    ;;
  *)
    echo "Entered unknown option($_user_option). Please try again or type 'h' or 'help'."
    ;;
  esac
done
