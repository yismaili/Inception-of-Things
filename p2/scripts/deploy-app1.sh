#!/usr/bin/env bash

# Change directory using cd before running subsequent commands
cd ../../vagrant/app1

# Start local Docker registry
sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2

# Build Docker image
sudo docker build -t localhost:5000/app1:v1 ./app1

# Push Docker image to local registry
sudo docker push localhost:5000/app1:v1

# Change back to the previous directory
cd ../

# Print a message
echo "you good bro!!!!"

kubectl apply -f ./