#!/usr/bin/env sh

git log --date=format:'%a,%Y-%m-%d %H:%M:%S %z' --pretty=format:"%H|%ad[%cd]|%an|[%ae]|"
git log --no-merges --shortstat --pretty=format:"%H" | grep -v "^$" | sed 'N;s/\n/|/'

git log --date=format:'%a,%Y-%m-%d %H:%M:%S %z' --pretty=format:"%H|%ad[%cd]|%an|[%ae]|" | head -n 1000 >/app/temp/logs.lst
cat /app/temp/logs.lst | awk -F\| '{print $2}' | cut -c -3 | sort | uniq -c
cat /app/temp/logs.lst | awk -F\| '{print $2}' | cut -c 5-14 | sort | uniq -c
cat /app/temp/logs.lst | sed 's/.*|\[\([^\[]*\)\]|$/\1/' | sort | uniq -c | sort -n -r

git branch -avv | wc -l
git tag -l | wc -l

git log --since="last month" --shortstat --pretty=format:"CommitHash: %H" | grep -v "^$" | sed 's/^ /Changes: /' | tr '\n' '|' | sed 's/|$/\n/' | sed 's/|CommitHash/\nCommitHash/g' | egrep "CommitHash.*Changes"
