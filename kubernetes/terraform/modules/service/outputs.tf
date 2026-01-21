output "name" {
  value       = kubernetes_service.this.metadata[0].name
  description = "Service name"
}

output "cluster_ip" {
  value       = kubernetes_service.this.spec[0].cluster_ip
  description = "Service ClusterIP"
}

output "dns_name" {
  value       = "${kubernetes_service.this.metadata[0].name}.${kubernetes_service.this.metadata[0].namespace}.svc.cluster.local"
  description = "Internal DNS name"
}
