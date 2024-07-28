# Cert Manager
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true
  namespace        = "kube-system"


  set {
    name  = "wait-for"
    value = module.cert_manager_irsa_role.iam_role_arn
  }


  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com\\/role-arn"
    value = module.cert_manager_irsa_role.iam_role_arn
  }


  values = [
    "${file("helm_values/values-cert-manager.yaml")}"
  ]
}
