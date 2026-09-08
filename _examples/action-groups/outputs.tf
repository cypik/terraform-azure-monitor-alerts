output "action_group_ids" {
  value       = module.azmonitor-action-groups.action_group_ids
  description = "The IDs of the Monitor Action Groups."
}

output "action_group_names" {
  value       = module.azmonitor-action-groups.action_group_names
  description = "The names of the Monitor Action Groups."
}
