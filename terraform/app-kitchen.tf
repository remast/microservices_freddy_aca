resource "azurerm_container_app" "kitchen" {
  name                         = "shop-frontend"
  container_app_environment_id = azurerm_container_app_environment.app_container_env.id
  resource_group_name          = azurerm_resource_group.freddy.name
  revision_mode                = "Single"

  template {
    container {
      name   = "kitchen"
      image  = "ghcr.io/linkedinlearning/kitchen:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    max_replicas = 1
    min_replicas = 0
  }
  ingress {
    target_port      = 4200
    external_enabled = false
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}
