resource "kubernetes_ingress_v1" "this" {
  metadata {
    name        = var.name
    namespace   = var.namespace
    labels      = var.labels
    annotations = var.annotations
  }

  spec {
    ingress_class_name = var.ingress_class

    rule {
      http {
        path {
          path      = var.path
          path_type = "Prefix"

          backend {
            service {
              name = var.service_name
              port {
                number = var.service_port
              }
            }
          }
        }
      }
    }
  }
}
