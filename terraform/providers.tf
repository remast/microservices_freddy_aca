terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }

  }
  required_version = ">= 1.3"
}


provider "azurerm" {
  subscription_id = "258b0030-3486-42c7-87c7-2ace4e9e9552"
  features {
  }
}