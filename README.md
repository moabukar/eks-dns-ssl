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

## User access

- Create a new user in access entry in the EKS section
- The ARN will be your user so `arn:aws:iam::<>:root`, use standard type and group name admin and give it 2 policies
  - AmazonEKSAdminPolicy & AmazonEKSClusterAdminPolicy
- Now try to access the cluster with `kubectl get pods` or `kubectl get nodes`
- Also attach IAM policy for ext-dns and cert-man to role `arn:aws:sts::<>>:assumed-role/default-eks-node-group-20240818104140997500000003/i-0e0725623b20012d7`

- Give user EKSAdmin & EKSClusterAdmin Policy

```

## Platform Applications

### NGINX

```bash
## NGINX Ingress

kubectl create ns nginx-ingress
helm install nginx-ingress nginx-stable/nginx-ingress -n nginx-ingress

```

### Cert Manager

```bash
helm install cert-manager jetstack/cert-manager --namespace cert-manager --version v1.15.1 --create-namespace --set installCRDs=true --values helm/helm_values/values-cert-manager.yaml

kubectl apply -f k8s/issuer-prod.yaml ## setup issuer for certs via cert-manager
```

## External DNS

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install external-dns bitnami/external-dns \
  --create-namespace \
  --namespace external-dns \
  --values helm/helm_values/values-external-dns.yaml

```

## ArgoCD Deployment

```bash
helm repo add argo-cd https://argoproj.github.io/argo-helm


helm install argo-cd argo-cd/argo-cd \
  --namespace argo-cd \
  --create-namespace \
  --version 5.19.15 \
  --values helm/helm_values/values-argocd.yaml

## Get Argo initial admin pass
alias argopass="kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 --decode"

Login:
user: admin
pass: via secret above
```

### Additional app deployment

The App Hub

```bash

kubectl apply -f k8s/app-hub.yml

--- wait for cert-manager to create DNS and also for externalDNS to add your records on Route53
Then access it below:

https://the-app-hub.lab.moabukar.co.uk/
```

## TODO

- Use private clusters (and VPN on top to securely access it)
- Add ArgoCD [X]
- Fix Helm provider integration with K8s for Helm installation via TF to work.
- Add more platform resources (like external secrets, kyverno, seret gen, argocd image updater etc)

![alt text](./ingresss)


### For troubleshooting

- in case you install argocd/cert-man in wrong namespace, delete CRDs

```bash
kubectl delete crd applications.argoproj.io applicationsets.argoproj.io appprojects.argoproj.io

kubectl delete crd certificaterequests.cert-manager.io certificates.cert-manager.io challenges.acme.cert-manager.io clusterissuers.cert-manager.io issuers.cert-manager.io orders.acme.cert-manager.io

Note: if you cannot delete a challenge, edit the challenge via `kubectl edit` and remove the finalizer line. 

and install ArgoCD again

```
