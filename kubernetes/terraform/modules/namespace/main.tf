resource "kubernetes_namespace" "this" {
  metadata {
    name = var.name
    
    labels = merge(
      {
        environment = var.environment
        managed-by  = "terraform"
      },
      var.additional_labels
    )
  }
}
