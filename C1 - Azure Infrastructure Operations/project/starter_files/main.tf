provider "azurerm" {
  features {}
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

#Check 1
data "azurerm_resource_group" "main" {
  name     = "Azuredevops"
}

#Check 2
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/22"]
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name  
  tags = {
    Project = "1"
  }
}

#Check 2
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

#Check 3
resource "azurerm_network_security_group" "main" {
  name                = "${var.prefix}-security-group"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  tags = {
    Project = "1"
  }
}

#Check 3
resource "azurerm_network_security_rule" "rule1" {
    name                       = "inboundAccessSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.0.0.0/24"
    destination_address_prefix = "*"
    description                = "description-ssh"
    resource_group_name         = data.azurerm_resource_group.main.name
    network_security_group_name = azurerm_network_security_group.main.name
  }

#Check 3
resource "azurerm_network_security_rule" "rule2" {
    name                       = "DenyAllInbound"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.0.0/24"  
    resource_group_name         = data.azurerm_resource_group.main.name
    network_security_group_name = azurerm_network_security_group.main.name
  }

#Check 4
resource "azurerm_network_interface" "main" {
  count               = var.number_of_virtual_machines
  name                = "${var.prefix}-network-interface${count.index}"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }  
  tags = {
    Project = "1"
  }
}

# Check 5
resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-public-ip"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  tags = {
    Project = "1"
  }
}

# Check 6
resource "azurerm_lb" "main" {
  name                = "${var.prefix}-load-balancer"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  frontend_ip_configuration {
    name                 = "${var.prefix}-load-balancer-frontend-ip"
    public_ip_address_id = azurerm_public_ip.main.id
  }

  tags = {
    Project = "1"
  }
}

# Check 6
resource "azurerm_lb_backend_address_pool" "main" {
  loadbalancer_id = azurerm_lb.main.id
  name            = "backend-address-pool"
}

# Check 6
resource "azurerm_network_interface_backend_address_pool_association" "main" {
  count               = var.number_of_virtual_machines
  network_interface_id    = element(azurerm_network_interface.main.*.id, count.index)
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
}

# Check 7
resource "azurerm_availability_set" "main" {
  name                = "${var.prefix}-availability-set"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  tags = {
    Project = "1"
  }
}

# Check 8
data "azurerm_image" "main" {
  name                = "FirstProjectImage"  
  resource_group_name = data.azurerm_resource_group.main.name
}

#Check 8
resource "azurerm_linux_virtual_machine" "main" {
  count                           = var.number_of_virtual_machines
  name                            = "${var.prefix}-vm${count.index}"
  resource_group_name             = data.azurerm_resource_group.main.name
  location                        = data.azurerm_resource_group.main.location
  size                            = "Standard_D2s_v3"
  admin_username                  = "${var.username}"
  admin_password                  = "${var.password}"
  disable_password_authentication = false  
  availability_set_id             = azurerm_availability_set.main.id
  network_interface_ids = [
    element(azurerm_network_interface.main.*.id, count.index),
  ]

  source_image_id = data.azurerm_image.main.id

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }  
  
  tags = {
    Project = "1"
  }
}

#Check 9
resource "azurerm_managed_disk" "main" {
  count                = var.number_of_virtual_machines
  name                 = "${var.prefix}${count.index}-disk"
  resource_group_name  = data.azurerm_resource_group.main.name
  location             = data.azurerm_resource_group.main.location
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

  tags = {
    Project = "1"
  }
}