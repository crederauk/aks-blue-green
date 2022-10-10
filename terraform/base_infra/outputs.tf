output "sn" {
  value = {
    blue = {
      id   = azurerm_subnet.blue_sn.id
      cidr = azurerm_subnet.blue_sn.address_prefixes[0]
    }
    green = {
      id   = azurerm_subnet.green_sn.id
      cidr = azurerm_subnet.green_sn.address_prefixes[0]
    }
    agw = {
      id   = azurerm_subnet.agw_sn.id
      cidr = azurerm_subnet.agw_sn.address_prefixes[0]
    }
  }
}

output "aks_rg" {
  value = {
    location = azurerm_resource_group.aks_rg.location
    name     = azurerm_resource_group.aks_rg.name
  }
}

output "agw_pip_id" {
  value = azurerm_public_ip.aks_agw_ip.id
}
