# terraform {
#   experiments = [module_variable_optional_attrs]
# }

variable "environment" {
    type    = string
    description = "(Required) Custom variable. This the enviorment name where the resouce group will be created."

    validation {
        condition = var.environment == "dev" || var.environment == "qa" || var.environment == "hub"  || var.environment == "uat" || var.environment == "prod"  || var.environment == "tst"
        error_message = " Invalid environment name. Should be one of these - dev,qa,hub,uat,prod,tst"
    }
}

variable "main_project" {
    type    = string
    description = "(Required) Custom variable. Main project name."
}

variable "sub_project" {
    type    = string
    description = "(Required) Custom variable. Sub project name."
}

variable "location" {
    type    = string
    description = "(Required) The Azure Region where the Function App should exist. Changing this forces a new  Function App to be created."
}

variable "resource_group_name" {
  description = "Default resource group name."
  default     = "default-resourcegroup"
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "kind" {
  description = "The Function App kind - such as FunctionApp, Linux, Container"
  default     = "FunctionApp"
}

variable "sku_tier" {
  description = "Sku tier"
  default     = "EP2"  
}

variable "sku_size" {
  description = "Sku size"
  default     = "EP2"
}

variable "os_type" {
  description = "Name of the OS"
  default     = "linux"
}

variable "app_service_plan_id" {
  description = "Name of the App service plan id"
  default     = "defaultappservice"
}

variable "storage_account_name" {
  description = "Name of the storage account"
  default     = "defaultstorageaccount"
}

variable "storage_account_primary_access_key" {
  description = "Storage account primary access key"
  default     = "defaultstorageaccountkey"
}

variable "use_32_bit_worker_process" {
  default = true  
}

variable "funcion_app_version" {
  default = "~3"
}

variable "app_settings" {  
  type        = map(string)
  default     = {}  
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned. Required if type (identity_type) is UserAssigned."
  default     = ["123"]
}

variable "identity_type" {
  description = "Specifies the identity type of the Function App. Possible values are SystemAssigned (where Azure will generate a Service Principal for you), UserAssigned where you can specify the Service Principal IDs in the identity_ids field, and SystemAssigned, UserAssigned which assigns both a system managed identity as well as the specified user assigned identities."
  default     = "SystemAssigned"
}

variable "app_scale_limit" {
  default     = 0
}

variable "dotnet_framework_version" {
  default   = "v4.0"
}

variable "elastic_instance_minimum" {
  default   = 1
}

variable "runtime_scale_monitoring_enabled" {
  default   = false
}

variable "ftps_state" {
  default   = "Disabled"
}


variable "subnet_id" {
  default   = ""
}

variable "function_app_always_on" {
  default   =  true
}

variable "log_analytics_workspace_id" {
  description = "log_analytics_workspace_id ."
  default     = ""
}

variable "enable_functionapp_diagnostic" {
  default     = false
  type        = bool
  description = "(Optional) Enable enable_functionapp_diagnostic to true if needeed of function app diagnostics"
}

variable "create_function_app_slot" {
  default     = false
  type        = bool
  description = "(Optional) Flag to see if the funciton app slot has to be created."
}

variable "site_config" {
  type = list(object({
    always_on = optional(bool)
    app_scale_limit = optional(number)
    
    cors = optional(list(object({
      allowed_origins = set(string)
      support_credentials = optional(bool)
    })))

    dotnet_framework_version = optional(string)
    elastic_instance_minimum = optional(number)
    ftps_state = optional(string)
    health_check_path = optional(string)
    http2_enabled = optional(bool)

    ip_restriction = optional(list(object({
      ip_address = optional(string)
      service_tag = optional(string)
      virtual_network_subnet_id = optional(string)
      name = optional(string)
      priority = optional(number)
      action = optional(string)
      headers = optional(list(object({
        x_azure_fdid = optional(list(string))
        x_fd_health_probe = optional(list(string))
        x_forwarded_for = optional(list(string))
        x_forwarded_host = optional(list(string))
      })))
    })))

    scm_ip_restriction = optional(list(object({
      ip_address = optional(string)
      service_tag = optional(string)
      virtual_network_subnet_id = optional(string)
      name = optional(string)
      priority = optional(number)
      action = optional(string)
      headers = optional(list(object({
        x_azure_fdid = optional(list(string))
        x_fd_health_probe = optional(list(string))
        x_forwarded_for = optional(list(string))
        x_forwarded_host = optional(list(string))
      })))
    })))

    java_version = optional(string)
    linux_fx_version = optional(string)
    min_tls_version = optional(string)
    pre_warmed_instance_count = optional(number)
    runtime_scale_monitoring_enabled = optional(bool)
    scm_type = optional(string)
    scm_use_main_ip_restriction = optional(bool)
    use_32_bit_worker_process = optional(bool)
    vnet_route_all_enabled = optional(bool)
    websockets_enabled = optional(bool)

  }))
}

variable "identity" {
  type = list(object({
    type = string
    identity_ids = optional(list(string))
  }))
}

variable "auth_settings" {
  type = list(object({
    enabled = bool
    additional_login_params = optional(string)
    allowed_external_redirect_urls = optional(string)
    default_provider = optional(string)
    issuer = optional(string)
    runtime_version = optional(string)
    token_refresh_extension_hours = optional(number)
    token_store_enabled = optional(bool)
    unauthenticated_client_action = optional(string)
    
    active_directory = optional(list(object({
      client_id = string
      client_secret = optional(string)
      allowed_audiences = optional(string)
    })))

    facebook = optional(list(object({
      app_id = string
      app_secret = string
      oauth_scopes = optional(string)
    })))

    google = optional(list(object({
      client_id = string
      client_secret = string
      oauth_scopes = optional(string)
    })))

    microsoft = optional(list(object({
      client_id = string
      client_secret = string
      oauth_scopes = optional(string)
    })))

    twitter = optional(list(object({
      consumer_key = string
      consumer_secret = string
    })))

  }))
  default = [  ]
}

variable "source_control" {
  type = list(object({
    repo_url = optional(string)
    branch = optional(string)
    manual_integration = optional(bool)
    rollback_enabled = optional(bool)
    use_mercurial = optional(bool)
  }))
  default = [ ]
}


