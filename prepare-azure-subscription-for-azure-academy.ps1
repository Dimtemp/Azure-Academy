<#
This script provisions a subscription for use by the Azure Academy.

It manages these topics:
- Permissions
- Alerts
- Resource Groups


Requirements
- Azure subscription using MSDN or Pay-as-you-go or better (free trial isn't eligible for a quota increase, max 4 vCPU, no support ).

Check: Quota upgrades required? Subscription, Usage + Quotas

#>

#init
$location = 'westeurope'
$studentNames = 'name1', 'name2', 'name3'


# subscriptions, role assign, contributor (mag geen policies maken, owner niet noodzakelijk)


# create policy, vm sku, standard_ds2_v3
# create policy, allowed resource types


#alerts
#https://docs.microsoft.com/bs-latn-ba/azure/cost-management/tutorial-acm-create-budgets
#https://docs.microsoft.com/en-us/powershell/module/azurerm.consumption/New-AzureRmConsumptionBudget?view=azurermps-6.13.0
New-AzureRmConsumptionBudget -Amount 60 -Name PSBudget -Category Cost -StartDate 2019-01-01 -EndDate 2020-01-01 -TimeGrain Monthly

#resource groups
$studentNames | foreach { New-AzResourceGroup -Location $location -Name $_ }
