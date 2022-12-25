#!/bin/sh

# variables
base_url_token="{{ base_url }}" # find all these...
base_url="api.foo.com" # replace with url of public rest api
host_ip_token="{{ host_ip }}" # find all these...
host_ip=$(docker-machine ip $(docker-machine active)) # replace with ip of host running NGINX

# output
echo ${base_url_token} = ${base_url}
echo ${host_ip_token} = ${host_ip}

# find and replace
sed -e "s/${base_url_token}/${base_url}/g" \
    -e "s/${host_ip_token}/${host_ip}/g" \
    < docker-compose-template.yml \
    > docker-compose.yml