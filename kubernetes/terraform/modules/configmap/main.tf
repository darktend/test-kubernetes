resource "kubernetes_config_map" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }

  data = var.data
}
