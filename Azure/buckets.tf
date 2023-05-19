resource "azurerm_storage_account" "example" {
  name                     = "terraformtestdanilo"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Terraform = "true"
  }
}

resource "azurerm_storage_container" "example" {
  count                 = length(var.container)
  name                  = "${var.container[count.index]}"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}