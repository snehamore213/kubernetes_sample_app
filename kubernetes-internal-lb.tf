resource "kubernetes_service" "internal-lb-svc" {
  metadata {
    name      = "internal-lb-svc"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.internal-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8082
    }

    type = "LoadBalancer"
  }
}

output "int_lb_status" {
  value = kubernetes_service.internal-lb-svc.status
}
