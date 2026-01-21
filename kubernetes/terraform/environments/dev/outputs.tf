output "namespace" {
  value       = module.namespace.name
  description = "DEV namespace"
}

output "ingress_url" {
  value       = "http://localhost/"
  description = "URL to access Load-Balanced NGINX (DEV)"
}

output "red_service_endpoint" {
  value       = module.service_red.dns_name
  description = "Internal DNS for RED service (DEV)"
}

output "blue_service_endpoint" {
  value       = module.service_blue.dns_name
  description = "Internal DNS for BLUE service (DEV)"
}

output "lb_service_name" {
  value       = module.service_load_balancer.name
  description = "Load Balancer service name (DEV)"
}

output "lb_service_cluster_ip" {
  value       = module.service_load_balancer.cluster_ip
  description = "Load Balancer service ClusterIP (DEV)"
}
