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
  default     = "1.15.3"
}

variable "resources" {
  type = map(map(string))
  default = {
    limits = {
      cpu    = "100m"
      memory = "200Mi"
    }
    requests = {
      cpu    = "50m"
      memory = "128Mi"
    }
  }
  description = "Resource limits and requests for the Cert-Manager Helm release."
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