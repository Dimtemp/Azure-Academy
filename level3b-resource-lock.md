### Lab: Implement Azure resource locks

Scenario: we're going to create two storage accounts, each in it's own resource groups. One resource group will be locked. It's resources can only be viewed, not changed.


#### Task 1: Create resources

1. In the Azure portal, open the Cloud Shell.

1. Verify the Cloud Shell is set to **PowerShell**, not bash.

1. We need two resource groups with each a storage account. Storage account names need to be globally unique. So when entering the final two command's, specify a name that should be globally unique (for example Peter82634). Enter the following command's in the Cloud Shell.

```powershell
$id = 'StudentID'   # replace this with your own, unique ID, for example: $id = 'Peter'
New-AzResourceGroup -Name "$($id)1" -Location westeurope
New-AzResourceGroup -Name "$($id)2" -Location westeurope
New-AzStorageAccount -ResourceGroupName "$($id)1" -SkuName Standard_LRS -Location westeurope
New-AzStorageAccount -ResourceGroupName "$($id)2" -SkuName Standard_LRS -Location westeurope
```


#### Task 2: Set resource group-level locks to prevent accidental changes

1. After the resources have been created, optionally refresh the page, and open the **STUDENTID2** resource group.

1. From the resource group, select Locks.

1. Add a lock with the following settings:

    - Lock name: **myreadonlylock**

    - Lock type: **Read-only**


#### Task 3: Validate functionality of the resource group-level locks

1. In the Azure portal, navigate to the **STUDENTID1** resource group.

1. Select the storage account to open it.

1. Select **Tags**.

1. Try setting the value of the **environment** tag to **dev**. Note that the operation is successful. 

1. Select **Access Keys**. Note that you can view both **key1** and **key2**.

1. Select Configuration.

1. Set Replication from **LRS** to **RA-GRS**. Click **Save**. Note that the operation is successful. 

1. In the Azure portal, navigate to the **STUDENTID2** resource group.

1. Select **Tags**.

1. Try setting the value of the **environment** tag to **dev**. Note that this time the operation fails. The resulting error message indicates that the resource refused tag assignment, with resource lock being the likely reason.

1. Select **Access Keys**. Note the resulting error message stating that you cannot access the data plane because a read lock on the resource or its parent.

1. Select Configuration.

1. Set Replication from **LRS** to **RA-GRS**. Click **Save**. Note that the operation is not successful. 


> **Result**: After you completed this exercise, you have created a resource group-level lock to prevent accidental changes and validated its functionality. 
