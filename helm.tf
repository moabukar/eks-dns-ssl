# NGINX Ingress Controller
resource "helm_release" "nginx" {
  name       = "nginx-ingress"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"

  create_namespace = true
  namespace        = "nginx-ingress"
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true
  namespace        = "cert-manager"

  set {
    name  = "wait-for"
    value = module.cert_manager_irsa_role.iam_role_arn
  }

  set {
    name  = "installCRDs"
    value = "true"
  }

#   set {
#     name  = "serviceAccount.annotations.eks\\.amazonaws\\.com\\/role-arn"
#     value = module.cert_manager_irsa_role.iam_role_arn
#   }

  values = [
    "${file("helm/helm_values/values-cert-manager.yaml")}"
  ]
}

# External DNS
resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"

  create_namespace = true
  namespace        = "external-dns"


  set {
    name  = "wait-for"
    value = module.external_dns_irsa_role.iam_role_arn
  }


#   set {
#     name  = "serviceAccount.annotations.eks\\.amazonaws\\.com\\/role-arn"
#     value = module.external_dns_irsa_role.iam_role_arn
#   }


  values = [
    "${file("helm/helm_values/values-external-dns.yaml")}"
  ]
}

resource "helm_release" "argocd_deploy" {
#   depends_on = [kubernetes_secret.argocd_repo_credentials]

  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.19.15"
  timeout    = "600"

  create_namespace = true

  values = [
    "${file("helm/helm_values/values-argocd.yaml")}"
  ]
}
