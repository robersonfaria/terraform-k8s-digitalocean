terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
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
  host  = digitalocean_kubernetes_cluster.kubernetes_cluster.kube_config.0.host
  token = digitalocean_kubernetes_cluster.kubernetes_cluster.kube_config.0.token

  client_certificate     = base64decode(digitalocean_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(digitalocean_kubernetes_cluster.kubernetes_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.kubernetes_cluster.kube_config.0.cluster_ca_certificate)
}
