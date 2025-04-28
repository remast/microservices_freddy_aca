resource "azurerm_container_app" "kitchen" {
  name                         = "kitchen"
  container_app_environment_id = azurerm_container_app_environment.app_container_env.id
  resource_group_name          = azurerm_resource_group.freddy.name
  revision_mode                = "Single"

  template {
    container {
      name   = "kitchen"
      image  = "ghcr.io/remast/kitchen-aca:0.1.0"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    max_replicas = 1
    min_replicas = var.min_replicas
  }
  ingress {
    target_port      = 8070
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}
