output "action_group_ids" {
  value       = { for k, v in azurerm_monitor_action_group.group : k => v.id }
  description = "The IDs of the Monitor Action Groups."
}

output "action_group_names" {
  value       = { for k, v in azurerm_monitor_action_group.group : k => v.name }
  description = "The names of the Monitor Action Groups."
}

output "metric_alert_ids" {
  value       = { for k, v in azurerm_monitor_metric_alert.alert : k => v.id }
  description = "The IDs of the Monitor Metric Alerts."
}

output "metric_alert_names" {
  value       = { for k, v in azurerm_monitor_metric_alert.alert : k => v.name }
  description = "The names of the Monitor Metric Alerts."
}

output "activity_log_alert_ids" {
  value       = { for k, v in azurerm_monitor_activity_log_alert.main : k => v.id }
  description = "The IDs of the Monitor Activity Log Alerts."
}

output "activity_log_alert_names" {
  value       = { for k, v in azurerm_monitor_activity_log_alert.main : k => v.name }
  description = "The names of the Monitor Activity Log Alerts."
}
