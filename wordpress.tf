resource "kubernetes_service" "wordpress" {
  metadata {
    name      = "wordpress"
    namespace = kubernetes_namespace.wordpress.metadata.0.name
    labels = {
      app = "wordpress"
    }
  }
  spec {
    port {
      port = 80
    }
    selector = {
      app  = "wordpress"
      tier = "frontend"
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "wordpress" {
  metadata {
    name      = "wordpress"
    namespace = kubernetes_namespace.wordpress.metadata.0.name
    labels = {
      app = "wordpress"
    }
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "wordpress"
      }
    }
    template {
      metadata {
        labels = {
          app  = "wordpress"
          tier = "frontend"
        }
      }
      spec {
        container {
          image = "wordpress:${var.wordpress_version}-apache"
          name  = "wordpress"

          env {
            name  = "WORDPRESS_DB_HOST"
            value = "mysql"
          }

          env {
            name = "WORDPRESS_DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql.metadata.0.name
                key  = "password"
              }
            }
          }

          env {
            name  = "WORDPRESS_DB_USER"
            value = "wordpress"
          }

          env {
            name  = "WORDPRESS_DB_NAME"
            value = "wordpress"
          }

          port {
            container_port = 80
            name           = "wordpress"
          }

          volume_mount {
            name       = "wordpress-persistent-storage"
            mount_path = "/var/www/html"
          }

          # liveness_probe {
          #   http_get {
          #     path = "/"
          #     port = 80
          #   }
          # }
        }

        volume {
          name = "wordpress-persistent-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.wordpress.metadata.0.name
          }
        }
      }
    }
  }
}
