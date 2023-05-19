resource "azurerm_virtual_network" "terraform-course" {
  name                = "terraform-course-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "terraform-course" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.terraform-course.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "terraform-course" {
  name                = "terraform-course-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.terraform-course.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "terraform-course" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Terraform = "true"
  }
}

resource "azurerm_network_interface_security_group_association" "terraform-course" {
  network_interface_id      = azurerm_network_interface.terraform-course.id
  network_security_group_id = azurerm_network_security_group.terraform-course.id
}

resource "azurerm_public_ip" "terraform-course" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"

  tags = {
    Terraform = "true"
  }
}

resource "azurerm_linux_virtual_machine" "terraform-course" {
  name                = "example-machine-terraform-danilo"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "TestAzureTerraform@"

  network_interface_ids = [
    azurerm_network_interface.terraform-course.id,
  ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
#   }
disable_password_authentication = false

#   os_profile {
#     computer_name  = "hostname"
#     admin_username = "testadmin"
#     admin_password = "Password1234!"
#   }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}