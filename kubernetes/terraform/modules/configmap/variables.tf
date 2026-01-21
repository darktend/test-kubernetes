variable "name" {
  type        = string
  description = "ConfigMap name"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace for ConfigMap"
}

variable "data" {
  type        = map(string)
  description = "ConfigMap data (key-value pairs)"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels for ConfigMap"
}
