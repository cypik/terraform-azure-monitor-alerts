provider "azurerm" {
  features {
  }
}

module "resource_group" {
  source      = "cypik/resource-group/azure"
  version     = "1.0.1"
  name        = "app11"
  environment = "tested"
  location    = "North Europe"
}

module "azmonitor-action-groups" {
  source      = "./../.."
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
          email_address           = "yadavxxxxxxxgmail.com"
          use_common_alert_schema = "true"
        },
        {
          name                    = "test"
          email_address           = "yadavxxxxxxxxxxxgmail.com"
          use_common_alert_schema = "true"
        }
      ]
    }
  }
}
