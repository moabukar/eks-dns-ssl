#!/bin/bash

# Set up some variables
K8S_DIR="./k8s"

# Apply the issuer-prod.yaml first
echo "Applying issuer-prod.yaml..."
kubectl apply -f "$K8S_DIR/issuer-prod.yaml"

kubectl apply -f k8s/app-hub.yaml

echo "All resources in the k8s folder have been applied!"
