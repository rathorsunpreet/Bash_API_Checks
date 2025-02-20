#!/bin/bash

# API variables
# Use jq for json variables
base_url='https://reqres.in'
users='/api/users'
resources='/api/unknown'
register='/api/register'
login='/api/login'
valid='2'
invalid='23'
delayed='3'
post_users='{"name":"morpheus","job":"leader"}'
others_api='{"name":"morpheus","job":"zion resident"}'
post_register_pass='{"email":"eve.holt@reqres.in","password":"pistol"}'
post_register_fail='{"email":"sydney@fife"}'
post_login_pass='{"email":"eve.holt@reqres.in","password":"cityslicka"}'
post_login_fail='{"email":"peter@klaven"}'