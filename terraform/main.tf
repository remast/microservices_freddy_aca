data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "freddy" {
  name     = "rg-${var.project}-${var.stage}-${var.location}"
  location = "West Europe"
  tags = {
    project = "${var.project}"
    stage   = var.stage
  }
}

