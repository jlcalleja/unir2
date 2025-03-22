# Crear una IP pública para la VM
resource "azurerm_public_ip" "pip" {
  name                = "jlc-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

# Crear la NIC con IP pública asociada
resource "azurerm_network_interface" "nic1" {
  name                = "jlc-nic1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
  
  tags = var.common_tags
}

# Crear la máquina virtual
resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "jlc-vm1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B2ls_v2"
  admin_username      = "jlc"
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]
  disable_password_authentication = true

  admin_ssh_key {
    username   = "jlc"
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "ubuntu-pro"
    version   =  "latest"
  }

  tags = var.common_tags
}