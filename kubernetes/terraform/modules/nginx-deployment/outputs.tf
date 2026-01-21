output "name" {
  value       = kubernetes_deployment.this.metadata[0].name
  description = "Deployment name"
}

output "namespace" {
  value       = kubernetes_deployment.this.metadata[0].namespace
  description = "Deployment namespace"
}
