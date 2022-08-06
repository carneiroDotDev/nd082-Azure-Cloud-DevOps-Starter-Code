# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
You will find in this project a complete template to deploy a customizable, scalable web server in Azure using Terraform and Packer.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Getting Started
0. Clone this repository

1. Be sure you have the needed Dependencies installed (see above)

2. Fill the variables values on the file `packer.vars.json`

3. Fill the missing variables also in `variables.tf`

### Instructions
1. Have a look on the file named `azurepolicy.rules.json`

2. Deploy the policy with `packer build -var-file=packer.vars.json server.json`

3. `terraform plan -out solution.plan` shall give an overview about the infrastructure to be build.

4. `terraform apply` will create the whole infrastructure in Azure

5. `terraform destroy` will destroy the whole infrastructure

### Output
> This is how the output of `terraform show` will look like after deployment:

```sh
# azurerm_availability_set.main:
resource "azurerm_availability_set" "main" {
    id                           = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/p1-availability-set"
    location                     = "southcentralus"
    managed                      = true
    name                         = "p1-availability-set"
    platform_fault_domain_count  = 3
    platform_update_domain_count = 5
    resource_group_name          = "Azuredevops"
    tags                         = {
        "Project" = "1"
    }
}

# azurerm_lb.main:
resource "azurerm_lb" "main" {
    id                   = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/p1-load-balancer"
    location             = "southcentralus"
    name                 = "p1-load-balancer"
    private_ip_addresses = []
    resource_group_name  = "Azuredevops"
    sku                  = "Basic"
    sku_tier             = "Regional"
    tags                 = {
        "Project" = "1"
    }

    frontend_ip_configuration {
        id                            = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/p1-load-balancer/frontendIPConfigurations/p1-load-balancer-frontend-ip"
        inbound_nat_rules             = []
        load_balancer_rules           = []
        name                          = "p1-load-balancer-frontend-ip"
        outbound_rules                = []
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/publicIPAddresses/p1-public-ip"
    }
}

# azurerm_lb_backend_address_pool.main:
resource "azurerm_lb_backend_address_pool" "main" {
    backend_ip_configurations = []
    id                        = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/p1-load-balancer/backendAddressPools/backend-address-pool"
    inbound_nat_rules         = []
    load_balancing_rules      = []
    loadbalancer_id           = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/p1-load-balancer"
    name                      = "backend-address-pool"
    outbound_rules            = []
}

# azurerm_linux_virtual_machine.main[0]:
resource "azurerm_linux_virtual_machine" "main" {
    admin_password                  = (sensitive value)
    admin_username                  = "adminuser"
    allow_extension_operations      = true
    availability_set_id             = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/P1-AVAILABILITY-SET"
    computer_name                   = "p1-vm0"
    disable_password_authentication = false
    encryption_at_host_enabled      = false
    extensions_time_budget          = "PT1H30M"
    id                              = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/p1-vm0"
    location                        = "southcentralus"
    max_bid_price                   = -1
    name                            = "p1-vm0"
    network_interface_ids           = [
        "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/p1-network-interface0",
    ]
    patch_mode                      = "ImageDefault"
    platform_fault_domain           = -1
    priority                        = "Regular"
    private_ip_address              = "10.0.2.4"
    private_ip_addresses            = [
        "10.0.2.4",
    ]
    provision_vm_agent              = true
    public_ip_addresses             = []
    resource_group_name             = "Azuredevops"
    secure_boot_enabled             = false
    size                            = "Standard_D2s_v3"
    source_image_id                 = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/FirstProjectImage"
    tags                            = {
        "Project" = "1"
    }
    virtual_machine_id              = "58929f69-6b36-46a1-98aa-bbdace4ca2fe"
    vtpm_enabled                    = false

    os_disk {
        caching                   = "ReadWrite"
        disk_size_gb              = 30
        name                      = "p1-vm0_disk1_d0a5cd6e5cb64b35a9ef3ae65e300eb9"
        storage_account_type      = "Standard_LRS"
        write_accelerator_enabled = false
    }
}

# azurerm_linux_virtual_machine.main[1]:
resource "azurerm_linux_virtual_machine" "main" {
    admin_password                  = (sensitive value)
    admin_username                  = "adminuser"
    allow_extension_operations      = true
    availability_set_id             = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/availabilitySets/P1-AVAILABILITY-SET"
    computer_name                   = "p1-vm1"
    disable_password_authentication = false
    encryption_at_host_enabled      = false
    extensions_time_budget          = "PT1H30M"
    id                              = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/virtualMachines/p1-vm1"
    location                        = "southcentralus"
    max_bid_price                   = -1
    name                            = "p1-vm1"
    network_interface_ids           = [
        "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/p1-network-interface1",
    ]
    patch_mode                      = "ImageDefault"
    platform_fault_domain           = -1
    priority                        = "Regular"
    private_ip_address              = "10.0.2.5"
    private_ip_addresses            = [
        "10.0.2.5",
    ]
    provision_vm_agent              = true
    public_ip_addresses             = []
    resource_group_name             = "Azuredevops"
    secure_boot_enabled             = false
    size                            = "Standard_D2s_v3"
    source_image_id                 = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/FirstProjectImage"
    tags                            = {
        "Project" = "1"
    }
    virtual_machine_id              = "aad802f0-1672-4631-8a03-e83208798463"
    vtpm_enabled                    = false

    os_disk {
        caching                   = "ReadWrite"
        disk_size_gb              = 30
        name                      = "p1-vm1_disk1_37f0fc85567045e5a5bd1921f7e26327"
        storage_account_type      = "Standard_LRS"
        write_accelerator_enabled = false
    }
}

# azurerm_managed_disk.main[0]:
resource "azurerm_managed_disk" "main" {
    create_option                 = "Empty"
    disk_iops_read_only           = 0
    disk_iops_read_write          = 500
    disk_mbps_read_only           = 0
    disk_mbps_read_write          = 60
    disk_size_gb                  = 1
    id                            = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/disks/p10-disk"
    location                      = "southcentralus"
    max_shares                    = 0
    name                          = "p10-disk"
    on_demand_bursting_enabled    = false
    public_network_access_enabled = true
    resource_group_name           = "Azuredevops"
    storage_account_type          = "Standard_LRS"
    tags                          = {
        "Project" = "1"
    }
    trusted_launch_enabled        = false
}

# azurerm_managed_disk.main[1]:
resource "azurerm_managed_disk" "main" {
    create_option                 = "Empty"
    disk_iops_read_only           = 0
    disk_iops_read_write          = 500
    disk_mbps_read_only           = 0
    disk_mbps_read_write          = 60
    disk_size_gb                  = 1
    id                            = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/disks/p11-disk"
    location                      = "southcentralus"
    max_shares                    = 0
    name                          = "p11-disk"
    on_demand_bursting_enabled    = false
    public_network_access_enabled = true
    resource_group_name           = "Azuredevops"
    storage_account_type          = "Standard_LRS"
    tags                          = {
        "Project" = "1"
    }
    trusted_launch_enabled        = false
}

# azurerm_network_interface.main[0]:
resource "azurerm_network_interface" "main" {
    applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    id                            = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/p1-network-interface0"
    internal_domain_name_suffix   = "xhcl3vdomrzuppmqoldbzgke2a.jx.internal.cloudapp.net"
    location                      = "southcentralus"
    name                          = "p1-network-interface0"
    private_ip_address            = "10.0.2.4"
    private_ip_addresses          = [
        "10.0.2.4",
    ]
    resource_group_name           = "Azuredevops"
    tags                          = {
        "Project" = "1"
    }

    ip_configuration {
        name                          = "internal"
        primary                       = true
        private_ip_address            = "10.0.2.4"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/p1-network/subnets/internal"
    }
}

# azurerm_network_interface.main[1]:
resource "azurerm_network_interface" "main" {
    applied_dns_servers           = []
    dns_servers                   = []
    enable_accelerated_networking = false
    enable_ip_forwarding          = false
    id                            = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/p1-network-interface1"
    internal_domain_name_suffix   = "xhcl3vdomrzuppmqoldbzgke2a.jx.internal.cloudapp.net"
    location                      = "southcentralus"
    name                          = "p1-network-interface1"
    private_ip_address            = "10.0.2.5"
    private_ip_addresses          = [
        "10.0.2.5",
    ]
    resource_group_name           = "Azuredevops"
    tags                          = {
        "Project" = "1"
    }

    ip_configuration {
        name                          = "internal"
        primary                       = true
        private_ip_address            = "10.0.2.5"
        private_ip_address_allocation = "Dynamic"
        private_ip_address_version    = "IPv4"
        subnet_id                     = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/p1-network/subnets/internal"
    }
}

# azurerm_network_interface_backend_address_pool_association.main[0]:
resource "azurerm_network_interface_backend_address_pool_association" "main" {
    backend_address_pool_id = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/p1-load-balancer/backendAddressPools/backend-address-pool"
    id                      = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/p1-network-interface0/ipConfigurations/internal|/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/p1-load-balancer/backendAddressPools/backend-address-pool"
    ip_configuration_name   = "internal"
    network_interface_id    = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/p1-network-interface0"
}

# azurerm_network_interface_backend_address_pool_association.main[1]:
resource "azurerm_network_interface_backend_address_pool_association" "main" {
    backend_address_pool_id = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/p1-load-balancer/backendAddressPools/backend-address-pool"
    id                      = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/p1-network-interface1/ipConfigurations/internal|/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/loadBalancers/p1-load-balancer/backendAddressPools/backend-address-pool"
    ip_configuration_name   = "internal"
    network_interface_id    = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkInterfaces/p1-network-interface1"
}

# azurerm_network_security_group.main:
resource "azurerm_network_security_group" "main" {
    id                  = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkSecurityGroups/p1-security-group"
    location            = "southcentralus"
    name                = "p1-security-group"
    resource_group_name = "Azuredevops"
    security_rule       = []
    tags                = {
        "Project" = "1"
    }
}

# azurerm_network_security_rule.rule1:
resource "azurerm_network_security_rule" "rule1" {
    access                      = "Allow"
    description                 = "description-ssh"
    destination_address_prefix  = "*"
    destination_port_range      = "22"
    direction                   = "Inbound"
    id                          = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkSecurityGroups/p1-security-group/securityRules/inboundAccessSSH"
    name                        = "inboundAccessSSH"
    network_security_group_name = "p1-security-group"
    priority                    = 100
    protocol                    = "Tcp"
    resource_group_name         = "Azuredevops"
    source_address_prefix       = "10.0.0.0/24"
    source_port_range           = "*"
}

# azurerm_network_security_rule.rule2:
resource "azurerm_network_security_rule" "rule2" {
    access                      = "Deny"
    destination_address_prefix  = "10.0.0.0/24"
    destination_port_range      = "*"
    direction                   = "Inbound"
    id                          = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/networkSecurityGroups/p1-security-group/securityRules/DenyAllInbound"
    name                        = "DenyAllInbound"
    network_security_group_name = "p1-security-group"
    priority                    = 300
    protocol                    = "*"
    resource_group_name         = "Azuredevops"
    source_address_prefix       = "*"
    source_port_range           = "*"
}

# azurerm_public_ip.main:
resource "azurerm_public_ip" "main" {
    allocation_method       = "Dynamic"
    id                      = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/publicIPAddresses/p1-public-ip"
    idle_timeout_in_minutes = 4
    ip_version              = "IPv4"
    location                = "southcentralus"
    name                    = "p1-public-ip"
    resource_group_name     = "Azuredevops"
    sku                     = "Basic"
    sku_tier                = "Regional"
    tags                    = {
        "Project" = "1"
    }
}

# azurerm_subnet.internal:
resource "azurerm_subnet" "internal" {
    address_prefixes                               = [
        "10.0.2.0/24",
    ]
    enforce_private_link_endpoint_network_policies = false
    enforce_private_link_service_network_policies  = false
    id                                             = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/p1-network/subnets/internal"
    name                                           = "internal"
    resource_group_name                            = "Azuredevops"
    virtual_network_name                           = "p1-network"
}

# azurerm_virtual_network.main:
resource "azurerm_virtual_network" "main" {
    address_space           = [
        "10.0.0.0/22",
    ]
    dns_servers             = []
    flow_timeout_in_minutes = 0
    guid                    = "d4bec4b9-646e-4773-bd90-72c61c9944e0"
    id                      = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Network/virtualNetworks/p1-network"
    location                = "southcentralus"
    name                    = "p1-network"
    resource_group_name     = "Azuredevops"
    subnet                  = []
    tags                    = {
        "Project" = "1"
    }
}

# data.azurerm_image.main:
data "azurerm_image" "main" {
    data_disk           = []
    id                  = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/FirstProjectImage"
    location            = "southcentralus"
    name                = "FirstProjectImage"
    os_disk             = [
        {
            blob_uri        = ""
            caching         = "ReadWrite"
            managed_disk_id = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops/providers/Microsoft.Compute/disks/pkrosnnaf59s3nc"
            os_state        = "Generalized"
            os_type         = "Linux"
            size_gb         = 30
        },
    ]
    resource_group_name = "Azuredevops"
    sort_descending     = false
    tags                = {
        "Project" = "1"
    }
    zone_resilient      = false
}

# data.azurerm_resource_group.main:
data "azurerm_resource_group" "main" {
    id       = "/subscriptions/055225e5-24c2-4b9b-bd53-954939e76965/resourceGroups/Azuredevops"
    location = "southcentralus"
    name     = "Azuredevops"
    tags     = {
        "DeploymentId" = "203449"
        "LaunchId"     = "1346"
        "LaunchType"   = "ON_DEMAND_LAB"
        "TemplateId"   = "1181"
        "TenantId"     = "none"
    }
}
```
