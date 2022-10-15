resource "kubernetes_service" "mysql" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.wordpress.metadata.0.name
    labels = {
      app = "wordpress"
    }
  }
  spec {
    port {
      port = 3306
    }
    selector = {
      app  = "wordpress"
      tier = "mysql"
    }
    cluster_ip = "None"
  }
}

resource "kubernetes_deployment" "mysql" {
  metadata {
    name      = "mysql"
    namespace = kubernetes_namespace.wordpress.metadata.0.name
    labels = {
      service = "apps"
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
          tier = "mysql"
        }
      }
      spec {
        container {
          image = "mysql:${var.mysql_version}"
          name  = "mysql"

          env {
            name = "MYSQL_ROOT_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql.metadata.0.name
                key  = "root_password"
              }
            }
          }

          env {
            name = "MYSQL_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql.metadata.0.name
                key  = "password"
              }
            }
          }

          env {
            name  = "MYSQL_USER"
            value = "wordpress"
          }

          env {
            name  = "MYSQL_DATABASE"
            value = "wordpress"
          }

          port {
            container_port = 3306
            name           = "mysql"
          }

          volume_mount {
            name       = "mysql-persistent-storage"
            mount_path = "/var/lib/mysql"
          }

          liveness_probe {
            exec {
              command = ["mysqladmin", "-uroot", "-p${var.mysql_root_password}", "ping"]
            }
          }
        }

        volume {
          name = "mysql-persistent-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.mysql.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_secret" "mysql" {
  metadata {
    name      = "mysql-pass"
    namespace = kubernetes_namespace.wordpress.metadata.0.name
  }

  data = {
    password = var.mysql_password
    root_password = var.mysql_root_password
  }
}
