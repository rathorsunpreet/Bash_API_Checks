#!/bin/bash

users_func () {
  echo "-----------------------"
	echo "Users Endpoint selected"
	echo "-----------------------"
  
  resp="$(get_code 'GET' ${base_url}${users}'?page='${valid})"
  if [ "${resp}" -eq "200" ]; then
    echo "1. GET list users status code check - Passed"
  else
      echo "1. GET list users status code check - **Failed**"
  fi
  
  resp="$(get_code 'GET' ${base_url}${users}'/'${valid})"
  if [ "${resp}" -eq "200" ]; then
      echo "2. GET single users status code check - Passed"
  else
      echo "2. GET single users status code check - **Failed**"
  fi
  
  resp="$(get_code 'GET' ${base_url}${users}'/'${invalid})"
  if [ "${resp}" -eq "404" ]; then
      echo "3. GET single user not found status code check - Passed"
  else
      echo "3. GET single user not found status code check - **Failed**"
  fi
  
  resp="$(get_code 'POST' ${base_url}${users} ${post_users} 'JSON')"
  if [ "${resp}" -eq "201" ]; then
      echo "4. POST create status code check - Passed"
  else
      echo "4. POST create status code check - **Failed**"
  fi

  # Send others_api as a reference
  resp="$(get_code 'PUT' ${base_url}${users}'/'${valid} others_api 'JSON')"
  if [ "${resp}" -eq "200" ]; then
      echo "5. PUT update status code check - Passed"
  else
      echo "5. PUT update status code check - **Failed**"
  fi

  # Send others_api as a reference
  resp="$(get_code 'PATCH' ${base_url}${users}'/'${valid} others_api 'JSON')"
  if [ "${resp}" -eq "200" ]; then
      echo "6. PATCH update status code check - Passed"
  else
      echo "6. PATCH update status code check - **Failed**"
  fi
  
  resp="$(get_code 'DELETE' ${base_url}${users}'/'${valid})"
  if [ "${resp}" -eq "204" ]; then
      echo "7. DELETE status code check - Passed"
  else
      echo "7. DELETE status code check - **Failed**"
  fi
  
  resp="$(get_code 'GET' ${base_url}${users}'?delay='${delayed})"
  if [ "${resp}" -eq "200" ]; then
      echo "8. GET delayed response status code check - Passed"
  else
      echo "8. GET delayed response status code check - **Failed**"
  fi
  echo
}
