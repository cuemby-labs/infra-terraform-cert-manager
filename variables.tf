#
# Contextual Fields
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

#
# Cert-Manager
#

variable "namespace_name" {
  description = "Namespace where Cert-Manager will be installed."
  type        = string
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