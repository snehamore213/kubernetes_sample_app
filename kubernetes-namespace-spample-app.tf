resource "kubernetes_namespace" "n" {
  metadata {
    name = "sample-app"
  }
}