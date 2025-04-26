resource "azurerm_container_app" "order" {
  name                         = "order"
  container_app_environment_id = azurerm_container_app_environment.app_container_env.id
  resource_group_name          = azurerm_resource_group.freddy.name
  revision_mode                = "Single"

  template {
    container {
      name   = "order"
      image  = "ghcr.io/remast/order-aca:0.1.0"
      cpu    = 0.5
      memory = "1.0Gi"
      env {
        name  = "DELIVERY_SERVICE_URL"
        value = "http://delivery"
      }
      env {
        name  = "KITCHEN_SERVICE_URL"
        value = "http://kitchen"
      }
    }
    max_replicas = 1
    min_replicas = var.min_replicas
  }
  ingress {
    target_port      = 8060
    external_enabled = false
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}
