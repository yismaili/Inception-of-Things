#!/usr/bin/env bash
set -e

DOCKER_USERNAME="yismaili"
DOCKER_PASSWORD="pass1227@"
DOCKER_REGISTRY="https://index.docker.io/v1/"

sudo docker login --username "$DOCKER_USERNAME" --password "$DOCKER_PASSWORD" $DOCKER_REGISTRY
sudo docker logout

cd ../../vagrant

if [ ! "$(sudo docker ps -q -f name=registry)" ]; then
    sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2
fi

for app in app1 app2 app3; do
    echo "Building and pushing Docker image for $app"
    sudo docker build -t localhost:5000/$app:v5 ./$app
    sudo docker push localhost:5000/$app:v5
done

for app in app1 app2 app3; do
    echo "Applying Kubernetes configuration for $app"
    sudo kubectl apply -f ${app}-deployment.yaml
    sudo kubectl apply -f ${app}-service.yaml
    sudo kubectl apply -f ${app}-ingress.yaml
done

echo "Deployment completed successfully!"
