#!/usr/bin/env bash
while true
do
  export CURRENT_BRANCH=$(git branch | awk '$1 == "*" {print $2}') 
  git pull origin "$CURRENT_BRANCH"; git add .; git commit -m 'Working...'; git push origin "$CURRENT_BRANCH"
done
