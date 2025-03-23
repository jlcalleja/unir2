resource "azurerm_container_registry" "acr" {
  name                  = "jlcacr"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  sku                   = "Basic"
  admin_enabled         = true
  tags                  = var.common_tags
}