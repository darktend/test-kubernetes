variable "name" {
  type        = string
  description = "Deployment name"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace"
}

variable "replicas" {
  type        = number
  default     = 1
  description = "Number of replicas"
}

variable "image" {
  type        = string
  default     = "nginx:stable"
  description = "Docker image"
}

variable "labels" {
  type        = map(string)
  description = "Labels for deployment and pods"
}

variable "configmap_name" {
  type        = string
  description = "ConfigMap name for mounting"
}

variable "cpu_requests" {
  type        = string
  default     = "100m"
  description = "CPU requests"
}

variable "memory_requests" {
  type        = string
  default     = "128Mi"
  description = "Memory requests"
}

variable "cpu_limits" {
  type        = string
  default     = "250m"
  description = "CPU limits"
}

variable "memory_limits" {
  type        = string
  default     = "256Mi"
  description = "Memory limits"
}

variable "selector_label_key" {
  type        = string
  description = "Label key for selector"
}

variable "selector_label_value" {
  type        = string
  description = "Label value for selector"
}
