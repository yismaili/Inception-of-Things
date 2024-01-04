#!/usr/bin/env bash

DOCKER_USERNAME="yismaili"
DOCKER_PASSWORD="pass1227@"
DOCKER_REGISTRY="https://index.docker.io/v1/"  # Docker Hub registry URL
# Log in to Docker Hub
sudo docker login --username "$DOCKER_USERNAME" --password "$DOCKER_PASSWORD" $DOCKER_REGISTRY

# Log out from Docker Hub (optional)
docker logout

# Check if Docker registry is already running
if [ ! "$(sudo docker ps -q -f name=registry)" ]; then
    # Start local Docker registry
    sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2
fi

cd ../confs
# Build and push Docker images
    
echo "Building and pushing Docker image for app"
sudo docker build -t localhost:5000/app:v1 ./app
sudo docker push localhost:5000/app:v1


# Apply Kubernetes configurations

echo "Applying Kubernetes configuration for $app"
sudo kubectl apply -f argoCD-deployment.yaml
sudo kubectl apply -f argoCD-service.yaml

echo "Deployment completed successfully!"
