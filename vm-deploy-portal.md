# Lab: Deploying a Virtual Machine

## Exercise 1: Deploy an Azure VM from the Azure portal

#### Task 1: Open the Azure Portal

1. Open your web browser.

1. In the web browser window, navigate to the **Azure Portal** (<https://portal.azure.com>).

1. If prompted, authenticate with the user account the trainer has assigned to you.

#### Task 2: Create an Azure VM running Windows Server 2016 Datacenter.

1. In the upper left corner of the Azure portal, click **+ Create a resource**.

1. In the **New** blade, at the top of the **Popular** blade, click **Windows Server 2016 Datacenter**.

1. On the **Basics** tab, perform the following tasks:

    - Leave the **Subscription** drop-down list entry set to its default value.
    
    - In the **Resource group** section, click **Create new**.
    
      - In the text box, type **YOURNAMERG**. Replace YOURNAME with the name the trainer has provided you. For example: PeterRG.
    
      - click **OK** to create the resource group.
      
    - In the **Name** text box, enter the value **vm1**.

    - In the **Region** drop-down list, select an Azure region to which you want to deploy resources in this lab.
    
    - Leve the **Availability options** to its default value.

    - Leave the entry in the **Image** drop-down list set to its default value.

    - Leave the **Size** to its default value.

    - In the **Username** text box, enter the value **Student**.

    - In the **Password** and **Confirm password** text boxes, enter the value **Pa55w.rd1234**.

    - In the **Public inbound ports** section, select the **Allow selected port** option and, in the **Select one or more ports** drop-down list, select **RDP (3389)**.

    - Leave the **Already have a Windows license?** option set to **No**.
    
    - Click **Next: Disks >**
    
1. On the **Disks** tab, perform the following tasks:

    - Ensure that the **OS disk type** dropdown list entry is set to **Standard SSD**

    - Click **Next: Networking >**
    
1. On the **Networking** tab, perform the following tasks: 

    - In the **Virtual network** section, click **Create new**. 
    
    - On the **Create virtual network** blade, specify the following settings and click **OK**:

        - In the **Name** text box, enter the value **YOURNAMEvnet**.

        - In the **Address range** text box, enter the value **10.3.0.0/16**.

        - In the **Subnet name** text box, enter the value **subnet0**.

        - In the **Subnet address range** text box, enter the value **10.3.0.0/24**, and click **OK**.

    - Leave all other options set to its default value.

    - Click **Next: Management >**
    
1. On the **Management** tab, perform the following tasks: 

    - Set the **Boot diagnostics** option to **Disabled**.

    - Leave all other opties to its default values.
    
    - Click the **Review + create** button.
    
1. On the **Create a virtual machine** blade, review the settings of your new virtual machine and click the **Create** button.

1. Wait for the deployment to complete before proceding to the next task. This will take 5-15 minutes.


#### Task 3: Connect to an Azure VM running Windows via a public IP address

1. In the Azure portal, navigate to the Resource Groups blade.

1. Click the **YOURNAMERG** resource group to open it's contents.

1. Click the **vm1** virtual machine.

1. From the **Overview** pane of the **vm1** blade, Select the **Connect** button to generate an RDP file and use it to connect to **vm1**.

1. When prompted, authenticate by specifying the following credentials:

    - User name: **Student**

    - Password: **Pa55w.rd1234**


#### Task 4: Remove lab resources

1. In the Azure portal, navigate to the Resource Groups blade.

1. Click the **YOURNAMERG** resource group to open it's contents.

1. Click the **Delete resource group** button.

1. Type in the name of the resource group to confirm deletion.

> **Review**: In this exercise, you deployed a **Virtual Machine** from the Azure portal and connected to it using Remote Desktop Protocol (RDP). After that you removed the resources used in this lab.
