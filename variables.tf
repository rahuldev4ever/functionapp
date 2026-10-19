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

variable "integration_subnet_name"{
  description     = "The subnet name to integrate to - assumed placed in the same vnet as regular subnet"
  type            = string    
  default         = ""  
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

variable "vnet_name" {
  description     = "The name of the virtual network to which to attach the subnet"
  type            = string    
  default         = ""  
}

variable "vnet_rgName" {
  description     = "The name of the resource group in which to create the subnet."
  type            = string    
  default         = ""  
}

variable "fileshare_quota"{
  description     = "Specify the maximum size of the share, in gigabytes"
  type            = number 
  default         = 50   
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

variable "storage_account_id" {
  description     = "Specifies the storage account in which to create the share."
  type            = string
  default         = ""
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

variable "storage_account_name" {
  description     = "The backend storage account name which will be used by this Function App." 
  type            = string  
}    

variable "storage_account_access_key" {
  description     = "The access key which will be used to access the backend storage account for the Function App" 
  type            = string  
}

variable "website_contentovervnet" {
  description     = "Set to '1' to enable function app access to the Azure Files content share over a VNet. "
  type            = number   
  default         = 1 
}

variable "primary_connection_string" {
  description     = "The connection string associated with the primary location."
  type            = string   
}

variable "is_manual_connection"{
  description     = "Specifies if the Private Endpoint require Manual Approval from the remote resource owner"
  type            = bool   
  default         = "false"
}

variable "service_plan_id" {
  description = "The ID of the App Service Plan within which to create this Function App."
  type        = string
}

variable "purposes" {
  description = "List of purposes for the Function Apps"
  type        = list(string)
  default     = []
}

variable "private_endpoint_name_blob" {
  description     = "Specify the name of endpoint on which dns zone group has to be checked" 
  type            = string  
}

variable "private_endpoint_name_file" {
  description     = "Specify the name of endpoint on which dns zone group has to be checked" 
  type            = string  
}

variable "zscaler_group_name" {
  description = "User can provide the value between list - admin,user,other"
  type        = string
  default     = "admin"
}
