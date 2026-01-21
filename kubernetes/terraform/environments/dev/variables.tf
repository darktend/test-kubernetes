variable "namespace_name" {
  type        = string
  default     = "nginx-dev"
  description = "Kubernetes namespace for DEV environment"
}

variable "nginx_image" {
  type        = string
  default     = "nginx:stable"
  description = "NGINX Docker image"
}

variable "replicas" {
  type        = number
  default     = 1
  description = "Number of replicas (dev = 1 for resource savings)"
}

variable "red_html_content" {
  type        = string
  description = "HTML content for RED page"
}

variable "blue_html_content" {
  type        = string
  description = "HTML content for BLUE page"
}
