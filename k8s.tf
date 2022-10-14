resource "kubernetes_namespace" "wordpress" {
  metadata {
    name = var.namespace
  }
}

resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
  name    = var.cluster_name
  region  = var.region
  version = var.cluster_version

  vpc_uuid = digitalocean_vpc.kubernetes_cluster.id

  node_pool {
    name       = "default-pool"
    size       = var.default_node_instances_size
    auto_scale = false
    node_count = var.default_node_instances_quantity
  }
}
