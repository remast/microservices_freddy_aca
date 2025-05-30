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
      memory = "1Gi"
    }
    min_replicas = var.min_replicas
    max_replicas = 1
  }
  ingress {
    target_port      = 8050
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}
