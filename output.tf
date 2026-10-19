output "function_app_principals" {
  description = "Function App names and Principal IDs."

  value = {
    for k, v in local.selected_func_apps :
    k => {
      name         = v.name
      principal_id = v.identity[0].principal_id
    }
  }
}
