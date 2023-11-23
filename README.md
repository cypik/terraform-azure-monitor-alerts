# terraform-azure-monitor-alerts
# Terraform Azure Infrastructure

This Terraform configuration defines an Azure infrastructure using the Azure provider.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [License](#license)

## Introduction
This module provides a Terraform configuration for deploying various Azure resources as part of your infrastructure. The configuration includes the deployment of resource groups, monitor-alerts.

## Usage
To use this module, you should have Terraform installed and configured for AZURE. This module provides the necessary Terraform configuration
for creating AZURE resources, and you can customize the inputs as needed. Below is an example of how to use this module:

# Examples

# Example: AzMonitor-ActionGroups

```hcl
module "azmonitor-action-groups" {
  source      = "git::https://github.com/cypik/terraform-azure-monitor-alerts.git?ref=v1.0.0"
  name        = "app"
  environment = "test"
  actionGroups = {
    "group1" = {
      actionGroupName      = "AlertEscalationGroup"
      actionGroupShortName = "alertesc"
      actionGroupRGName    = module.resource_group.resource_group_name
      actionGroupEnabled   = "true"
      actionGroupEmailReceiver = [
        {
          name                    = "example"
          email_address           = "yaxxxxxxxxxxxxxx@gmail.com"
          use_common_alert_schema = "true"
        },
        {
          name                    = "test"
          email_address           = "yadxxxxxxxxxxxxgmail.com"
          use_common_alert_schema = "true"
        }
      ]
    }
  }
}
```

# Example: AzMonitor-ActivityLogAlerts

```hcl
module "alerts" {
  depends_on  = [data.azurerm_monitor_action_group.example, ]
  source      = "git::https://github.com/cypik/terraform-azure-monitor-alerts.git?ref=v1.0.0"
  name        = "app"
  environment = "test"
  activity_log_alert = {
    "test1" = {
      alertname      = "vm-restart"
      alertrg        = module.resource_group.resource_group_name
      alertscopes    = [module.resource_group.resource_group_id]
      description    = "Administrative alerts for vm"
      operation_name = "Microsoft.Compute/virtualMachines/restart/action"
      actionGroupID  = data.azurerm_monitor_action_group.example.id
      category       = "Administrative"
    },
    "test2" = {
      alertname      = "vm-powerOff"
      alertrg        = module.resource_group.resource_group_name
      alertscopes    = [module.resource_group.resource_group_id]
      description    = "Administrative alerts for vm"
      operation_name = "Microsoft.Compute/virtualMachines/powerOff/action"
      actionGroupID  = data.azurerm_monitor_action_group.example.id
      category       = "Administrative"
    }
  }
}
```

# Example: AzMonitor-MetricAlerts

```hcl
module "azmonitor-metric-alerts" {
  depends_on = [data.azurerm_monitor_action_group.example, data.azurerm_kubernetes_cluster.example]
  source     = "git::https://github.com/cypik/terraform-azure-monitor-alerts.git?ref=v1.0.0"
  name        = "app"
  environment = "test"
  metricAlerts = {
    "alert1" = {
      alertName              = "testing-alert"
      alertResourceGroupName = module.resource_group.resource_group_name
      alertScopes = [
        data.azurerm_kubernetes_cluster.example.id
      ]
      alertDescription           = ""
      alertEnabled               = "true"
      dynCriteriaMetricNamespace = "Microsoft.ContainerService/managedClusters"
      dynCriteriaMetricName      = "node_cpu_usage_percentage"
      dynCriteriaAggregation     = "Average"
      dynCriteriaOperator        = "GreaterThan"
      dynCriteriathreshold       = "1"
      alertAutoMitigate          = "true"
      alertFrequency             = "PT1M"
      alertTargetResourceType    = "Microsoft.ContainerService/managedClusters"
      alertTargetResourceLoc     = data.azurerm_kubernetes_cluster.example.location
      actionGroupID              = data.azurerm_monitor_action_group.example.id
    },
    "alert2" = {
      alertName              = "testing-alert2"
      alertResourceGroupName = module.resource_group.resource_group_name
      alertScopes = [
        data.azurerm_kubernetes_cluster.example.id
      ]
      alertDescription           = ""
      alertEnabled               = "true"
      dynCriteriaMetricNamespace = "Microsoft.ContainerService/managedClusters"
      dynCriteriaMetricName      = "node_memory_working_set_percentage"
      dynCriteriaAggregation     = "Average"
      dynCriteriaOperator        = "GreaterThan"
      dynCriteriathreshold       = "1"
      alertAutoMitigate          = "true"
      alertFrequency             = "PT1M"
      alertTargetResourceType    = "Microsoft.ContainerService/managedClusters"
      alertTargetResourceLoc     = data.azurerm_kubernetes_cluster.example.location
      actionGroupID              = data.azurerm_monitor_action_group.example.id
    }

  }
}

```

This example demonstrates how to create various AZURE resources using the provided modules. Adjust the input values to suit your specific requirements.

## Module Inputs
- 'name':  The name of the Metric Alert.
- 'resource_group_name': The name of the resource group in which to create the Metric Alert instance.
- 'scopes': A set of strings of resource IDs at which the metric criteria should be applied.

## Module Outputs
- 'id':  The ID of the metric alert.

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/cypik/terraform-azure-monitor-alerts/tree/master/_examples) directory within this repository.

## License
This Terraform module is provided under the '[License Name]' License. Please see the [LICENSE](https://github.com/cypik/terraform-azure-monitor-alerts/blob/master/LICENSE) file for more details.

## Author
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.
