resource "helm_release" "nginx_ingress" {
  name             = "internal-ingress"
  namespace        = "ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  create_namespace = true
  values = [
    templatefile(
      "${path.module}/values.yaml.tpl",
      {
        ingress_replicas = var.ingress_replicas
        ingress_ip       = cidrhost(data.terraform_remote_state.base_infra.outputs.sn.blue.cidr, 200)
      }
    )
  ]
}
