# Production grade EKS cluster with DNS, Ingress & SSL (automated)

A small demo to showcase what it looks like to expose your applications into the public securely via ingress controllers combined with signed SSL certs for HTTPS. We use tools like NGINX ingress controller, cert-manager with Let's encrypt to manage our certs, externalDNS to manage our DNS provider records.

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

```bash

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=eu-west-2

tf init and tf plan/apply

aws eks --region eu-west-2 update-kubeconfig --name eks-lab

Give user EKSAdmin & EKSClusterAdmin Policy

```

## Manual install of Helm stuff

```bash
helm install nginx-ingress nginx-stable/nginx-ingress --set rbac.create=true

helm upgrade --install nginx-ingress nginx-stable/nginx-ingress \
  --timeout 600s \
  --debug
  --set controller.publishService.enabled=true

helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.15.1 --create-namespace --set installCRDs=true

kubectl apply -f k8s/issuer-prod.yaml ## setup issuer for certs via cert-manager

helm install external-dns external-dns/external-dns --namespace external-dns --create-namespace --values helm_values/values-external-dns.yaml

helm upgrade --install external-dns external-dns/external-dns --values helm_values/values-external-dns.yaml
```

## Optional (ArgoCD)

```bash
helm repo add argo-cd https://argoproj.github.io/argo-helm
helm dep update charts/argo-cd/
helm install argo-cd charts/argo-cd/

Add ingress and access via `argocd.lab.moabukar.co.uk`

Login:
user: admin
pass: (get via secret) `kubectl get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d`
```

## TODO

- Use private clusters (and VPN on top to securely access it)
- Add ArgoCD [X]
- Fix Helm provider integration with K8s for Helm installation via TF to work.
- Add more platform resources (like external secrets, kyverno, seret gen, argocd image updater etc)

![alt text](./ingresss)
