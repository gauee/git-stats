#!/bin/bash

DEBUG_ENABLED=1
RUNNING=true
BASE_DIR=$(dirname $(realpath $0))

echo $BASE_DIR
cat $BASE_DIR/welcome-header.txt

logDebug() {
  if [ $DEBUG_ENABLED ]; then
    echo "$(date): $1"
  fi
}

printOption() {
  echo -e "$1 \t: $2"
}

initRepo() {
  read -e -p "Please enter the location of git repository:" repoLocation
  isGitRepo=$(
    cd $repoLocation
    if [ -d .git ]; then echo "yes"; else echo "no"; fi
  )
  logDebug $isGitRepo
  while [ "yes" != "$isGitRepo" ]; do
    invalidRepoLocation=$repoLocation
    echo "Previously entered location ($invalidRepoLocation) is not a git repo."a
    read -e -p "Please enter the location of git repository:" repoLocation
    isGitRepo=$(
      cd $repoLocation
      if [ -d .git ]; then echo "yes"; else echo "no"; fi
    )
    logDebug $isGitRepo
  done
  logDebug "Changing location to: $repoLocation"
}

while $RUNNING; do
  echo "Please select the option to execute:"
  if [ -z "$repoLocation" ]; then
    printOption "i, init" "to init the git repo"
  else
    printOption "ri, reinit" "to change the git repo"
  fi
  printOption "e, exit" "to exit the program"

  read -e -p "Enter option:" userOption

  case $userOption in
  "e" | "exit")
    echo "Entered exit. Goodbye."
    RUNNING=false
    ;;
  "i" | "ri" | "init" | "reinit")
    initRepo
    ;;
  *)
    echo "Entered unknown option($userOption). Please try again."
    ;;
  esac
done
