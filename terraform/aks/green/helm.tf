resource "helm_release" "nginx_ingress" {
  # depends_on       = [azurerm_role_assignment.aks_to_sn_role, azurerm_role_assignment.aks_to_vnet_role]
  name             = "internal-ingress"
  namespace        = "ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  create_namespace = true
  version          = var.nginx_chart_version
  timeout          = 900

  values = [
    templatefile(
      "${local.templates_dir}/values.yaml.tpl",
      {
        ingress_replicas = var.ingress_replicas
        ingress_ip       = local.ingress_ip
      }
    )
  ]
}
