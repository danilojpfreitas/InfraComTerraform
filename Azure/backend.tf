terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "Terraform"
      storage_account_name = "terraformbackenddanilo"
      container_name       = "backend3"
      key                  = "terraform.tfstate"
  }

}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  skip_provider_registration = "true"
  subscription_id = "3020b464-b370-4e51-bb91-64c48e5c1ad3"
  tenant_id       = "abd4a16d-59d9-4bce-afca-7bccec6cabf8"
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "terraform-course"
  location = "East US 2"
}