resource "azurerm_container_app" "delivery" {
  name                         = "delivery"
  container_app_environment_id = azurerm_container_app_environment.app_container_env.id
  resource_group_name          = azurerm_resource_group.freddy.name
  revision_mode                = "Single"

  template {
    container {
      name   = "delivery"
      image  = "ghcr.io/remast/delivery-aca:0.1.0"
      cpu    = 0.5
      memory = "1.0Gi"
    }
    max_replicas = 1
    min_replicas = var.min_replicas
  }
  ingress {
    target_port      = 8050
    external_enabled = false
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}
