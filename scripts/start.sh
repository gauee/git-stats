#!/bin/bash

DEBUG_ENABLED=1
RUNNING=true
BASE_DIR=$(dirname $(realpath $0))
source $BASE_DIR/utils.sh
source $BASE_DIR/init.sh

logDebug "BASE_DIR: $BASE_DIR"

cat $BASE_DIR/welcome-header.txt
printHelp
while $RUNNING; do
  read -e -p "Enter option: " userOption
  case $userOption in
  "e" | "exit")
    echo "Entered exit. Goodbye."
    RUNNING=false
    ;;
  "i" | "ri" | "init" | "reinit")
    initRepo
    ;;
  "1" | "contributors-performance")
    echo"124"
    ;;
  "h" | "help")
    printHelp
    ;;
  *)
    echo "Entered unknown option($userOption). Please try again or type 'h' or 'help'."
    ;;
  esac
done
