variable "name" {
  type        = string
  description = "Namespace name"
}

variable "environment" {
  type        = string
  description = "Environment label"
}

variable "additional_labels" {
  type        = map(string)
  default     = {}
  description = "Additional labels"
}
