#!/bin/bash


## export login vars

export AWS_ACCESS_KEY_ID=<>
export AWS_SECRET_ACCESS_KEY=<>
export AWS_DEFAULT_REGION=eu-west-2

# Set up some variables
export AWS_REGION="eu-west-2"
export S3_BUCKET="eks-tfstate-mo" # Update the bucket name if different
export CLUSTER_NAME="eks-lab"

# Initialize Terraform
echo "Initializing Terraform..."
terraform init \
  -backend-config="bucket=$S3_BUCKET" \
  -backend-config="key=eks-lab" \
  -backend-config="region=$AWS_REGION" \
  -backend-config="encrypt=true"

# Apply Terraform configuration
echo "Applying Terraform configuration..."
terraform apply -auto-approve

# Get the EKS cluster name
CLUSTER_NAME=$(terraform output -raw cluster_name)

# Update kubeconfig for EKS
echo "Updating kubeconfig for EKS cluster..."
aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME


## you may need to add user perms
# Verify kubectl is connected to the correct cluster
echo "Verifying connection to Kubernetes cluster..."
kubectl get nodes

