# EKS with DNS, Ingress & SSL (automated)

- Create VPC, cluster and other AWS resources
- Deploy Helm charts for cert-man, nginx ingress controller and ext-dns
- Create test app and check ingress
- Verify TLS

## The tools

The tools we will be using in this demo are:

- Helm (K8s package manager)
- NGINX Ingress Controller (ingress management)
- Let’s Encrypt (Certificate authority)
- cert-manager (to automate certificate management)
- external-dns (automate & sync services with your DNS provider, in this case Route53)
- Add ArgoCD (optional)

## Setup

```

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=eu-west-2

tf init and tf plan/apply

```

## TODO

- Add ArgoCD
- Add more platform resources

![alt text](./ingresss)
