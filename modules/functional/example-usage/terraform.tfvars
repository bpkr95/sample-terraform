environment  = "tst"
main_project = "testproject"
sub_project  = "subtestproj"

resource_group_name = "test-functionapp"
app_service_plan_id = "/subscriptions/670c8f95-b9b3-42d8-a7fc-0687a18c0d30/resourceGroups/test-functionapp/providers/Microsoft.Web/serverfarms/funcappserviceplan"
storage_account_name = "testfunstoracc"
storage_account_primary_access_key = ""
app_settings = {
  "FUNCTIONS_WORKER_RUNTIME" = "python"
}
site_config = [{
  linux_fx_version = "python|3.9"
  ip_restriction = [{
    ip_address  = "0.0.0.0/0"
    name = "Deny All"
    action = "Deny"
    priority = 1000
  }]
}]

identity = [{
  type = "SystemAssigned"
}]

create_function_app_slot = true

specific_tags = {
  "Environment" = "Development"
}