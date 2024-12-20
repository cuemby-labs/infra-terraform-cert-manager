#
# Cert-Manager
#

variable "namespace_name" {
  description = "Namespace where Cert-Manager will be installed."
  type        = string
  default     = "cert-manager"
}

variable "helm_release_name" {
  description = "Name for the Cert-Manager Helm release."
  type        = string
  default     = "cert-manager"
}

variable "helm_release_version" {
  description = "Version of the Cert-Manager Helm chart."
  type        = string
  default     = "1.16.2"
}

variable "resources" {
  description = "Resource limits and requests for Harbor Helm release."
  type        = map(object({
    limits = object({
      cpu    = string
      memory = string
    })
    requests = object({
      cpu    = string
      memory = string
    })
  }))

  default = {
    cert_manager = {
      limits = {
        cpu    = "100m"
        memory = "100Mi"
      }
      requests = {
        cpu    = "50m"
        memory = "50Mi"
      }
    }
    cainjector = {
      limits = {
        cpu    = "100m"
        memory = "100Mi"
      }
      requests = {
        cpu    = "50m"
        memory = "50Mi"
      }
    }
    webhook = {
      limits = {
        cpu    = "100m"
        memory = "100Mi"
      }
      requests = {
        cpu    = "50m"
        memory = "50Mi"
      }
    }
  }
}

variable "hpa_config" {
  description = "Configuration for the HPA targeting All Cert-Manager Deployments"
  type        = object({
    min_replicas              = number
    max_replicas              = number
    target_cpu_utilization    = number
    target_memory_utilization = number
  })

  default = {
    min_replicas              = 1
    max_replicas              = 3
    target_cpu_utilization    = 80
    target_memory_utilization = 80
  }
}

#
# Walrus Contextual Fields
#

variable "context" {
  description = <<-EOF
Receive contextual information. When Walrus deploys, Walrus will inject specific contextual information into this field.

Examples:
```
context:
  project:
    name: string
    id: string
  environment:
    name: string
    id: string
  resource:
    name: string
    id: string
```
EOF
  type        = map(any)
  default     = {}
}