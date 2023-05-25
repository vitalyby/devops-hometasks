terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.20.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }

  # backend "kubernetes" {
  #   secret_suffix = "state"
  #   config_path   = "~/.kube/config"
  # }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

provider "github" {
  token = var.token
}