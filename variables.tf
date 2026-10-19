variable "app_name" {
  description     = "Name of the application used to create the hostname"
  type            = string
  validation {
    condition     = length(var.app_name) > 0 && can(regex("^[a-zA-Z0-9-]+$", var.app_name))
    error_message = "The app_name must be a non-empty string containing only alphanumeric characters and hyphens."
  }
  nullable        = false 
}

variable "short_env" {
  type    = string
  default = "t"
}


variable "runtime_version" {
  description = "The version of the chosen runtime (e.g., '~3.9' for Python, '~14' for Node, '~7' for PowerShell,'~6.0' for Dotnet, '~11' for Java)."
  type        = string
}

variable "runtime" {
  description = "The runtime for the Function App (e.g., 'python', 'node', 'powershell', 'dotnet', 'dotnet_isolated', 'java')."
  type        = string
  validation {
    condition     = contains(["python", "node", "powershell", "dotnet_isolated", "java"], var.runtime)
    error_message = "The runtime must be one of 'python', 'node', 'dotnet_isolated', 'java' or 'powershell'."
  }
}


variable "resource_group_name" {
  description     = "Name of resource group where function app will be deployed"
  type            = string
  default         = ""
}

variable "location" {
  type    = string
  default = "westeurope"
}



variable "os_type" {
  description     = "Specify the O/S type for the App Services to be hosted in this plan"
  type            = string 
  validation {
    condition     = contains(["Windows", "Linux", "WindowsContainer"], var.os_type)
    error_message = "Valid values for var: os_type are (Windows , Linux, WindowsContainer)."
  }
  default         = "Linux"
}


variable "website_contentovervnet" {
  description     = "Set to '1' to enable function app access to the Azure Files content share over a VNet. "
  type            = number   
  default         = 1 
}



variable "purposes" {
  description = "List of purposes for the Function Apps"
  type        = list(string)
  default     = []
}

