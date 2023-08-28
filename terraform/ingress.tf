resource "helm_release" "nginx_ingress_chart" {
  name       = "nginx-ingress-controller"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "service.annotations.kubernetes\\.digitalocean\\.com/load-balancer-id"
    value = digitalocean_loadbalancer.ingress_load_balancer.id
  }
  depends_on = [
    digitalocean_loadbalancer.ingress_load_balancer,
  ]
}

resource "kubernetes_ingress_v1" "default_cluster_ingress" {
  depends_on = [
    helm_release.nginx_ingress_chart,
  ]
  metadata {
    name      = "${var.cluster_name}-ingress"
    namespace = "default"
    annotations = {
      "kubernetes.io/ingress.class"          = "nginx"
      "ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  spec {
    ingress_class_name = "nginx"
    dynamic "rule" {
      for_each = toset(var.top_level_domains)
      content {
        host = rule.value
        http {
          path {
            path = "/"
            backend {
              service {
                name = "${replace(rule.value, ".", "-")}-service"
                port {
                  number = 80
                }
              }
            }
          }
        }
      }
    }
  }
}
