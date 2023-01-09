locals {
   resource_groups = merge(module.resource_groups, module.resource_group_reused)
   appserviceplans = module.appservice_plan
   appinsights = module.app_insights
   mysqlservers = module.mysql_server
}

