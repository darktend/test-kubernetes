variable "name" {
  type        = string
  description = "Ingress name"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace"
}

variable "ingress_class" {
  type        = string
  default     = "nginx"
  description = "Ingress class"
}

variable "service_name" {
  type        = string
  description = "Backend service name"
}

variable "service_port" {
  type        = number
  default     = 80
  description = "Backend service port"
}

variable "path" {
  type        = string
  default     = "/"
  description = "HTTP path"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels"
}

variable "annotations" {
  type        = map(string)
  default     = {}
  description = "Annotations"
}
