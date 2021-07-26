#! /usr/bin/bash

IMAGEDATE=$1
IMAGECOMMITSH=$2

# Pull most recent image from Dockerhub
sudo docker pull akbarezeki/taskaction:dev-$IMAGEDATE-$IMAGECOMMITSH

# Check for running container 
if [ ! $(sudo docker ps -q -f name=taskactioncontainer) ]; then
    # Run container
    sudo docker run -d -p 8000:80 -p 443:443 \
        -v /etc/mnt/index.html:/usr/share/nginx/html \
        -v /etc/mnt:/usr/nginx \
        --name taskactioncontainer akbarezeki/taskaction:dev-$IMAGEDATE-$IMAGECOMMITSH
else
    #Clean up then run container
    sudo docker rm -f taskactioncontainer

    sudo docker run -d -p 8000:80 -p 443:443 \
        -v /etc/mnt/index.html:/usr/share/nginx/html \
        -v /etc/mnt:/usr/nginx \
        --name taskactioncontainer akbarezeki/taskaction:dev-$IMAGEDATE-$IMAGECOMMITSH
fi