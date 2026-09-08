output "action_group_ids" {
  value       = module.azmonitor-action-group.action_group_ids
  description = "The IDs of the Monitor Action Groups."
}

output "activity_log_alert_ids" {
  value       = module.alerts.activity_log_alert_ids
  description = "The IDs of the Monitor Activity Log Alerts."
}

output "activity_log_alert_names" {
  value       = module.alerts.activity_log_alert_names
  description = "The names of the Monitor Activity Log Alerts."
}
