resource "kubernetes_service_v1" "tf-wcg-service" {
  metadata {
    name = "tf-wcg-service"
  }
  spec {
    selector = {
      app = var.app_name
    }
    port {
      port        = var.port
      target_port = var.target_port
    }
  }
}

resource "kubernetes_pod" "wcg-pod" {
  metadata {
    name = var.app_name
    labels = {
      app = var.app_name
    }
  }

  spec {
    container {
      image = var.image_name
      name  = "wcg-pod"
    }
  }
}