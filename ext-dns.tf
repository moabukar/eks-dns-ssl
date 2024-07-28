# External DNS
resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"

  create_namespace = true
  namespace        = "kube-system"


  set {
    name  = "wait-for"
    value = module.external_dns_irsa_role.iam_role_arn
  }


  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com\\/role-arn"
    value = module.external_dns_irsa_role.iam_role_arn
  }


  values = [
    "${file("helm_values/values-external-dns.yaml")}"
  ]
}
