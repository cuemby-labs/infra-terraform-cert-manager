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
      cert_manager_request_memory = var.resources["cert_manager"]["requests"]["memory"],
      cert_manager_limits_memory  = var.resources["cert_manager"]["limits"]["memory"],
      cert_manager_request_cpu    = var.resources["cert_manager"]["requests"]["cpu"],
      cert_manager_limits_cpu     = var.resources["cert_manager"]["limits"]["cpu"],
      cainjector_request_memory   = var.resources["cainjector"]["requests"]["memory"],
      cainjector_limits_memory    = var.resources["cainjector"]["limits"]["memory"],
      cainjector_request_cpu      = var.resources["cainjector"]["requests"]["cpu"],
      cainjector_limits_cpu       = var.resources["cainjector"]["limits"]["cpu"],
      webhook_request_memory      = var.resources["webhook"]["requests"]["memory"],
      webhook_limits_memory       = var.resources["webhook"]["limits"]["memory"],
      webhook_request_cpu         = var.resources["webhook"]["requests"]["cpu"],
      webhook_limits_cpu          = var.resources["webhook"]["limits"]["cpu"]
    })
  ]
}

#
# Cert-Manager HPA
#

data "template_file" "hpa_manifest_template" {
  template = file("${path.module}/hpa.yaml.tpl")
  vars     = {
    namespace_name            = var.namespace_name,
    cert_manager              = var.helm_release_name,
    cainjector                = "${var.helm_release_name}-cainjector",
    webhook                   = "${var.helm_release_name}-webhook",
    min_replicas              = var.hpa_config.min_replicas,
    max_replicas              = var.hpa_config.max_replicas,
    target_cpu_utilization    = var.hpa_config.target_cpu_utilization,
    target_memory_utilization = var.hpa_config.target_memory_utilization
  }
}

data "kubectl_file_documents" "hpa_manifest_files" {
  content = data.template_file.hpa_manifest_template.rendered
}

resource "kubectl_manifest" "apply_manifests" {
  for_each  = data.kubectl_file_documents.hpa_manifest_files.manifests
  yaml_body = each.value

  lifecycle {
    ignore_changes = [yaml_body]
  }

  depends_on = [data.kubectl_file_documents.hpa_manifest_files]
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