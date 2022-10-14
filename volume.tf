resource "kubernetes_persistent_volume_claim" "mysql" {
  metadata {
    name = "wp-mysql-pvc"
    namespace = var.namespace
  }
  spec {
    access_modes     = ["ReadWriteOnce"]
    storage_class_name = "do-block-storage"
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "wordpress" {
  metadata {
    name = "wp-wordpress-pvc"
    namespace = var.namespace
  }
  spec {
    access_modes     = ["ReadWriteOnce"]
    storage_class_name = "do-block-storage"
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}
