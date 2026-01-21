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
  config_path    = pathexpand("~/.kube/kind-config.yaml")
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

module "configmap_red" {
  source = "../../modules/configmap"

  name      = "nginx-red-html"
  namespace = module.namespace.name

  data = {
    "index.html" = var.red_html_content
  }

  labels = {
    app         = "nginx-red"
    component   = "configuration"
    environment = "dev"
  }
}

module "configmap_blue" {
  source = "../../modules/configmap"

  name      = "nginx-blue-html"
  namespace = module.namespace.name

  data = {
    "index.html" = var.blue_html_content
  }

  labels = {
    app         = "nginx-blue"
    component   = "configuration"
    environment = "dev"
  }
}

module "deployment_red" {
  source = "../../modules/nginx-deployment"

  name      = "nginx-red"
  namespace = module.namespace.name
  replicas  = var.replicas
  image     = var.nginx_image

  labels = {
    app         = "nginx-red"
    environment = "dev"
    component   = "web"
  }

  configmap_name = module.configmap_red.name

  selector_label_key   = "app"
  selector_label_value = "nginx-red"

  cpu_requests    = "50m"
  memory_requests = "64Mi"
  cpu_limits      = "150m"
  memory_limits   = "128Mi"
}

module "deployment_blue" {
  source = "../../modules/nginx-deployment"

  name      = "nginx-blue"
  namespace = module.namespace.name
  replicas  = var.replicas
  image     = var.nginx_image

  labels = {
    app         = "nginx-blue"
    environment = "dev"
    component   = "web"
  }

  configmap_name = module.configmap_blue.name

  selector_label_key   = "app"
  selector_label_value = "nginx-blue"

  cpu_requests    = "50m"
  memory_requests = "64Mi"
  cpu_limits      = "150m"
  memory_limits   = "128Mi"
}

module "service_red" {
  source = "../../modules/service"

  name      = "nginx-red"
  namespace = module.namespace.name
  type      = "ClusterIP"

  selector = {
    app = "nginx-red"
  }

  labels = {
    app         = "nginx-red"
    component   = "service"
    environment = "dev"
  }

  port        = 80
  target_port = 80
}

module "service_blue" {
  source = "../../modules/service"

  name      = "nginx-blue"
  namespace = module.namespace.name
  type      = "ClusterIP"

  selector = {
    app = "nginx-blue"
  }

  labels = {
    app         = "nginx-blue"
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
  type      = "ClusterIP"

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
