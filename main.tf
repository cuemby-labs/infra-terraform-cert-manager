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

  values = [
    templatefile("${path.module}/values.yaml.tpl", {
      request_memory = var.resources["requests"]["memory"],
      limits_memory  = var.resources["limits"]["memory"],
      request_cpu    = var.resources["requests"]["cpu"],
      limits_cpu     = var.resources["limits"]["cpu"]
    })
  ]

  # set {
  #   name  = "installCRDs"
  #   value = true
  # }

  # set {
  #   name  = "resources.requests.memory"
  #   value = var.resources["requests"]["memory"]
  # }

  # set {
  #   name  = "resources.limits.memory"
  #   value = var.resources["limits"]["memory"]
  # }

  # set {
  #   name  = "resources.requests.cpu"
  #   value = var.resources["requests"]["cpu"]
  # }

  # set {
  #   name  = "resources.limits.cpu"
  #   value = var.resources["limits"]["cpu"]
  # }
}

#
# Walrus information
#

locals {
  context = var.context
}

module "submodule" {
  source = "./modules/submodule"

  message = "Hello, submodule"
}