resource "helm_release" "argocd_deploy" {
  depends_on = [kubernetes_secret.argocd_repo_credentials]

  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.55.0"
  timeout    = "600"

  create_namespace = true

    values = [
    "${file("helm_values/values-argocd.yaml")}"
  ]
}
