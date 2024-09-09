locals {
  context = var.context
}

module "submodule" {
  source = "./modules/submodule"

  message = "Hello, submodule"
}

#
# Fetch Cert-Manager CRDs from the specified URL
#

data "http" "cert_manager_crds" {
  url = var.cert_manager_crds_url
}

#
# Process the CRDs
#

locals {
  crds_list = split("---", data.http.cert_manager_crds.response_body)
  crds      = [for crd in local.crds_list : yamldecode(crd) if trimspace(crd) != ""]
}

#
# Apply CRDs using the kubernetes_manifest resource
#

resource "kubernetes_manifest" "cert_manager_crds" {
  count    = length(local.crds)
  manifest = local.crds[count.index]

  lifecycle {
    ignore_changes = [manifest]
  }
}

#
# Install Cert-Manager using Helm
#

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = var.namespace_name
  }
  lifecycle {
    ignore_changes = [metadata]
  }
}

resource "helm_release" "cert_manager" {
  name       = var.helm_release_name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.helm_release_version
  namespace  = var.namespace_name

  values = [file("values.yaml")]

  set {
    name  = "installCRDs"
    value = true
  }

  lifecycle {
    ignore_changes = [
      "values[0]", # This prevents Helm from updating values unexpectedly.
    ]
  }
  
  # Ensure Helm release depends on CRDs being installed
  depends_on = [kubernetes_manifest.cert_manager_crds]
}