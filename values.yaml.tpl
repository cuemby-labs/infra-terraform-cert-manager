installCRDs: true
resources:
  limits:
    cpu: ${limits_cpu}
    memory: ${limits_memory}
  requests:
    cpu: ${request_cpu}
    memory: ${request_memory}
cainjector
  resources:
    limits:
      cpu: ${limits_cpu}
      memory: ${limits_memory}
    requests:
      cpu: ${request_cpu}
      memory: ${request_memory}
webhook
  resources:
    limits:
      cpu: ${limits_cpu}
      memory: ${limits_memory}
    requests:
      cpu: ${request_cpu}
      memory: ${request_memory}