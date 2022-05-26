resource "kubernetes_service" "external-lb-service" {
  metadata {
    name      = "external-lb-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.external-app-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}


output "lb_status" {
value = kubernetes_service.external-lb-service.status
}
