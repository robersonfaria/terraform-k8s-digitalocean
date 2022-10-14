resource "kubernetes_persistent_volume_claim" "mysql" {
  metadata {
    name = "wp-mysql-pvc"
    namespace = kubernetes_namespace.wordpress.metadata.0.name
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
    namespace = kubernetes_namespace.wordpress.metadata.0.name
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
