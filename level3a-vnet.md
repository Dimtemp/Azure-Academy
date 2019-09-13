# Lab: VNet connectivity and VNet Peering

### Scenario
  
Adatum Corporation wants to implement connectivity between Azure virtual networks in its Azure subscription. 


### Objectives
  
After completing this lab, you will be able to:

- Create Azure virtual networks and deploy Azure VM by using Azure Resource Manager templates.

- Configure VNet peering.



### Exercise 0: Prepare the Azure environment
  
The main tasks for this exercise are as follows:

1. Create the first virtual network hosting two Azure VMs by using an Azure Resource Manager template

1. Create the second virtual network in the same region hosting a single Azure VM by using an Azure Resource Manager template

#### Task 1: Create the first virtual network hosting two Azure VMs by using an Azure Resource Manager template

1. From the lab virtual machine, start Microsoft Edge, browse to the Azure portal at [**http://portal.azure.com**](http://portal.azure.com) and sign in by using a Microsoft account that has the Owner role in the Azure subscription you intend to use in this lab.

1. In the Azure portal, navigate to the **Create a resource** blade.

1. From the **Create a resource** blade, search Azure Marketplace for **Template deployment**.

1. Use the list of search results to navigate to the **Template deployment (deploy using custom templates)** blade, and then click **Create**.

1. On the **Custom deployment** blade, click the **Build your own template in the editor** link. If you do not see this link, click **Edit template** instead.

1. From the **Edit template** blade, load the template file **Labfiles\\Module_05\VNet_Peering_and_Service_Chaining\\az-100-04_01_azuredeploy.json**. 

   > **Note**: Review the content of the template and note that it defines deployment of an Azure VM hosting Windows Server 2016 Datacenter.

1. Save the template and return to the **Custom deployment** blade. 

1. From the **Custom deployment** blade, navigate to the **Edit parameters** blade.

1. From the **Edit parameters** blade, load the parameters file **Labfiles\\Module_05\VNet_Peering_and_Service_Chaining\\az-100-04_azuredeploy.parameters.json**. 

1. Save the parameters and return to the **Custom deployment** blade. 

1. From the **Custom deployment** blade, initiate a template deployment with the following settings:

    - Subscription: the name of the subscription you are using in this lab

    - Resource group: the name of a new resource group **az1000401-RG**

    - Location: the name of the Azure region which is closest to the lab location and where you can provision Azure VMs

    - Vm Size: **Standard_DS2_v2**

    - Vm1Name: **az1000401-vm1**

    - Vm2Name: **az1000401-vm2**

    - Admin Username: **Student**

    - Admin Password: **Pa55w.rd1234**

    - Virtual Network Name: **az1000401-vnet1**

   > **Note**: To identify Azure regions where you can provision Azure VMs, refer to [**https://azure.microsoft.com/en-us/regions/offers/**](https://azure.microsoft.com/en-us/regions/offers/)

   > **Note**: Do not wait for the deployment to complete but proceed to the next task. You will use the network and the virtual machines included in this deployment in the second exercise of this lab.


#### Task 2: Create the second virtual network in the same region hosting a single Azure VM by using an Azure Resource Manager template

1. In the Azure portal, navigate to the **Create a resource** blade.

1. From the **Create a resource** blade, search Azure Marketplace for **Template deployment**.

1. Use the list of search results and select the **Template deployment (deploy using custom templates)** result, and then click **Create**.

1. On the **Custom deployment** blade, click the **Build your own template in the editor** link. If you do not see this link, click **Edit template** instead.

1. From the **Edit template** blade, load the template file **Labfiles\\Module_05\VNet_Peering_and_Service_Chaining\\az-100-04_02_azuredeploy.json**. 

   > **Note**: Review the content of the template and note that it defines deployment of an Azure VM hosting Windows Server 2016 Datacenter.

1. Save the template and return to the **Custom deployment** blade. 

1. From the **Custom deployment** blade, navigate to the **Edit parameters** blade.

1. From the **Edit parameters** blade, load the parameters file **Labfiles\\Module_05\VNet_Peering_and_Service_Chaining\\az-100-04_azuredeploy.parameters.json**. 

1. Save the parameters and return to the **Custom deployment** blade. 

1. From the **Custom deployment** blade, initiate a template deployment with the following settings:

    - Subscription: the name of the subscription you are using in this lab

    - Resource group: the name of a new resource group **az1000402-RG**

    - Location: the name of the Azure region which you selected in the previous task

    - Vm Size: **Standard_DS2_v2**

    - VmName: **az1000402-vm3**

    - Admin Username: **Student**

    - Admin Password: **Pa55w.rd1234**

    - Virtual Network Name: **az1000402-vnet2**

   > **Note**: Do not wait for the deployment to complete but proceed to the next task. You will use the network and the virtual machines included in this deployment in the second exercise of this lab.

> **Result**: After you completed this exercise, you have created two Azure virtual networks and initiated deployments of three Azure VM by using Azure Resource Manager templates.


### Exercise 1: Configure VNet peering 

The main tasks for this exercise are as follows:

1. Configure VNet peering for the first virtual network

1. Configure VNet peering for the second virtual network


#### Task 1: Configure VNet peering for the first virtual network
  
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


### Exercise 2: Implement custom routing
  
The main tasks for this exercise are as follows:

1. Enable IP forwarding for a network interface of an Azure VM

1. Configure user defined routing 

1. Configure routing in an Azure VM running Windows Server 2016


#### Task 1: Enable IP forwarding for a network interface of an Azure VM
  
   > **Note**: Before you start this task, ensure that the template deployments you started in Exercise 0 have completed. 

1. In the Azure portal, navigate to the blade of the second Azure VM **az1000401-vm2**.

1. From the **az1000401-vm2** blade, display its **Networking** blade. 

1. From the **az1000401-vm2 - Networking** blade, display the blade of the network adapter (**az1000401-nic2**) of the Azure VM.

1. From the **az1000401-nic2** blade, display its **IP configurations** blade.

1. From the **az1000401-nic2 - IP configurations** set IP forwarding to **Enabled**, and then click **Save**.

   > **Note**: The Azure VM **az1000401-vm2**, which network interface you configured in this task, will function as a router, facilitating service chaining between the two virtual networks.


#### Task 2: Configure user defined routing 

1. In the Azure portal, navigate to the **Create a resource** blade.

1. From the **Create a resource** blade, search Azure Marketplace for **Route table**.

1. Select **Route table**, and then click **Create**.

1. From the **Create route table** blade, create a new route table with the following settings:

    - Name: **az1000402-rt1**

    - Subscription: the name of the Azure subscription you use for this lab

    - Resource group: **az1000402-RG**

    - Location: the same Azure region in which you created the virtual networks
  
    - Virtual network gateway route propagation: **Disabled**

1. In the Azure portal, navigate to the **az1000402-rt1** blade.

1. From the **az1000402-rt1** blade, display its **Routes** blade. 

1. From the **az1000402-rt1 - Routes** blade, add to the route table a route with the following settings: 

    - Route name: **custom-route-to-az1000401-vnet1**

    - Address prefix: **10.104.0.0/16**

    - Next hop type: **Virtual appliance**

    - Next hop address: **10.104.1.4**

   > **Note**: **10.104.1.4** is the IP address of the network interface of **az1000401-vm2**, which will provide service chaining between the two virtual networks.

1. From the **az1000402-rt1** blade, display its **Subnets** blade. 

1. From the **az1000402-rt1 - Subnets** blade, associate the route table **az1000402-rt1** with **subnet0** of **az1000402-vnet2**.


#### Task 3: Configure routing in an Azure VM running Windows Server 2016

1. In the Azure portal, navigate to the blade of the **az1000401-vm2** Azure VM. 

1. From the **Overview** pane of the **az1000401-vm2** blade, generate an RDP file and use it to connect to **az1000401-vm2**.

1. When prompted, authenticate by specifying the following credentials:

    - User name: **Student**

    - Password: **Pa55w.rd1234**

1. Within the Remote Desktop session to **az1000401-vm2**, from **Server Manager**, select **Manage**  use the **Add Roles and Features Wizard** 
1. Click **Next** twice, ensure **az1000401-vm2** is selected and click **Next**,  select the **Remote Access** server role then click **Next** three times, Select the **Routing** role service, select **Add Features**  and all required features. Select **Next** three times, click **Install**. Click **Close** when the installation is complete.

   > **Note**: If you receive an error message **There may be a version mismatch between this computer and the destination server or VHD** once you select the **Remote Access**  checkbox on the **Server Roles** page of the **Add Roles and Features Wizard**, clear the checkbox, click **Next**, click **Previous** and select the **Remote Access**  checkbox again.

1. Within the Remote Desktop session to **az1000401-vm2**, from Server Manager, select **Tools** start the **Routing and Remote Access** console. 

1. In the **Routing and Remote Access** console, right click on the server name and select **Configure and Enable Routing and Remote Access**, Select **Next** use the **Custom configuration** then **Next**, enable **LAN routing** then **Next**, click **Finish** and the click **Start Service**.

1. Within the Remote Desktop session to **az1000401-vm2**, start the **Windows Firewall with Advanced Security** console and enable **File and Printer Sharing (Echo Request - ICMPv4-In)** inbound rule for all profiles.

> **Result**: After completing this exercise, you have implemented custom routing between peered Azure virtual networks. 


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

