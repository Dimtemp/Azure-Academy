# Lab: VNet connectivity and VNet Peering

### Scenario

Adatum Corporation wants to implement connectivity between Azure virtual networks in its Azure subscription. 

|ResourceGroup|VNet|VM|IP Address|Location|
|-------------|----|--|----------|--------|
|StudentID1|VNET1|VM1|10.1.0.4|West Europe|
|StudentID2|VNET2|VM2|10.2.0.4|East US|


#### Task 1: Create the first virtual network using the portal

1. In the Azure portal, in the lefthand column, click **Virtual Networks**.

1. Click **Add** to open the **Create virtual network** wizard.

1. Create a virtual network using this information (leave all other settings at their default values):

- Name: VNET1
- Address space: 10.1.0.0/16
- Resource group, Create new: StudentID1 (for example: Peter1)
- Location: West Europe
- Address range: 10.1.0.0/24

1. Click Create to create the virtual network.


#### Task 2: Create the second virtual network using PowerShell

1. In the Azure Portal, start a Cloud Shell

1. Run the following commands:

```powershell
$id = 'StudentID'   # replace this with your own, unique ID, for example: $id = 'Peter'
New-AzResourceGroup -Name "$($id)2" -Location eastus
New-AzVirtualNetwork -Name vnet2 -Location eastus -ResourceGroupName "$($id)2" -Addressprefix '192.168.0.0/16'
```


#### Task 3: Create virtual machines in both virtual networks

1. With the Cloud Shell still open, run the following commands:

```powershell
$username = 'Student'
$password = 'Pa55w.rd1234'

#run
$securePassword = ConvertTo-SecureString $password  -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

New-AzVM -Name VM1 -Credential $cred -ResourceGroupName "$($id)1" -VirtualNetworkName vnet1 -Location westeurope
New-AzVM -Name VM2 -Credential $cred -ResourceGroupName "$($id)2" -VirtualNetworkName vnet2 -Location eastus

 -Addressprefix '10.2.0.0/16' -subnetname default -SubnetAddressPrefix '10.2.0.0/24'
```

> **Result**: After you completed this task, you have created two Azure virtual networks and initiated deployments of two Azure Virtual Machines.


#### Task 4: Configure Windows Firewall on the target Azure VM

1. In the Azure portal, in the lefthand column, click **Virtual Machines**.

1. Select **VM1** to open the VM1 blade.

1. Use the Connect button in the top to connect to the VM using RDP.

1. Use the credentials you specified using the PowerShell command's in the previous task.

1. When logged on to the VM, click Start, Administrative Tools and start **Windows Firewall with Advanced Security**.

1. Select Inbound Rules and enable **File and Printer Sharing (Echo Request - ICMPv4-In)** inbound rule.

1. Open a Windows PowerShell console.

1. Run ipconfig.exe.

1. Identify the private ip address. It should be starting with 192.

1. Minimize the RDP session using the minimize button in the top bar of the RDP session.


#### Task 5: Verify non-connectivity

1. In the Azure portal, in the lefthand column, click **Virtual Machines**.

1. Select **VM2** to open the VM1 blade.

1. Use the Connect button in the top to connect to the VM using RDP.

1. Use the credentials you specified using the PowerShell command's in the previous task.

1. When logged on to the VM, open a Windows PowerShell console.

1. Ping the first VM using the following command, where <remoteip> should be replaced with the IP address you identified on the first VM.
  ```console
  ping <remoteip>
  ```

1. For example:
  ```console
  ping 192.168.1.4
  ```
  
1. The ping request should not arrive on the remote VM. That's because the virtual networks are not connected.


#### Task 6: Configure VNet peering
  
1. In the Azure portal, in the lefthand column, click **Virtual Networks**.

1. Click the **vnet1** Virtual Network.

1. From the **vnet1** blade, display its **Peerings** blade.

1. Click **+ Add** to create a VNet peering with the following settings (leave all other settings at their default value):

    - Name: **vnet1-to-vnet2**

    - Virtual network: **vnet2**

    - Name of peering from remote virtual network: **vnet2-to-vnet1**

> **Note**: Because you have administrative access to both virtual networks, the portal is configuring both directions (from vnet1 to vnet2, AND vnet2 to vnet1) in a single action. From the CLI or PowerShell, these tasks must be performed independently. 


#### Task 7: Verify connectivity

1. Return to the RDP session to VM2.

1. Open a Windows PowerShell console.

1. Ping the first VM using the following command, where <remoteip> should be replaced with the IP address you identified on the first VM.
  ```console
  ping <remoteip>
  ```

1. For example:
  ```console
  ping 192.168.1.4
  ```
  
1. The ping request should arrive on the remote VM. That's because the virtual networks are now connected.

> Result: In this exercise you connected two virtual networks using peering.
