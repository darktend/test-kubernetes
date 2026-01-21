output "name" {
  value       = kubernetes_namespace.this.metadata[0].name
  description = "Namespace name"
}

output "uid" {
  value       = kubernetes_namespace.this.metadata[0].uid
  description = "Namespace UID"
}
