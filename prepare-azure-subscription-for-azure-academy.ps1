<#
This script provisions a subscription for use by the Azure Academy.

It manages these topics:
- Resource Groups
- Permissions
- Alerts
#>

#init
$location = 'westeurope'
$studentNames = 'name1', 'name2', 'name3'

#resource groups
$studentNames | foreach { New-AzResourceGroup -Location $location -Name $_ }

#alerts
#https://docs.microsoft.com/bs-latn-ba/azure/cost-management/tutorial-acm-create-budgets
#https://docs.microsoft.com/en-us/powershell/module/azurerm.consumption/New-AzureRmConsumptionBudget?view=azurermps-6.13.0
New-AzureRmConsumptionBudget -Amount 60 -Name PSBudget -Category Cost -StartDate 2019-01-01 -EndDate 2020-01-01 -TimeGrain Monthly
