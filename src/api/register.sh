#!/bin/bash

register_func () {
  echo "--------------------------"
	echo "Register Endpoint selected"
	echo "--------------------------"
    resp="$(get_code 'POST' ${base_url}${register} ${post_register_pass} 'JSON')"
    if [ "${resp}" -eq "200" ]; then
        echo "1. POST register status code check - Passed"
    else
        echo "1. POST register status code check - **Failed**"
    fi
    resp="$(get_code 'POST' ${base_url}${register} ${post_register_fail} 'JSON')"
    if [ "${resp}" -eq "400" ]; then
        echo "2. POST register status code check - Passed"
    else
        echo "2. POST register status code check - **Failed**"
    fi
    echo
}