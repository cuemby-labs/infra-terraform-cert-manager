#
# Install Cert-Manager using Helm
#

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = var.namespace_name
  }
}

resource "helm_release" "cert_manager" {
  name       = var.helm_release_name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.helm_release_version
  namespace  = var.namespace_name

  values = [file("${path.module}/values.yaml")]

  set {
    name  = "installCRDs"
    value = true
  }
}

#
# Walrus information
#

locals {
  context = var.context
}