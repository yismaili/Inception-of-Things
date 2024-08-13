#!/usr/bin/env bash
set -e

DOCKER_USERNAME="yismaili"
DOCKER_PASSWORD="pass1227@"
DOCKER_REGISTRY="https://index.docker.io/v1/"

 docker login --username "$DOCKER_USERNAME" --password "$DOCKER_PASSWORD" $DOCKER_REGISTRY
 docker logout

# cd ../../vagrant

if [ ! "$( docker ps -q -f name=registry)" ]; then
     docker run -d -p 5000:5000 --restart=always --name registry registry:2
fi

cd ../confs

for app in app1 app2 app3; do
    echo "Building and pushing Docker image for $app"
     docker build -t localhost:5000/$app:v5 ./$app
     docker push localhost:5000/$app:v5
done

for app in app1 app2 app3; do
    echo "Applying Kubernetes configuration for $app"
     kubectl apply -f ${app}-deployment.yaml
     kubectl apply -f ${app}-service.yaml
     kubectl apply -f ${app}-ingress.yaml
done

echo "Deployment completed successfully!"
