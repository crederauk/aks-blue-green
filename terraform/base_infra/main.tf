resource "azurerm_resource_group" "aks_rg" {
  name     = "${local.name_prefix}-rg"
  location = var.location

  tags = local.common_tags
}

resource "azurerm_network_security_group" "aks_blue_snet_sg" {
  name                = "${local.name_prefix}-blue-sg"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  tags = local.common_tags
}

resource "azurerm_network_security_group" "aks_green_snet_sg" {
  name                = "${local.name_prefix}-green-sg"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  tags = local.common_tags
}

resource "azurerm_network_security_group" "aks_agw_snet_sg" {
  name                = "${local.name_prefix}-agw-sg"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name

  security_rule {
    name                       = "AllowHttpInternetToAgw"
    priority                   = 3000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowGwManagerAccess"
    priority                   = 3100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  tags = local.common_tags
}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = "${local.name_prefix}-vnet"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = [var.address_space]

  tags = local.common_tags
}

resource "azurerm_subnet" "blue_sn" {
  name                 = "${local.name_prefix}-blue-sn"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = [local.blue_sn_cidr]
}

resource "azurerm_subnet_network_security_group_association" "blue_sn_sg_association" {
  subnet_id                 = azurerm_subnet.blue_sn.id
  network_security_group_id = azurerm_network_security_group.aks_blue_snet_sg.id
}

resource "azurerm_subnet" "green_sn" {
  name                 = "${local.name_prefix}-green-sn"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = [local.green_sn_cidr]
}

resource "azurerm_subnet_network_security_group_association" "green_sn_sg_association" {
  subnet_id                 = azurerm_subnet.green_sn.id
  network_security_group_id = azurerm_network_security_group.aks_green_snet_sg.id
}

resource "azurerm_subnet" "agw_sn" {
  name                 = "${local.name_prefix}-agw-sn"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = [local.agw_sn_cidr]
}

resource "azurerm_subnet_network_security_group_association" "agw_sn_sg_association" {
  subnet_id                 = azurerm_subnet.agw_sn.id
  network_security_group_id = azurerm_network_security_group.aks_agw_snet_sg.id
}

resource "azurerm_public_ip" "aks_agw_ip" {
  name                = "${local.name_prefix}-pip"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  allocation_method   = "Dynamic"

  tags = local.common_tags
}
