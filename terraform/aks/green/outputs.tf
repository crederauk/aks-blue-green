output "internal_ip" {
  value       = local.ingress_ip
  description = "The internal IP that will be used as a frontend for the K8s load balancer to allow ingress from AGW"
}
