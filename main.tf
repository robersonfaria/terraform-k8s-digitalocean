terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    endpoint                    = "sfo3.digitaloceanspaces.com"
    key                         = "infra/terraform.tfstate"
    bucket                      = "terraform-k8s-digitalocean"
    region                      = "us-west-1"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}

provider "digitalocean" {
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "do-nyc1-challenge"
}

resource "kubernetes_namespace" "wordpress" {
  metadata {
    name = var.namespace
  }
}