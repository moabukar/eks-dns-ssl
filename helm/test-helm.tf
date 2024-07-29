# resource "helm_release" "prometheus" {
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "prometheus"

#   create_namespace = true
#   namespace        = "prometheus"
# }

## working helm chart install via TF
