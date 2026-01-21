resource "kubernetes_service" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }

  spec {
    type     = var.type
    selector = var.selector

    port {
      port        = var.port
      target_port = var.target_port
      protocol    = "TCP"
    }
  }
}
