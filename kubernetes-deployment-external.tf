resource "kubernetes_deployment" "external-app-deployment" {
  metadata {
    name = "external-app-deployment"
    labels = {
      App = "external-app-deployment"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 120
    selector {
      match_labels = {
        App = "external-app-deployment"
      }
    }
    template {
      metadata {
        labels = {
          App = "external-app-deployment"
        }
      }
      spec {
        container {
          image = "snehamore213/externalui"
          name  = "external-uic"
          env {
            name = "SERVER"
            #             value: 'http://34.122.171.52'
            value = 'http://internal-lb-svc'
          }
          port {
            container_port = '8080'
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
