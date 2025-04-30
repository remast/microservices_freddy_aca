resource "azurerm_container_app" "kitchen" {
  name                         = "kitchen"
  container_app_environment_id = azurerm_container_app_environment.app_container_env.id
  resource_group_name          = azurerm_resource_group.freddy.name
  revision_mode                = "Single"

  template {
    container {
      name   = "kitchen"
      image  = "ghcr.io/remast/kitchen-aca:0.2.0"
      cpu    = 0.25
      memory = "0.5Gi"

      startup_probe {
        interval_seconds        = 5
        failure_count_threshold = 3
        port                    = 8070
        path                    = "/health/readiness"
        transport               = "HTTP"
      }
      readiness_probe {
        port      = 8070
        path      = "/health/readiness"
        transport = "HTTP"
      }
      liveness_probe {
        port      = 8070
        path      = "/health/liveness"
        transport = "HTTP"
      }
    }
    min_replicas = var.min_replicas
    max_replicas = 1
  }
  ingress {
    target_port = 8070
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}
