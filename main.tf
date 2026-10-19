// ---------------------------------------------------------------------------
// Local Values
// Sets up naming conventions based on app_name, environment and other inputs
// ---------------------------------------------------------------------------
locals {
  funcapp_names = length(var.purposes) > 0 ? {
    for purpose in var.purposes :
    purpose => "${var.app_name}-${purpose}-${var.short_env}-manes"
  } : {
    "default" = "${var.app_name}-${var.short_env}-manes"
  }


  selected_func_apps = var.os_type == "Linux" ? azurerm_linux_function_app.funcAppLin : azurerm_windows_function_app.funcAppWin
}

// --------------------------------------------
// Resource : Function app  
// Creation of function app that runs on linux
// --------------------------------------------
resource "azurerm_linux_function_app" "funcAppLin" {
  for_each = var.os_type == "Linux" ? local.funcapp_names : {}

  name                                     = local.funcapp_names[each.key]
  resource_group_name                      = var.resource_group_name
  location                                 = var.location
  public_network_access_enabled            = true
  
  https_only                               = true
  ftp_publish_basic_authentication_enabled = false



  site_config {
    always_on = true

    application_stack {
      node_version            = var.runtime == "node" ? var.runtime_version : null
      python_version          = var.runtime == "python" ? var.runtime_version : null
      dotnet_version          = var.runtime == "dotnet_isolated" ? var.runtime_version : null
      java_version            = var.runtime == "java" ? var.runtime_version : null
      powershell_core_version = var.runtime == "powershell" ? var.runtime_version : null
      use_dotnet_isolated_runtime = var.runtime == "dotnet_isolated" ? true : false
    }
  }



  lifecycle {
    ignore_changes = [app_settings, tags]
  }
}

// --------------------------------------------
// Resource : Function app  
// Creation of function app that runs on windows
// --------------------------------------------
resource "azurerm_windows_function_app" "funcAppWin" {
  for_each = var.os_type == "Windows" ? local.funcapp_names : {}

  name                          = local.funcapp_names[each.key]
  resource_group_name           = var.resource_group_name
  location                      = var.location
  public_network_access_enabled = true
  https_only                    = true
  ftp_publish_basic_authentication_enabled = false

  

  site_config {
    always_on = true

    application_stack {
      node_version            = var.runtime == "node" ? var.runtime_version : null
      dotnet_version          = var.runtime == "dotnet_isolated" ? var.runtime_version : null
      java_version            = var.runtime == "java" ? var.runtime_version : null
      powershell_core_version = var.runtime == "powershell" ? var.runtime_version : null
      use_dotnet_isolated_runtime = var.runtime == "dotnet_isolated" ? true : false
    }
  }


  lifecycle {
    ignore_changes = [app_settings, tags]
  }
}

