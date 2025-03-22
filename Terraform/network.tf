resource "azurerm_virtual_network" "vn1" {
  name                = "jlc-vn1"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = var.common_tags
}

resource "azurerm_subnet" "subnet1" {
  name                 = "jlc-subnet1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn1.name
  address_prefixes     = ["10.0.2.0/24"]
}
