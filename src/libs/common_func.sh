#!/bin/bash

# Function to get status code
# $1 = GET / POST / PATCH / UPDATE / DELETE
# $2 = url
# $3 = message body for non-GET requests
# $4 = message body type (JSON / etc...)
get_code () {
  local reps=0
  case "$1" in
    "GET")
        reps=$(curl -s -o /dev/null -w "%{response_code}" "$2")
        ;;
    "POST")
        if [[ "$4" == "JSON" ]]
        then
          reps=$(curl -s -o /dev/null -w "%{response_code}" -d "${3}" -H 'Content-Type: application/json' -H 'Accept: application/json' "$2")
        # Add an else here for other data types
        fi
        ;;
    "PUT")
        if [[ "$4" == "JSON" ]]
        then
          # Create reference to message body
          local -n msg_body=$3
          reps=$(curl -s -o /dev/null -w "%{response_code}" -d "${msg_body}" -H 'Content-Type: application/json' -H 'Accept: application/json' -X "$1" "$2")
        # Add an else here for other data types
        fi
        ;;
    "PATCH")
        if [[ "$4" == "JSON" ]]
        then
          # Create reference to message body
          local -n msg_body=$3
          reps=$(curl -s -o /dev/null -w "%{response_code}" -d "${msg_body}" -H 'Content-Type: application/json' -H 'Accept: application/json' -X "$1" "$2")
        # Add an else here for other data types
        fi
        ;;
    "DELETE")
        reps=$(curl -s -o /dev/null -w "%{response_code}" -X "$1" "$2")
        ;;
  esac
  echo "$reps"
}

usage_msg () {
  echo "Usage: ./check.sh <api-1> <api-2> .... <api-n>"
}


# Function to get response body
# $1 = GET / POST / PATCH / UPDATE / DELETE
# $2 = url
# $3 = message body for non-GET requests
# $4 = message body type (JSON / etc...)
get_body () {
  local resp_body=0
  case "$1" in
    "GET")
      resp_body=$(curl -s "$2")
      ;;
    "POST")
      resp_body=$(curl -s -d "${3}" -H 'Content-Type: application/json' -H 'Accept: application/json' "$2")
      ;;
    "PUT")
      local -n msg_body=$3
      resp_body=$(curl -s -d "${msg_body}" -H 'Content-Type: application/json' -H 'Accept: application/json' -X "$1" "$2")
      ;;
    "PATCH")
      local -n msg_body=$3
      resp_body=$(curl -s -d "${msg_body}" -H 'Content-Type: application/json' -H 'Accept: application/json' -X "$1" "$2")
      ;;
    "DELETE")
      reps=$(curl -s -X "$1" "$2")
      ;;
  esac
  echo "${resp_body}"
}