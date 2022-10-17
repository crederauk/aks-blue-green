resource "kubernetes_deployment" "nginx" {
  depends_on = [
    kubernetes_config_map.index_html
  ]
  metadata {
    name = "nginx-deployment"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx-deployment"
      }
    }
    template {
      metadata {
        labels = {
          app = "nginx-deployment"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "nginx-deployment"

          port {
            container_port = 80
            name           = "html"
          }
          volume_mount {
            name       = "html-file"
            mount_path = "/usr/share/nginx/html/"
          }
        }
        volume {
          name = "html-file"
          config_map {
            name = "index"
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map" "index_html" {
  depends_on = [
    helm_release.nginx_ingress
  ]
  metadata {
    name = "index"
  }

  data = {
    "index.html" = "<h1>Welcome to The ${title(local.cluster)} Cluster</h1>"
  }
}

resource "kubernetes_service" "nginx_svc" {
  depends_on = [
    kubernetes_deployment.nginx
  ]
  metadata {
    name = "nginx-svc"
  }
  spec {
    selector = {
      app = "nginx-deployment"
    }
    port {
      name        = "webserver-html"
      port        = 8080
      target_port = 80
      protocol    = "TCP"
    }
  }
}

resource "kubernetes_ingress_v1" "ingress" {
  depends_on = [
    helm_release.nginx_ingress
  ]
  metadata {
    name = "ingress"
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      http {
        path {
          backend {
            service {
              name = "nginx-svc"
              port {
                number = 80
              }
            }
          }
          path = "/"
        }
      }
    }
  }
}


