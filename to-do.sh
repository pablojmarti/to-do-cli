#!/usr/bin/env bash

# variables 
file="/tmp/todocli.txt"

get_task(){
  echo "getting task from file"
}

add_task(){
  echo "$1" >> "$file"
}

remove_task(){
  while read -r task;
  do
    if [[ $task == $1 ]];
    then
      sed -i '' "/$1/d" $file  
    fi
  done <$file
}

list_tasks(){
  while read task;
  do
    echo $task
  done <$file
}

while getopts ":a:r:l" opt; do
  case $opt in
    a)
      echo "adding $OPTARG"
      add_task "$OPTARG"
      ;;
    r)
      echo "removing $OPTARG"
      remove_task $OPTARG
      ;;
    l)
      echo "listing tasks"
      list_tasks
      ;;
    \?)
      echo "Invalid Option -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires argument." >&2
      exit 1
      ;;
  esac
done

