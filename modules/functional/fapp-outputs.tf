output "id" {
  description = "The ID of the Function App"
  value = azurerm_function_app.function_app.id
}

output "name" {
  description = "The name of the Function App"
  value = azurerm_function_app.function_app.name
}

output "app_service_kind" {
  description = "The Function App kind - such as functionapp,linux,container"
  value = azurerm_function_app.function_app.kind
}

output "identity_principal_id" {
  description = "The object/prinicial id when the type is SystemAssigned"
  value = azurerm_function_app.function_app.identity.0.principal_id
}

output "default_hostname" {
  description = "The object/prinicial id when the type is SystemAssigned"
  value = azurerm_function_app.function_app.default_hostname
}
