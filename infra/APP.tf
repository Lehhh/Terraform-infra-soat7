resource "kubernetes_deployment" "spring_boot_app" {
  metadata {
    name = var.app_name
    namespace = "default"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          name  = var.app_name
          image = var.ecr_app_image

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

# Service para expor a aplicação Spring Boot na porta 8080
resource "kubernetes_service" "spring_boot_service" {
  metadata {
    name = "lanchonete-soat7-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = var.app_name
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}