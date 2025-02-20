#!/bin/bash

# Valid values for arguments
args=()
for fil in $(dirname "$0")/api/*.sh
do
  base=${fil##*/}
  name=${base%.*}
  args+=("$name")
done
# args now holds the following values
# 0 = login
# 1 = register
# 2 = resources
# 3 = users

# Uncomment below line to see args
#echo "${args[*]}"

# Get variables
source $(dirname "$0")/libs/var.sh

# Get curl methods
source $(dirname "$0")/libs/common_func.sh

# Source each API endpoint
for f in $(dirname "$0")/api/*.sh
do
  source $f
done

# Check if any command-line arguments are present
#  If not, then exit program with message
if [[ "$*" == "" ]]
then
  echo "No API endpoints specified!"
  usage_msg
fi

for i in "$@"
do
  # "all" argument found, skip all other endpoints
  if [[ "$i" == "all" ]]
  then
    echo "-----------------------"
    echo "All Endpoint selected"
    echo "-----------------------"
    for j in "${args[@]}"
    do
      func="$j"_func
      $func
    done
    # Exit script
    exit 0
  fi
done

for i in "$@"
do
  # Check for endpoints, if any execute corresponding
  # function
  for j in "${args[@]}"
  do
    if [[ "$i" == "$j" ]]
    then
      func="$j"_func
      $func
    fi
  done
done