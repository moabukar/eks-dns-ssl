locals {
  domain = "lab.moabukar.co.uk"
  name   = "eks-lab"
  region = "eu-west-2"

  tags = {
    Environment = "sandbox"
    Project     = "EKS Lab"
    Owner       = "Mo Abz"
  }
}
