#!/bin/bash

login_func () {
  echo "-----------------------"
	echo "Login Endpoint selected"
	echo "-----------------------"
    resp="$(get_code 'POST' ${base_url}${login} ${post_login_pass} 'JSON')"
    if [ "${resp}" -eq "200" ]; then
        echo "1. POST login status code check - Passed"
    else
        echo "1. POST login status code check - **Failed**"
    fi
    
    # Check response body if it contains the words "token" and "QpwL5tke4Pnpja7X4"
    resp_body="$(get_body 'POST' ${base_url}${login} ${post_login_pass})"
    local check_txt="token"
    local check_query="QpwL5tke4Pnpja7X4"
    if [[ $resp_body == *"${check_txt}"* && $resp_body == *"${check_query}"* ]]
    then
      echo "1.1 POST login body check (token and QpwL5tke4Pnpja7X4) - Passed"
    else
      echo "1.1 POST login body check (token and QpwL5tke4Pnpja7X4) - **Failed**"
    fi
    
    resp="$(get_code 'POST' ${base_url}${login} ${post_login_fail} 'JSON')"
    if [ "${resp}" -eq "400" ]; then
        echo "2. POST login status code check - Passed"
    else
        echo "2. POST login status code check - **Failed**"
    fi
    echo
}
