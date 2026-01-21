resource "kubernetes_deployment" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        (var.selector_label_key) = var.selector_label_value
      }
    }

    template {
      metadata {
        labels = var.labels
      }

      spec {
        container {
          image = var.image
          name  = "nginx"

          port {
            container_port = 80
            protocol       = "TCP"
          }

          resources {
            requests = {
              cpu    = var.cpu_requests
              memory = var.memory_requests
            }
            limits = {
              cpu    = var.cpu_limits
              memory = var.memory_limits
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 10
            period_seconds        = 10
            timeout_seconds       = 5
            failure_threshold     = 3
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 10
            timeout_seconds       = 3
            failure_threshold     = 3
          }

          volume_mount {
            name       = "html-content"
            mount_path = "/usr/share/nginx/html"
          }
        }

        volume {
          name = "html-content"
          config_map {
            name = var.configmap_name
          }
        }
      }
    }
  }
}
