#!/bin/bash

K8S_DIR="./apps"

# Apply the issuer-prod.yaml first
echo "Applying issuer-prod.yaml..."
kubectl apply -f "$K8S_DIR/issuer-prod.yaml"

kubectl apply -f apps/app-hub.yaml

