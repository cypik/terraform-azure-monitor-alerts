provider "azurerm" {
  features {
  }
}

module "resource_group" {
  source      = "git::https://github.com/opz0/terraform-azure-resource-group.git?ref=v1.0.0"
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
          email_address           = "yxxxxxxxxxxx@gmail.com"
          use_common_alert_schema = "true"
        },
        {
          name                    = "test"
          email_address           = "yadaxxxxxxxxxxxxxxgmail.com"
          use_common_alert_schema = "true"
        }
      ]
    }
  }
}
