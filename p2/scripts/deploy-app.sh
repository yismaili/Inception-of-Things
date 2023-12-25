#!/usr/bin/env bash

# Change directory 
cd ../../vagrant/app1

# Start local Docker registry
sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2

# Build Docker image
sudo docker build -t localhost:5000/app1:v1 ./app1
sudo docker push localhost:5000/app1:v1
sudo docker build -t localhost:5000/app2:v1 ./app2
sudo docker push localhost:5000/app2:v1
sudo docker build -t localhost:5000/app3:v1 ./app3
sudo docker push localhost:5000/app3:v1

# Push Docker image to local registry
cd ..

# Apply Kubernetes configurations
sudo kubectl apply -f app1-deployment.yaml
sudo kubectl apply -f app1-service.yaml
sudo kubectl apply -f app2-deployment.yaml
sudo kubectl apply -f app2-service.yaml
sudo kubectl apply -f app3-deployment.yaml
sudo kubectl apply -f app3-service.yaml

# Print a message
echo "you good bro!!!!"
