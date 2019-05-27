# Lab: Deploying a VM.

## Exercise 1: Deploy an Azure VM from the Azure portal.

#### Task 1: Open the Azure Portal

1. Open your web browser.

1. In the web browser window, navigate to the **Azure Portal** (<https://portal.azure.com>).

1. If prompted, authenticate with the user account the trainer has assigned to you.

#### Task 2: Create an Azure VM running Windows Server 2016 Datacenter.

1. In the upper left corner of the Azure portal, click **Create a resource**.

1. At the top of the **New** blade, in the **Search the Marketplace** text box, type **Windows Server 2016** and press **Enter**.

1. On the **Everything** blade, in the search results, click **Windows Server 2016 Datacenter**.

1. On the **Windows Server 2016 Datacenter** blade, click the **Create** button.

1. On the **Basics** tab, perform the following tasks:

    - Leave the **Subscription** drop-down list entry set to its default value.
    
    - In the **Resource group** section, click **Create new**.
    
      - In the text box, type **YOURNAME-RG**. Replace YOURNAME with the name the trainer has provided you. For example: Peter-RG.
    
      - click **OK** to create the resource group.
      
    - In the **Name** text box, enter the value **lab03vm0**.

    - In the **Region** drop-down list, select an Azure region to which you want to deploy resources in this lab.
    
    - In the **Availability options** drop-down list, leave it to default.

    - Leave the entry in the **Image** drop-down list set to its default value.

    - Ensure that the size is set to **Standard DS1 v2**

    - In the **Username** text box, enter the value **Student**.

    - In the **Password** and **Confirm password** text boxes, enter the value **Pa55w.rd1234**.

    - In the **Public inbound ports** section, select the **Allow selected port** option and, in the **Select inbound ports** drop-down list, select **RDP**.

    - Leave the **Already have a Windows license?** option set to **No**.
    
    - Click **Next: Disks >**
    
1. On the **Disks** tab, perform the following tasks:

    - Ensure that the **OS disk type** dropdown list entry is set to **Premium SSD**

    - Click **Next: Networking >**
    
1. On the **Networking** tab, perform the following tasks: 

    - In the **Virtual network** section, click **Create new**. 
    
    - On the **Create virtual network** blade, specify the following settings and click **OK**:

        - In the **Name** text box, enter the value **YOURNAME-vnet**.

        - In the **Address range** text box, enter the value **10.3.0.0/16**.

        - In the **Subnet name** text box, enter the value **subnet-0**.

        - In the **Subnet address range** text box, enter the value **10.3.0.0/24**, and click **OK**.

    - Leave the **Public IP** entry set to its default value.
    
    - Leave the **NIC network security group** option set to **Basic**.
    
    - Leave the **Public inbound ports** option set to **Allow selected ports**
    
    - Leave the **Select inbound ports** entry set to **HTTP**

    - Leave the **Accelerated networking** entry set to its default value.

    - Click **Next: Management >**
    
1. On the **Management** tab, perform the following tasks: 

    - Leave the **Boot diagnostics** option set to its default value.

    - Leave the **OS guest diagnostics** option set to its default value.

    - Leave the **Diagnostics storage account** entry set to its default value.
    
    - Leave the **System assigned managed identity** option set to its default value.
    
    - Leave the **Enable auto-shutdown** option set to its default value.

    - Leave the **Enable backup** option set to its default value.

    - Click the **Review + create** button.
    
1. On the **Create a virtual machine** blade, review the settings of your new virtual machine and click the **Create** button.

1. Do not wait for the deployment to complete and proceed to the next task.


#### Task 7: Validate that the Azure VM is serving web content

1. In the hub menu in the Azure portal, click **Resource groups**.

1. On the **Resource groups** blade, click the entry representing the resource group into which you deployed the virtual machine.

1. On the resource group blade, click the entry representing the **Virtual Machine** you deployed.

1. On the **Virtual machine** blade, locate the **Public IP address** entry, and identify its value.




#### Task 2: Connect to an Azure VM running Windows Server 2016 Datacenter via a public IP address

1. In the Azure portal, navigate to the **az1000301-vm0** blade.

1. From the **az1000301-vm0** blade, navigate to the **az1000301-vm0 - Networking** blade.

1. On the **az1000301-vm0 - Networking** blade, review the inbound port rules of the network security group assigned to the network interface of **az1000301-vm0**.

   > **Note**: The default configuration consisting of built-in rules block inbound connections from the internet (including connections via the RDP port TCP 3389)

1. Add an inbound security rule to the existing network security group with the following settings:

    - Source: **Any**

    - Source port ranges: **\***

    - Destination: **Any**

    - Destination port ranges: **3389**

    - Protocol: **TCP**

    - Action: **Allow**

    - Priority: **100**

    - Name: **AllowInternetRDPInBound**

1. In the Azure portal, display the **Overview** pane of the **az1000301-vm0** blade. 

1. From the **Overview** pane of the **az1000301-vm0** blade, generate an RDP file and use it to connect to **az1000301-vm0**.

1. When prompted, authenticate by specifying the following credentials:

    - User name: **Student**

    - Password: **Pa55w.rd1234**




> **Review**: In this exercise, you deployed a **Virtual Machine** from the Azure portal and connected to it using Remote Desktop Protocol (RDP).

## Exercise 3: Remove lab resources

#### Task 1: Open Cloud Shell

1. At the top of the portal, click the **Cloud Shell** icon to open the Cloud Shell pane.

1. At the **Cloud Shell** command prompt, type in the following command and press **Enter** to list all resource groups you created in this lab:

    ```
    az group list --query "[?starts_with(name,'AADesignLab03')]".name --output tsv
    ```

1. Verify that the output contains only the resource groups you created in this lab. These groups will be deleted in the next task.

#### Task 2: Delete resource groups

1. At the **Cloud Shell** command prompt, type in the following command and press **Enter** to delete the resource groups you created in this lab

    ```
    az group list --query "[?starts_with(name,'AADesignLab03')]".name --output tsv | xargs -L1 bash -c 'az group delete --name $0 --no-wait --yes'
    ```

1. Close the **Cloud Shell** prompt at the bottom of the portal.


> **Review**: In this exercise, you removed the resources used in this lab.
