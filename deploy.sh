#!/bin/bash

HOST=my-ec2          # if using SSH config, else use ec2-user@<IP>
REMOTE_DIR=/usr/share/nginx/html

echo "Deploying to $HOST..."
rsync -avz --delete  /home/sumit-devops/projects/my-static-site/ $HOST:/home/ec2-user/my-static-site

ssh $HOST "sudo rm -rf $REMOTE_DIR/* && sudo mv /home/ec2-user/my-static-site/* $REMOTE_DIR && sudo chown -R nginx:nginx $REMOTE_DIR"

echo "Deployment complete!"
