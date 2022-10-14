resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
  name    = "challenge"
  region  = "nyc1"
  version = "1.24.4-do.0"

  node_pool {
    name       = "default-pool"
    size       = "s-1vcpu-2gb"
    auto_scale = false
    node_count = 2
  }
}
