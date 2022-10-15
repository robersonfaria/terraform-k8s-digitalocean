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
        storage = var.mysql_volume_size
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
        storage = var.wordpress_volume_size
      }
    }
  }
}
