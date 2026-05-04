# 1. Grupo de Recursos
resource "azurerm_resource_group" "hospital_rg" {
  name     = var.resource_group_name
  location = var.location
  tags = { Environment = "Production", ManagedBy = "Terraform" }
}

# 2. Red Virtual (VNet)
resource "azurerm_virtual_network" "hospital_vnet" {
  name                = "VNet-Secure-IaC"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.hospital_rg.location
  resource_group_name = azurerm_resource_group.hospital_rg.name
}

# 3. Subred para el Bastion
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hospital_rg.name
  virtual_network_name = azurerm_virtual_network.hospital_vnet.name
  address_prefixes     = ["10.10.2.0/26"]
}

# 4. Subred para Máquinas Virtuales
resource "azurerm_subnet" "workload_subnet" {
  name                 = "Workload-Subnet"
  resource_group_name  = azurerm_resource_group.hospital_rg.name
  virtual_network_name = azurerm_virtual_network.hospital_vnet.name
  address_prefixes     = ["10.10.1.0/24"]
}

# 5. IP Pública para el Bastion (Requisito: SKU Standard)
resource "azurerm_public_ip" "bastion_ip" {
  name                = "IP-Bastion-IaC"
  location            = azurerm_resource_group.hospital_rg.location
  resource_group_name = azurerm_resource_group.hospital_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# 6. El Bastion Host (El túnel de seguridad)
resource "azurerm_bastion_host" "hospital_bastion" {
  name                = "Security-Bastion-IaC"
  location            = azurerm_resource_group.hospital_rg.location
  resource_group_name = azurerm_resource_group.hospital_rg.name

  ip_configuration {
    name      = "configuration"
    subnet_id = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}

