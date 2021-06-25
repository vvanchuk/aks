provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "aksvn" {
  name                = "aksvn"
  address_space       = ["10.52.0.0/16"]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_group" "sg" {
  name                = "acceptSG1"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowAll_In_TCP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowAll_Out_TCP"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}

resource "azurerm_subnet" "aksnvn_sna" {
  name                 = "${azurerm_virtual_network.aksvn.name}-sna"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aksvn.name
  address_prefixes     = ["10.52.0.0/24"]
}

resource "azurerm_subnet" "aksnvn_snb" {
  name                 = "${azurerm_virtual_network.aksvn.name}-snb"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aksvn.name
  address_prefixes     = ["10.52.1.0/24"]
}

resource "azurerm_subnet" "aksnvn_snc" {
  name                 = "${azurerm_virtual_network.aksvn.name}-snc"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aksvn.name
  address_prefixes     = ["10.52.2.0/24"]
}


output "aksvn_id" {
  value = azurerm_virtual_network.aksvn.id
}

output "aksnc_sn_id" {
  value = azurerm_subnet.aksnvn_snb.id
}