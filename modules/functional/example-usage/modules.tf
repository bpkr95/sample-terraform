module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = ">=6"

  azure_region = var.azure_region
}

module "functionapp" {
  source = "../"

  location                            = module.azure_region.location
  environment                         = var.environment
  main_project                        = var.main_project
  sub_project                         = var.sub_project
  resource_group_name                 = var.resource_group_name
  app_service_plan_id                 = var.app_service_plan_id
  storage_account_name                = var.storage_account_name
  storage_account_primary_access_key  = var.storage_account_primary_access_key
  app_settings                        = var.app_settings
  site_config                         = var.site_config
  identity                            = var.identity
  create_function_app_slot            = var.create_function_app_slot
  tags                                = merge(var.tags, var.specific_tags)
}