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
$studentNames | New-AzResourceGroup -loc

