#!/usr/bin/env bash

# Exit script if any command fails
set -e


# Log in to Docker Hub
sudo docker login --username "$DOCKER_USERNAME" --password "$DOCKER_PASSWORD" $DOCKER_REGISTRY

# Log out from Docker Hub (optional)
docker logout

cd ../../vagrant

# Check if Docker registry is already running
if [ ! "$(sudo docker ps -q -f name=registry)" ]; then
    # Start local Docker registry
    sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2
fi
# test in the host machine
# cd ../confs 
# Build and push Docker images
for app in app1 app2 app3; do
    echo "Building and pushing Docker image for $app"
    sudo docker build -t localhost:5000/$app:v4 ./$app
    sudo docker push localhost:5000/$app:v4
done

# Apply Kubernetes configurations
for app in app1 app2 app3; do
    echo "Applying Kubernetes configuration for $app"
    sudo kubectl apply -f ${app}-deployment.yaml
    sudo kubectl apply -f ${app}-service.yaml
done

sudo kubectl apply -f apps-ingress.yaml

echo "Deployment completed successfully!"
