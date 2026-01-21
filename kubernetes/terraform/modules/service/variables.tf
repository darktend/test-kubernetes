variable "name" {
  type        = string
  description = "Service name"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace"
}

variable "type" {
  type        = string
  default     = "ClusterIP"
  description = "Service type (ClusterIP, NodePort, LoadBalancer)"
}

variable "selector" {
  type        = map(string)
  description = "Pod selector"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels for service"
}

variable "port" {
  type        = number
  default     = 80
  description = "Service port"
}

variable "target_port" {
  type        = number
  default     = 80
  description = "Target port on pods"
}
