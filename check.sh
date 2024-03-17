#!/bin/bash

# Commonly used variables
# Valid values for arguments
args=( "users" "register" "login" "resources" "all" )

# API variables
base_url='https://reqres.in'
users='/api/users'
resources='/api/unknown'
register='/api/register'
login='/api/login'
valid='2'
invalid='23'
delayed='3'

# Variable to hold mismatches with arguments supplied
let "count = -1"

# Check if any command-line arguments are present
#  If not, then exit program with message
for val in "${args[@]}"
do
    if [ "$1" != "${val}" ]
    then
        let "count+=1"
    else
        let "count-=1"
    fi
done
if [ $count -eq 4 ]; then
    echo 'No matching API endpoints found!'
    echo 'Exiting script.'
    exit
fi

# Functions for each endpoint
users_func () {
    echo "-----------------------"
	echo "Users Endpoint selected"
	echo "-----------------------"
    reps=$(curl -s -o /dev/null -w "%{http_code}" ${base_url}${users}"?page="${valid})
    if [ "${reps}" -eq "200" ]; then
    	echo "1. GET list users endpoint - Passed"
   	else
        echo "1. GET list users endpoint - **Failed**"
    fi
    reps=$(curl -s -o /dev/null -w "%{http_code}" ${base_url}${users}"/"${valid})
    if [ "${reps}" -eq "200" ]; then
        echo "2. GET single users endpoint - Passed"
    else
       	echo "2. GET single users endpoint - **Failed**"
    fi
    reps=$(curl -s -o /dev/null -w "%{http_code}" ${base_url}${users}"/"${invalid})
    if [ "${reps}" -eq "404" ]; then
        echo "3. Get single user not found endpoint - Passed"
    else
        echo "3. Get single user not found endpoint - **Failed**"
    fi
    reps=$(curl -s -o /dev/null -w "%{http_code}" -d '{"name":"morpheus","job":"leader"}' -H 'Content-Type: application/json' -H 'Accept: application/json' ${base_url}${users})
    if [ "${reps}" -eq "201" ]; then
        echo "4. POST create endpoint - Passed"
    else
        echo "4. POST create endpoint - **Failed**"
    fi
 	reps=$(curl -s -o /dev/null -w "%{http_code}" -d '{"name":"morpheus","job":"zion resident"}' -H 'Content-Type: application/json' -H 'Accept: application/json' -X PUT ${base_url}${users}"/"${valid})
    if [ "${reps}" -eq "200" ]; then
        echo "5. PUT update endpoint - Passed"
    else
        echo "5. PUT update endpoint - **Failed**"
    fi
    reps=$(curl -s -o /dev/null -w "%{http_code}" -d '{"name":"morpheus","job":"zion resident"}' -H 'Content-Type: application/json' -H 'Accept: application/json' -X PATCH ${base_url}${users}"/"${valid})
    if [ "${reps}" -eq "200" ]; then
        echo "6. PATCH update endpoint - Passed"
    else
        echo "6. PATCH update endpoint - **Failed**"
    fi
    reps=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE ${base_url}${users}"/"${valid})
    if [ "${reps}" -eq "204" ]; then
        echo "7. DELETE endpoint - Passed"
    else
        echo "7. DELETE endpoint - **Failed**"
    fi
    reps=$(curl -s -o /dev/null -w "%{http_code}" ${base_url}${users}"?delay="${delayed})
    if [ "${reps}" -eq "200" ]; then
        echo "8. GET delayed response endpoint - Passed"
    else
        echo "8. GET delayed response endpoint - **Failed**"
    fi
    echo
}

register_func () {
    echo "--------------------------"
	echo "Register Endpoint selected"
	echo "--------------------------"
    reps=$(curl -s -o /dev/null -w "%{http_code}" -d '{"email":"eve.holt@reqres.in","password":"pistol"}' -H 'Content-Type: application/json' -H 'Accept: application/json' ${base_url}${register})
    if [ "${reps}" -eq "200" ]; then
        echo "1. POST register successful endpoint - Passed"
    else
        echo "1. POST register successful endpoint - **Failed**"
    fi
    reps=$(curl -s -o /dev/null -w "%{http_code}" -d '{"email":"sydney@fife"}' -H 'Content-Type: application/json' -H 'Accept: application/json' ${base_url}${register})
    if [ "${reps}" -eq "400" ]; then
        echo "2. POST register unsuccessful endpoint - Passed"
    else
        echo "2. POST register unsuccessful endpoint - **Failed**"
    fi
    echo
}

login_func () {
    echo "-----------------------"
	echo "Login Endpoint selected"
	echo "-----------------------"
    reps=$(curl -s -o /dev/null -w "%{http_code}" -d '{"email":"eve.holt@reqres.in","password":"cityslicka"}' -H 'Content-Type: application/json' -H 'Accept: application/json' ${base_url}${login})
    if [ "${reps}" -eq "200" ]; then
        echo "1. POST login successful - Passed"
    else
        echo "1. POST login successful - **Failed**"
    fi
    reps=$(curl -s -o /dev/null -w "%{http_code}" -d '{"email":"peter@klaven"}' -H 'Content-Type: application/json' -H 'Accept: application/json' ${base_url}${login})
    if [ "${reps}" -eq "400" ]; then
        echo "2. POST login unsuccessful - Passed"
    else
        echo "2. POST login unsuccessful - **Failed**"
    fi
    echo
}

resources_func () {
    echo "---------------------------"
	echo "Resources Endpoint selected"
	echo "---------------------------"
    reps=$(curl -s -o /dev/null -w "%{http_code}" ${base_url}${resources})
    if [ "${reps}" -eq "200" ]; then
        echo "1. GET list resource endpoint - Passed"
    else
        echo "1. GET list resource endpoint - **Failed**"
    fi
    reps=$(curl -s -o /dev/null -w "%{http_code}" ${base_url}${resources}"/"${valid})
    if [ "${reps}" -eq "200" ]; then
        echo "2. GET single resource endpoint - Passed"
    else
        echo "2. GET single resource endpoint - **Failed**"
    fi
    reps=$(curl -s -o /dev/null -w "%{http_code}" ${base_url}${resources}"/"${invalid})
    if [ "${reps}" -eq "404" ]; then
        echo "3. GET single resource not found - Passed"
    else
        echo "3. GET single resource not found - **Failed**"
    fi
    echo
}

case "$1" in
    "${args[0]}") users_func
    ;;
    "${args[1]}") register_func
    ;;
    "${args[2]}") login_func
    ;;
    "${args[3]}") resources_func
    ;;
    "${args[4]}") echo "********************"
        echo "All Endpoints pinged"
        echo "********************"
		users_func
		register_func
		login_func
		resources_func
    ;;
esac
