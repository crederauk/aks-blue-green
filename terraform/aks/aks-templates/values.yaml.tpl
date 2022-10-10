controller:
  replicaCount: ${ingress_replicas}
  minAvailable: ${ingress_replicas}
  service: 
    externalTrafficPolicy: "Local"
    annotations:
      service.beta.kubernetes.io/azure-load-balancer-internal: "true"
      service.beta.kubernetes.io/azure-load-balancer-health-probe-request-path: "/healthz"
    loadBalancerIP: ${ingress_ip}