#! /usr/bin/bash

# Pull most recent image from Dockerhub
sudo docker pull akbarezeki/taskaction:dev-${{ steps.tagstep.outputs.today }}-${{ steps.tagstep.outputs.commitsh }}

# Inspect if taskactioncontainer
sudo docker container inspect taskactioncontainer > /dev/null 2>&1

# Check for running container 
if [ $? == 1 ]; then
    # Cleanup
    sudo docker rm -f taskactioncontainer
    # Run Container
    sudo docker run -d -p 8000:80 -p 443:443 \
        -v /etc/mnt/index.html:/usr/share/nginx/html \
        -v /etc/mnt/nginx.conf:/usr/nginx \
        -v /etc/mnt:/usr/nginx/ssl \
        --name taskactioncontainer akbarezeki/taskaction:dev-${{ steps.tagstep.outputs.today }}-${{ steps.tagstep.outputs.commitsh }}
else
    sudo docker run -d -p 8000:80 -p 443:443 \
        -v /etc/mnt/index.html:/usr/share/nginx/html \
        -v /etc/mnt/nginx.conf:/usr/nginx \
        -v /etc/mnt:/usr/nginx/ssl \
        --name taskactioncontainer akbarezeki/taskaction:dev-${{ steps.tagstep.outputs.today }}-${{ steps.tagstep.outputs.commitsh }}
fi