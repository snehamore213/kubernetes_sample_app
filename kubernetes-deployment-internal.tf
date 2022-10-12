resource "kubernetes_deployment" "internal-deployment" {
  metadata {
    name = "internal-deployment"
    labels = {
      App = "internal-deployment"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 120
    selector {
      match_labels = {
        App = "internal-deployment"
      }
    }
    template {
      metadata {
        labels = {
          App = "internal-deployment"
        }
      }
      spec {
        container {
          image = "snehamore213/internalui:v1"
          name  = "internal"

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
