#!/usr/bin/env bash

# Change directory using cd before running subsequent commands
cd ../../vagrant/app1

# Start local Docker registry
sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2

# Build Docker image
sudo docker build -t localhost:5000/app1:v1 ./app1

# Push Docker image to local registry
sudo docker push localhost:5000/app1:v1

# Change back to the previous directory for the current shell session
cd ..

# Apply Kubernetes configurations
sudo kubectl apply -f app1-deployment.yaml
sudo kubectl apply -f app1-service.yaml

# Print a message
echo "you good bro!!!!"
