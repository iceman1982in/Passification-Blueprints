# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
       version = "~> 3.0"
    }
  }

 backend "azurerm" {
    storage_account_name = "[[tf_storageacct]]"
    container_name       = "[[tf_containername]]"
    key                  = "[[tf_key]]"
	  access_key           = "[[tf_storagekey]]"
	}
}


provider "azurerm" {
 features {  } 
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id  
}

provider "azurerm" {
 features { }
  alias           = "core-sub"
  subscription_id = var.subscription_core_id
  tenant_id       = var.tenant_id  
}

