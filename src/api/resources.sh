#!/bin/bash

resources_func () {
  echo "---------------------------"
	echo "Resources Endpoint selected"
	echo "---------------------------"
    resp="$(get_code 'GET' ${base_url}${resources})"
    if [ "${resp}" -eq "200" ]; then
        echo "1. GET list resource status code check - Passed"
    else
        echo "1. GET list resource status code check - **Failed**"
    fi
    resp="$(get_code 'GET' ${base_url}${resources}'/'${valid})"
    if [ "${resp}" -eq "200" ]; then
        echo "2. GET single resource status code check - Passed"
    else
        echo "2. GET single resource status code check - **Failed**"
    fi
    resp="$(get_code 'GET' ${base_url}${resources}'/'${invalid})"
    if [ "${resp}" -eq "404" ]; then
        echo "3. GET single resource not found status code check - Passed"
    else
        echo "3. GET single resource not found status code check - **Failed**"
    fi
    echo
}