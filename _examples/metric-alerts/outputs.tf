output "action_group_ids" {
  value       = module.azmonitor-action-groups.action_group_ids
  description = "The IDs of the Monitor Action Groups."
}

output "metric_alert_ids" {
  value       = module.azmonitor-metric-alerts.metric_alert_ids
  description = "The IDs of the Monitor Metric Alerts."
}

output "metric_alert_names" {
  value       = module.azmonitor-metric-alerts.metric_alert_names
  description = "The names of the Monitor Metric Alerts."
}
