resource "azurerm_container_app" "shop-frontend" {
  name                         = "shop-frontend"
  container_app_environment_id = azurerm_container_app_environment.app_container_env.id
  resource_group_name          = azurerm_resource_group.freddy.name
  revision_mode                = "Single"

  template {
    container {
      name   = "shop-frontend"
      image  = "ghcr.io/remast/shop-frontend-aca:0.2.0"
      cpu    = 0.25
      memory = "0.5Gi"
    }
    max_replicas = 1
    min_replicas = var.min_replicas
  }
  ingress {
    target_port      = 4200
    external_enabled = true
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

}

output "shop_frontend_latest_revision_fqdn" {
  value = azurerm_container_app.shop-frontend.latest_revision_fqdn
}