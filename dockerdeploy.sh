#! /usr/bin/bash

# Pull most recent image from Dockerhub
sudo docker pull akbarezeki/taskaction:dev-${{ steps.tagstep.outputs.today }}-${{ steps.tagstep.outputs.commitsh }}

# Check for running container 
if [ ! $(docker ps -q -f name=taskactioncontainer) ]; then
    # Run container
    sudo docker run -d -p 8000:80 -p 443:443 \
        -v /etc/mnt/index.html:/usr/share/nginx/html \
        -v /etc/mnt/nginx.conf:/usr/nginx \
        -v /etc/mnt:/usr/nginx/ssl \
        --name taskactioncontainer akbarezeki/taskaction:dev-${{ steps.tagstep.outputs.today }}-${{ steps.tagstep.outputs.commitsh }}
else
    #Clean up then run container
    sudo docker rm -f taskactioncontainer

    sudo docker run -d -p 8000:80 -p 443:443 \
        -v /etc/mnt/index.html:/usr/share/nginx/html \
        -v /etc/mnt/nginx.conf:/usr/nginx \
        -v /etc/mnt:/usr/nginx/ssl \
        --name taskactioncontainer akbarezeki/taskaction:dev-${{ steps.tagstep.outputs.today }}-${{ steps.tagstep.outputs.commitsh }}
fi