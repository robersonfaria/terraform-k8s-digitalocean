resource "digitalocean_vpc" "kubernetes_cluster" {
  name     = "k8s-network"
  region   = var.region
  ip_range = "10.118.0.0/20"
}