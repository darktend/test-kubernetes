terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
  }
}

provider "kubernetes" {
  config_path    = pathexpand("~/.kube/config")
  config_context = "kind-kind"
}

module "namespace" {
  source = "../../modules/namespace"

  name        = var.namespace_name
  environment = "dev"

  additional_labels = {
    module = "nginx-lb"
  }
}

locals {
  html_files = {
    red  = var.red_html_content
    blue = var.blue_html_content
  }

  deployments = {
    red = {
      name           = "nginx-red"
      configmap_name = module.configmap["red"].name
    }
    blue = {
      name           = "nginx-blue"
      configmap_name = module.configmap["blue"].name
    }
  }
}

module "configmap" {
  source   = "../../modules/configmap"
  for_each = local.html_files

  name      = "nginx-${each.key}-html"
  namespace = module.namespace.name

  data = {
    "index.html" = file("${path.module}/${each.value}")
  }

  labels = {
    app         = "nginx-${each.key}"
    component   = "configuration"
    environment = "dev"
  }
}

module "deployment" {
  source   = "../../modules/nginx-deployment"
  for_each = local.deployments

  name      = each.value.name
  namespace = module.namespace.name
  replicas  = var.replicas
  image     = var.nginx_image

  labels = {
    app         = each.value.name
    environment = "dev"
    component   = "web"
  }

  configmap_name = each.value.configmap_name

  selector_label_key   = "app"
  selector_label_value = each.value.name

  cpu_requests    = "50m"
  memory_requests = "64Mi"
  cpu_limits      = "150m"
  memory_limits   = "128Mi"
}

module "service" {
  source   = "../../modules/service"
  for_each = local.deployments

  name      = each.value.name
  namespace = module.namespace.name
  type      = "ClusterIP"

  selector = {
    app = each.value.name
  }

  labels = {
    app         = each.value.name
    component   = "service"
    environment = "dev"
  }

  port        = 80
  target_port = 80
}

module "service_load_balancer" {
  source = "../../modules/service"

  name      = "nginx-lb"
  namespace = module.namespace.name
  type      = "NodePort"

  selector = {
    component = "web"
  }

  labels = {
    app         = "nginx-load-balancer"
    component   = "service"
    environment = "dev"
  }

  port        = 80
  target_port = 80
}

module "ingress" {
  source = "../../modules/ingress"

  name          = "nginx-lb-ingress"
  namespace     = module.namespace.name
  ingress_class = "nginx"

  service_name = module.service_load_balancer.name
  service_port = 80
  path         = "/"

  labels = {
    app         = "nginx-load-balancer"
    component   = "ingress"
    environment = "dev"
  }

  annotations = {
    "nginx.ingress.kubernetes.io/load-balance" = "round_robin"
  }
}
