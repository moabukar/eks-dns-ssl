terraform {
  backend "s3" {
    bucket  = "eks-tfstate-mo" # Update the bucket name
    key     = "eks-lab"
    region  = "eu-west-2"
    encrypt = true
  }


  required_version = ">= 1.0"


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6"
    }
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}


# Configure the Helm provider
# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks.cluster_id
# }

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
    # token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
