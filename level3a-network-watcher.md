# Lab: Use Azure Network Watcher for monitoring and troubleshooting network connectivity

### Scenario
  
Adatum Corporation wants to monitor Azure virtual network connectivity by using Azure Network Watcher.

| Resource | Location      |
|----------|---------------|
| VM1      | West Europe   |
| VM2      | East US       |
| Storage  | East US       |


### Exercise 1: Prepare infrastructure for Azure Network Watcher-based monitoring

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


#### Task 3: Establish peering between Azure virtual networks

   > **Note**: Before you start this task, ensure that the deployment you started in the previous task has completed. 

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


#### Task 4: Establish service endpoints to an Azure Storage account

1. In the Azure portal, navigate to the **az1010301b-vnet1** virtual network blade.

1. Select **Service endpoints**.

1. Add a service endpoint with the following settings:

    - Service: **Microsoft.Storage**

    - Subnets: **subnet0**

1. In the Azure portal, navigate to the **az1010301b-RG** resource group blade.

1. From the **az1010301b-RG** resource group blade, navigate to the blade of the storage account included in the resource group. 

1. From the storage account blade, navigate to its **Firewalls and virtual networks** blade.

1. From the **Firewalls and virtual networks** blade of the storage account, configure the following settings:

    - Allow access from: **Selected networks**

    - Virtual networks: 

        - VIRTUAL NETWORK: **europe**

            - SUBNET: **subnet0**

    - Firewall: 

        - ADDRESS RANGE: none

    - Exceptions: 

        - Allow trusted Microsoft services to access this storage account: **Enabled**

        - Allow read access to storage logging from any network: **Disabled**

        - Allow read access to storage metrics from any network: **Disabled**

1. In the Azure portal, navigate to the **az1010301b-RG** resource group blade.

1. From the **az1010301b-RG** resource group blade, navigate to the **az1010301b** Azure SQL Server blade. 

1. From the Azure SQL Server blade, navigate to its server's **Firewalls and virtual networks** blade.

1. From the **Firewalls and virtual networks** blade of the Azure SQL Database server, configure the following settings:

    - Allow access to Azure services: **ON**

    - No firewall rules configured 

    - Virtual networks:

        - Name: **az1010301b-vnet1**

        - Subscription: the name of the subscription you are using in this lab

        - Virtual network: **az1010301b-vnet1**

        - Subnet name: **subnet0/ 10.203.0.0/24**

> **Result**: After you completed this exercise, you have deployed Azure VMs, an Azure Storage account, and an Azure SQL Database instance by using Azure Resource Manager templates, enabled Azure Network Watcher service, established global peering between Azure virtual networks, and established service endpoints to an Azure Storage account and Azure SQL Database instance.


### Exercise 2: Use Azure Network Watcher to monitor network connectivity
  
The main tasks for this exercise are as follows:

1. Test network connectivity to an Azure VM via virtual network peering by using Network Watcher

1. Test network connectivity to an Azure Storage account by using Network Watcher

1. Test network connectivity to an Azure SQL Database by using Network Watcher


#### Task 1: Test network connectivity to an Azure VM via virtual network peering by using Network Watcher

1. In the Azure portal, navigate to the **Network Watcher** blade.

1. From the **Network Watcher** blade, navigate to the **Connection troubleshoot**.

1. On the **Network Watcher - Connection troubleshoot** blade, initiate a check with the following settings:

    - Source: 

        - Subscription: the name of the Azure subscription you are using in this lab

        - Resource group: **az1010301b-RG**

        - Source type: **Virtual machine**

        - Virtual machine: **az1010301b-vm1**

    - Destination: **Specify manually**

        - URI, FQDN or IPv4: **10.203.16.4**

      > **Note**: **10.203.16.4** is the private IP address of the second Azure VM az1010302b-vm1 which you deployed to another Azure region

    - Probe Settings:

        - Protocol: **TCP**

        - Destination port: **3389**

    - Advanced settings:

        - Source port: blank

1. Wait until results of the connectivity check are returned and verify that the status is **Reachable**. Review the network path and note that the connection was direct, with no intermediate hops in between the VMs.

    > **Note**: If this is the first time you are using Network Watcher, the check can take up to 5 minutes.


#### Task 2: Test network connectivity to an Azure Storage account by using Network Watcher

1. From the Azure Portal, start a PowerShell session in the Cloud Shell. 

   > **Note**: If this is the first time you are launching the Cloud Shell in the current Azure subscription, you will be asked to create an Azure file share to persist Cloud Shell files. If so, accept the defaults, which will result in creation of a storage account in an automatically generated resource group.

1. In the Cloud Shell pane, run the following command to identify the IP address of the blob service endpoint of the Azure Storage account you provisioned in the previous exercise:

   ```pwsh
   [System.Net.Dns]::GetHostAddresses($(Get-AzStorageAccount -ResourceGroupName 'az1010301b-RG')[0].StorageAccountName + '.blob.core.windows.net').IPAddressToString
   ```

1. Note the resulting string and, from the **Network Watcher - Connection troubleshoot** blade, initiate a check with the following settings:

    - Source: 

        - Subscription: the name of the Azure subscription you are using in this lab

        - Resource group: **az1010301b-RG**

        - Source type: **Virtual machine**

        - Virtual machine: **az1010301b-vm1**

    - Destination: **Specify manually**

        - URI, FQDN or IPv4: the IP address of the blob service endpoint of the storage account you identified in the previous step of this task

    - Probe Settings:

        - Protocol: **TCP**

        - Destination port: **443**

    - Advanced settings:

        - Source port: blank

1. Wait until results of the connectivity check are returned and verify that the status is **Reachable**. Review the network path and note that the connection was direct, with no intermediate hops in between the VMs, with minimal latency. 

    > **Note**: The connection takes place over the service endpoint you created in the previous exercise. To verify this, you will use the **Next hop** tool of Network Watcher.

1. From the **Network Watcher - Connection troubleshoot** blade, navigate to the **Network Watcher - Next hop** blade and test next hop with the following settings:

    - Subscription: the name of the Azure subscription you are using in this lab

    - Resource group: **az1010301b-RG**

    - Virtual machine: **az1010301b-vm1**

    - Network interface: **az1010301b-nic1**

    - Source IP address: **10.203.0.4**

    - Destination IP address: the IP address of the blob service endpoint of the storage account you identified earlier in this task

1. Verify that the result identifies the next hop type as **VirtualNetworkServiceEndpoint**

1. From the **Network Watcher - Connection troubleshoot** blade, initiate a check with the following settings:

    - Source: 

        - Subscription: the name of the Azure subscription you are using in this lab

        - Resource group: **az1010302b-RG**

        - Source type: **Virtual machine**

        - Virtual machine: **az1010302b-vm2**

    - Destination: **Specify manually**

        - URI, FQDN or IPv4: the IP address of the blob service endpoint of the storage account you identified earlier in this task

    - Probe Settings:

        - Protocol: **TCP**

        - Destination port: **443**

    - Advanced settings:

        - Source port: blank

1. Wait until results of the connectivity check are returned and verify that the status is **Reachable**. 

    > **Note**: The connection is successful, however it is established over Internet. To verify this, you will use again the **Next hop** tool of Network Watcher.

1. From the **Network Watcher - Connection troubleshoot** blade, navigate to the **Network Watcher - Next hop** blade and test next hop with the following settings:

    - Subscription: the name of the Azure subscription you are using in this lab

    - Resource group: **az1010302b-RG**

    - Virtual machine: **az1010302b-vm2**

    - Network interface: **az1010302b-nic1**

    - Source IP address: **10.203.16.4**

    - Destination IP address: the IP address of the blob service endpoint of the storage account you identified earlier in this task

1. Verify that the result identifies the next hop type as **Internet**



> **Result**: After you completed this exercise, you have used Azure Network Watcher to test network connectivity to an Azure VM via virtual network peering, network connectivity to Azure Storage, and network connectivity to Azure SQL Database.


### Objectives
  
After completing this lab, you will be able to:

-  Deploy Azure VMs, Azure storage accounts, and Azure SQL Database instances by using Azure Resource Manager templates

-  Use Azure Network Watcher to monitor network connectivity


