# Install CRDs
installCRDs: true

# Cert-Manager Pod resources
resources:
  limits:
    cpu: ${cert_manager_limits_cpu}
    memory: ${cert_manager_limits_memory}
  requests:
    cpu: ${cert_manager_request_cpu}
    memory: ${cert_manager_request_memory}

# Cert-Manager cainjector Pod resources
cainjector:
  resources:
    limits:
      cpu: ${cainjector_limits_cpu}
      memory: ${cainjector_limits_memory}
    requests:
      cpu: ${cainjector_request_cpu}
      memory: ${cainjector_request_memory}

# Cert-Manager webhook Pod resources
webhook:
  resources:
    limits:
      cpu: ${webhook_limits_cpu}
      memory: ${webhook_limits_memory}
    requests:
      cpu: ${webhook_request_cpu}
      memory: ${webhook_request_memory}