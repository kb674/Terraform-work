variable "project_name" {}
variable "location" {}
variable "vm_count" {}
variable "vm_size" {}
variable "storage_size" {}

terraform {
    required_providers {
        azureri = {
            source  = "hashicorp/azurerm"
            version = "~> 2.46.0"
        }
    }
}

provider "azurerm" {
    features {}
}

module "infrastructure" {
    source       = "../../modules/infrastructure"
    project_name = var.project_name
    location     = var.location
    vm_count     = var.vm_count
    vm_size      = var.vm_size
    storage_size = var.storage_size
}