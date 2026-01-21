output "name" {
  value       = kubernetes_config_map.this.metadata[0].name
  description = "ConfigMap name"
}

output "namespace" {
  value       = kubernetes_config_map.this.metadata[0].namespace
  description = "ConfigMap namespace"
}
