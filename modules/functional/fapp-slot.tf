resource "azurerm_function_app_slot" "function_app_slot"  {
  count                      = var.create_function_app_slot ? 1 : 0
  name                       = "${local.name}-staging"
  location                   = module.azure_region.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  function_app_name          = azurerm_function_app.function_app.name
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_primary_access_key
  version                    = var.funcion_app_version
  tags                       = var.tags
  app_settings               = var.app_settings
  
  dynamic identity {
    for_each = var.identity != null ? var.identity : []
    content {
      type = identity.value.type
      identity_ids = identity.value.identity_ids != null ? identity.value.identity_ids : []
    }
  }
  
  dynamic site_config {
    for_each = var.site_config != null ? var.site_config : []
    content {
      always_on                         = try(site_config.value.function_app_always_on, false)
      app_scale_limit                   = try(site_config.value.app_scale_limit, null) # Only applicable to apps on the Consumption and Premium plan.
      
      dynamic cors {
        for_each = site_config.value.cors != null ? site_config.value.cors : []
        content {
          allowed_origins = cors.value.allowed_origins # Required
          support_credentials = try(cors.support_credentials, false)
        }
      }

      dotnet_framework_version          = try(site_config.value.dotnet_framework_version, "v4.0")
      elastic_instance_minimum          = try(site_config.value.elastic_instance_minimum, null)
      ftps_state                        = try(site_config.value.ftps_state, "AllAllowed")
      health_check_path                 = try(site_config.value.health_check_path, null)
      http2_enabled                     = try(site_config.value.http2_enabled, false)

      # ip_restriction {
      #   ip_address  = "0.0.0.0/0"
      #   name = "Deny All"
      #   action = "Deny"
      #   priority = 1000
      # }

      dynamic ip_restriction {
        for_each = site_config.value.ip_restriction != null ? site_config.value.ip_restriction : []
        content {
          ip_address = try(ip_restriction.value.ip_address, null)
          service_tag = try(ip_restriction.value.service_tag, null)
          virtual_network_subnet_id = try(ip_restriction.value.virtual_network_subnet_id, null)
          name = try(ip_restriction.value.name, null)
          priority = try(ip_restriction.value.priority, 65000)
          action = try(ip_restriction.value.action, "Allow")
          dynamic "headers" {
            for_each = ip_restriction.value.headers != null ? ip_restriction.value.headers : []
            content {
              x_azure_fdid  = try(headers.value.x_azure_fdid, [])
              x_fd_health_probe = try(headers.value.x_fd_health_probe, [])
              x_forwarded_for = try(headers.value.x_forwarded_for, [])
              x_forwarded_host = try(headers.value.x_forwarded_host, [])
            }
          }
        }
      }

      # scm_ip_restriction {
      #   ip_address  = "0.0.0.0/0"
      #   name = "Deny All"
      #   action = "Deny"
      #   priority = 1000
      # }
      
      dynamic scm_ip_restriction {
        for_each = site_config.value.scm_ip_restriction != null ? site_config.value.scm_ip_restriction : []
        content {
          ip_address = try(scm_ip_restriction.value.ip_address, null)
          service_tag = try(scm_ip_restriction.value.service_tag, null)
          virtual_network_subnet_id = try(scm_ip_restriction.value.virtual_network_subnet_id, null)
          name = try(scm_ip_restriction.value.name, null)
          priority = try(scm_ip_restriction.value.priority, 65000)
          action = try(scm_ip_restriction.value.action, "Allow")
          dynamic "headers" {
            for_each = scm_ip_restriction.value.headers != null ? scm_ip_restriction.value.headers : []
            content {
              x_azure_fdid  = try(headers.value.x_azure_fdid, [])
              x_fd_health_probe = try(headers.value.x_fd_health_probe, [])
              x_forwarded_for = try(headers.value.x_forwarded_for, [])
              x_forwarded_host = try(headers.value.x_forwarded_host, [])
            }
          }
        }
      }

      java_version = try(site_config.value.java_version, null)
      linux_fx_version = try(site_config.value.linux_fx_version, null)
      min_tls_version  = try(site_config.value.min_tls_version)
      pre_warmed_instance_count = try(site_config.value.pre_warmed_instance_count, null)
      runtime_scale_monitoring_enabled  = try(site_config.value.runtime_scale_monitoring_enabled, false)
      scm_type = try(site_config.value.scm_type, "None")
      scm_use_main_ip_restriction = try(site_config.value.scm_use_main_ip_restriction, false)
      use_32_bit_worker_process         = try(site_config.value.use_32_bit_worker_process, true)  
      vnet_route_all_enabled  = try(site_config.value.vnet_route_all_enabled, false)
      websockets_enabled = try(site_config.value.websockets_enabled, false)
    }
  }

}