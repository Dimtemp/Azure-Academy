# Lab: Creating a storage account

## Exercise 1: Creating a storage account from the Azure portal.

#### Task 1: Open the Azure Portal

1. Open your web browser.

1. In the web browser window, navigate to the **Azure Portal** (<https://portal.azure.com>).

1. If prompted, authenticate with the user account the trainer has assigned to you.

#### Task 2: Create an Azure Storage account

1. In the upper left corner of the Azure portal, click **Create a resource**.

1. At the top of the **New** blade, in the **Search the Marketplace** text box, type **Storage account** and press **Enter**.

1. On the **Everything** blade, in the search results, click **Storage account - blob, file, table, queue**.

1. On the **Storage account - blob, file, table, queue** blade, click the **Create** button.

1. On the **Create storage account** blade, perform the following tasks:

    - In the **Name** text box, type a unique name consisting of a combination of between 3 and 24 characters and digits.
    
    - In the **Deployment model** section, ensure that the **Resource manager** option is selected.

    - In the **Account kind** drop-down list, ensure that the **Storage (general purpose v1)** option is selected.

    - Leave the **Location** entry set to the same Azure region you selected earlier in this exercise.

    - In the **Replication** drop-down list, select the **Locally-redundant storage (LRS)** entry.

    - In the **Performance** section, ensure that the **Standard** option is selected. 

    - In the **Secure transfer required** section, ensure that the **Disabled** option is selected. 

    - Leave the **Subscription** drop-down list entry set to its default value.

    - In the **Resource group** section, select the resource group that has been assigned to you.

    - Leave the **Configure virtual networks** option set to its default value.

    - Leave the **Hierarchical namespaces** option set to its default value.

    - Click the **Create** button.

    > **Note**: This operation can take about 2 minutes.


## Exercise 2: Creating a storage account using Windows PowerShell

#### Task 1: Open Cloud Shell

1. At the top of the portal, click the **Cloud Shell** icon to open the Cloud Shell pane.

#### Task 2: Identify an available DNS name for an Azure VM scale set deployment

1. In the Cloud Shell pane, run the following command, substituting the placeholder &lt;custom-label&gt; with any string which is likely to be unique and the placeholder &lt;location-of-az1000301-RG&gt; with the name of the Azure region in which you created the **az1000301-RG** resource group.

   ```
   Test-AzDnsAvailability -DomainNameLabel <custom-label> -Location '<location-of-az1000301-RG>'
   ```

1. Verify that the command returned **True**. If not, rerun the same command with a different value of the &lt;custom-label&gt; until the command returns **True**. 

1. Note the value of the &lt;custom-label&gt; that resulted in the successful outcome. You will need it in the next task

#### Task 3: Identify an available DNS name for an Azure VM scale set deployment

1. At the **Cloud Shell** command prompt, type in the following command and press **Enter** to create a storage account:

New-AzStorageAccount -ResourceGroupName 'YOURNAME-RG' -Name test647382 -SkuName Standard_LRS -Location westeurope
 #    -Kind StorageV2 
  
Reconfigure to RA_GRS and verify properties
TEST

