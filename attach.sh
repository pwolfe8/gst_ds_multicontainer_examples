#!/bin/bash

# CONTAINER_NAME=`cat .env  | grep CONTAINER_NAME | awk -F "=" '{print $2}'`
CONTAINER_NAME=$1
DIFF_USER=$2
echo "attaching to container $CONTAINER_NAME..."
if [ -z "$DIFF_USER" ]; then
  docker exec -it $CONTAINER_NAME /bin/bash 
else
  docker exec -it --user $DIFF_USER $CONTAINER_NAME sh -c "cd /home/$DIFF_USER/ && /bin/bash"  
fi