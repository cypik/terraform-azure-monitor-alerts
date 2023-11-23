provider "azurerm" {
  features {
  }
}

module "resource_group" {
  source      = "git::https://github.com/cypik/terraform-azure-resource-group.git?ref=v1.0.0"
  name        = "app"
  environment = "tested"
  location    = "North Europe"
}


module "azmonitor-action-groups" {
  source      = "./../../"
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
          name                    = "test"
          email_address           = "yadxxxxxxxxxxx@gmail.com"
          use_common_alert_schema = "false"
        },
        {
          name                    = "example"
          email_address           = "exaxxxxxxmple@gmail.com"
          use_common_alert_schema = "false"
        }
      ]
    }
  }
}

data "azurerm_monitor_action_group" "example" {
  depends_on          = [module.azmonitor-action-groups]
  resource_group_name = module.resource_group.resource_group_name
  name                = "AlertEscalationGroup"
}

data "azurerm_kubernetes_cluster" "example" {
  depends_on          = [module.resource_group]
  name                = "testing"
  resource_group_name = module.resource_group.resource_group_name
}

module "azmonitor-metric-alerts" {
  depends_on  = [data.azurerm_monitor_action_group.example, data.azurerm_kubernetes_cluster.example]
  source      = "./../../"
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
