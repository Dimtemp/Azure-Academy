# Lab: VNet connectivity and VNet Peering

### Scenario

Adatum Corporation wants to implement connectivity between Azure virtual networks in its Azure subscription. 

|ResourceGroup|VNet|VM|IP Address|Location|
|-------------|----|--|----------|--------|
|StudentID1|VNET1|VM1|10.1.0.4|westeurope|
|StudentID2|VNET2|VM2|10.2.0.4|east us|



#### Task 1: Create the first virtual network using the portal

1. In the Azure portal, in the lefthand column, click Virtual Networks.

1. Click **Add** to open the **Create virtual network** wizard.

1. Create a virtual network using this information:

- Name: STUDENTID-VNET1
- Address space: 10.1.0.0/16
- Resource group, Create new: STUDENTID
- Address range: 10.1.0.0/24

1. Click Create to create the virtual network.

#### Task 2: Create the second virtual network using PowerShell

1. In the Azure Portal, start a Cloud Shell

1. 

```powershell
$Name = 'STUDENTID'
New-AzResourceGroup -Name "$($Name)2" -Location westeurope
New-AzVirtualNetwork -Name "$($Name)2" -Location westeurope -ResourceGroupName "$($Name)2" -Addressprefix '10.2.0.0/16'
```

> **Note**: Do not wait for the deployment to complete but proceed to the next task. You will use the network and the virtual machines included in this deployment in the second exercise of this lab.


#### Task 2: Create the second virtual network in the same region hosting a single Azure VM by using an Azure Resource Manager template

1. In the Azure portal, navigate to the **Create a resource** blade.

1. From the **Create a resource** blade, search Azure Marketplace for **Template deployment**.


   > **Note**: Do not wait for the deployment to complete but proceed to the next task. You will use the network and the virtual machines included in this deployment in the second exercise of this lab.

> **Result**: After you completed this exercise, you have created two Azure virtual networks and initiated deployments of two Azure Virtual Machines.


#### Task 1: Verify non-connectivity

1. Log on to the first VM using RDP.

1. Open PowerShell.

1. Run ipconfig.exe.

1. Identify the private ip address. It should be starting with a 10.

1. Log on to the second VM using RDP.

1. Open PowerShell.

1. Run the following command, where <remoteip> should be replaced with the IP address you identified on the first VM.
  ```console
  ping <remoteip>
  ```

1. For example:
  ```console
  ping 10.1.0.4
  ```
  
1. The ping request should not arrive on the remote VM. That's because the virtual networks are not connected.


#### Task 1: Configure VNet peering
  
1. In the Azure portal, navigate to the **az1000401-vnet1** virtual network blade.

1. From the **az1000401-vnet1** virtual network blade, display its **Peerings** blade.

1. From the **az1000401-vnet1 - Peerings** blade, click **+ Add** to create a VNet peering with the following settings:

    - Name: **az1000401-vnet1-to-az1000402-vnet2**

    - Virtual network deployment model: **Resource manager**

    - Subscription: the name of the Azure subscription you are using in this lab

    - Virtual network: **az1000402-vnet2**

    - Name of peering from az1000402-vnet2 to az1000401-vnet1: **az1000402-vnet2-to-az1000401-vnet1**

    - Allow virtual network access: **Enabled**

    - Allow forwarded traffic: **disabled**

    - Allow gateway transit: **disabled**

> **Note**: Because you have administrative access to both virtual networks, the portal is configuring both directions (from vnet1 to vnet2, AND vnet2 to vnet1) in a single action. From the CLI, PowerShell, or REST API, these tasks must be performed independently. 




### Exercise 3: Validating service chaining

The main tasks for this exercise are as follows:

1. Configure Windows Firewall with Advanced Security on the target Azure VM

1. Test service chaining between peered virtual networks


#### Task 1: Configure Windows Firewall with Advanced Security on the target Azure VM

1. In the Azure portal, navigate to the blade of the **az1000401-vm1** Azure VM. 

1. From the **Overview** pane of the **az1000401-vm1** blade, generate an RDP file and use it to connect to **az1000401-vm1**.

1. When prompted, authenticate by specifying the following credentials:

    - User name: **Student**

    - Password: **Pa55w.rd1234**

1. Within the Remote Desktop session to **az1000401-vm1**, open the **Windows Firewall with Advanced Security** console and enable **File and Printer Sharing (Echo Request - ICMPv4-In)** inbound rule for all profiles.




After completing this lab, you will be able to:

- Create Azure virtual networks and deploy Azure VM by using Azure Resource Manager templates.

- Configure VNet peering.

