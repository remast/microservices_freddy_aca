resource "azurerm_log_analytics_workspace" "app_log_analytics" {
  name                = "log-${var.project}-${var.stage}-${var.location}"
  location            = azurerm_resource_group.freddy.location
  resource_group_name = azurerm_resource_group.freddy.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "freddy_appinsights" {
  name                = "appi-${var.project}-${var.stage}-${var.location}"
  location            = azurerm_resource_group.freddy.location
  resource_group_name = azurerm_resource_group.freddy.name
  workspace_id        = azurerm_log_analytics_workspace.app_log_analytics.id
  application_type    = "web"
}

resource "azurerm_container_app_environment" "app_container_env" {
  name                               = "cae-${var.project}-${var.stage}-${var.location}"
  location                           = azurerm_resource_group.freddy.location
  resource_group_name                = azurerm_resource_group.freddy.name
  log_analytics_workspace_id         = azurerm_log_analytics_workspace.app_log_analytics.id
}