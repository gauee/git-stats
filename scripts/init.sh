#!/bin/bash

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

printHelp() {
  echo "Please select the option to execute:"
  if [ -z "$repoLocation" ]; then
    printOption "i, init" "to init the git repo"
  else
    printOption "ri, reinit" "to change the git repo"
  fi
  printOption "1, contributors-performance" "to exit the program"
  printOption "h, help" "to print help with available options"
  printOption "e, exit" "to exit the program"
}
