module "resource_group" {
  source                       = "../resourcegroup"
  environment                  = var.environment
  location                     = var.location
  main_project                 = var.main_project
  sub_project                  = var.sub_project
  tags                         = merge(var.tags, var.specific_tags)
}

module "function_app" {
#   source                              = "git::git@ssh.dev.azure.com:v3/cloud/loud-modules/functionapp?ref=feature/refactor-modules"
  source                              = "../functionapp"
  location                            = var.location
  environment                         = var.environment
  main_project                        = var.main_project
  sub_project                         = var.sub_project
  resource_group_name                 = module.resource_group.name

#   app_service_plan_id                 = module.app_service_plan.app_service_id
#   storage_account_name                = module.storage_account.storage_account_name
#   storage_account_primary_access_key  = module.storage_account.storage_primary_access_key

  app_service_plan_id                 = var.app_service_id
  storage_account_name                = var.storage_account_name
  storage_account_primary_access_key  = var.storage_primary_access_key

  app_settings                        = local.app_settings
  site_config                         = local.site_config
  identity                            = var.identity
  create_function_app_slot            = var.create_function_app_slot
  tags                                = merge(var.tags, var.specific_tags)

}
