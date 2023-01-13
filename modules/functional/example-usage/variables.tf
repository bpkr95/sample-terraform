variable "azure_region" {
  description = "Azure region to use."
  type        = string
  default     = "uksouth"
}

variable "environment" {
  description = "Project environment"
  type        = string
  default     = "tst"
}

variable "main_project" {
  description = "Main project"
  type        = string
  default     = ""
}

variable "sub_project" {
  description = "Sub Project"
  type        = string
  default     = ""
}

variable "tags" { default = {} }
variable "specific_tags" { default = {} }

variable "resource_group_name" {}
variable "app_service_plan_id" {}
variable "storage_account_name" {}
variable "storage_account_primary_access_key" {}
variable "app_settings" {}
variable "site_config" {}
variable "identity" {}
variable "create_function_app_slot" {}