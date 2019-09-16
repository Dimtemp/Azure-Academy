# Lab: Use Azure Network Watcher for monitoring and troubleshooting network connectivity

## Scenario
  
Adatum Corporation wants to monitor Azure virtual network connectivity by using Azure Network Watcher.

| Resource | Location      |
|----------|---------------|
| VM1      | West Europe   |
| VM2      | East US       |
| Storage  | East US       |


### Task 1: Prepare infrastructure for Azure Network Watcher-based monitoring

1. Open Azure Portal, Cloud Shell

```powershell
$cred = Get-Credential -UserName student
# fill in Pa55w.rd1234 as the password
New-AzResourceGroup -location westeurope -name STUDENTID
New-AzVM -name STUDENTIDVM1 -credential $cred -location westeurope -Addressprefix '10.1.0.0/16' -VirtualNetworkName vnet1 -subnetname default -SubnetAddressPrefix '10.1.0.0/24'
New-AzVM -name STUDENTIDVM2 -credential $cred -location eastus -Addressprefix '10.2.0.0/16' -VirtualNetworkName vnet1 -subnetname default -SubnetAddressPrefix '10.2.0.0/24'
# fill in student as the username and Pa55w.rd1234 as the password
New-AzStorageAccount -ResourceGroupName STUDENTID -SkuName Standard_LRS -Location eastus
# fill in a unique name for the storage account. Repeat the previous command when an errormessage is shown.
```

#### Task 2: Enable Azure Network Watcher service

1. In the Azure portal, use the search text box on the **All services** blade to navigate to the **Network Watcher** blade.

2. On the **Network Watcher** blade, verify that Network Watcher is enabled in both Azure regions into which you deployed resources in the previous task and, if not, enable it.

> **Note**: Before you start this task, ensure that the deployment you started in the previous task has completed. 


#### Task 3: Establish peering between Azure virtual networks


1. In the Azure portal, navigate to the **az1010301b-vnet1** virtual network blade.

1. Select **Peerings**.

1. Create a VNet peering with the following settings:

    - Name: **europe-to-usa**

    - Virtual network: **az1010302b-vnet2**

    - Name of peering from az1010302b-vnet2 to az1010301b-vnet1: **usa-to-europe**

    - Allow virtual network access: **Enabled**

    - Allow forwarded traffic: **disabled**

    - Allow gateway transit: disabled

    > **Note**: The Azure portal allows you to configure both directions of the peering simultaneously. When using other management tools, each direction must be configured independently. 


> **Result**: After you completed this exercise, you have deployed Azure VMs, an Azure Storage account, and an Azure SQL Database instance by using Azure Resource Manager templates, enabled Azure Network Watcher service, established global peering between Azure virtual networks, and established service endpoints to an Azure Storage account and Azure SQL Database instance.


> **Result**: After you completed this exercise, you have used Azure Network Watcher to test network connectivity to an Azure VM via virtual network peering, network connectivity to Azure Storage, and network connectivity to Azure SQL Database.


### Objectives
  
After completing this lab, you will be able to:

-  Deploy Azure VMs, Azure storage accounts, and Azure SQL Database instances by using Azure Resource Manager templates

-  Use Azure Network Watcher to monitor network connectivity

