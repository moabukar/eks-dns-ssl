#!/bin/bash

# Apply the cerrt issuer-prod.yaml first

kubectl apply -f cert/issuer-prod.yaml

kubectl apply -f argo-cd/apps-argo.yml
