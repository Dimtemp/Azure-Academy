### Lab: Implement Azure resource locks

Scenario: we're going to create two storage accounts, each in it's own resource groups. One resource group will be locked. It's resources can only be viewed, not changed.


#### Task 1: Create resources

1. In the Azure portal, open the Cloud Shell.

1. Verify the Cloud Shell is set to **PowerShell**, not bash.

1. We need two resource groups with each a storage account. Storage account names need to be globally unique. So when entering the final two command's, specify a name that should be globally unique (for example Peter82634). Enter the following command's in the Cloud Shell.

```powershell
New-AzResourceGroup -Name <STUDENTID>1 -Location westeurope
New-AzResourceGroup -Name <STUDENTID>2 -Location westeurope
New-AzStorageAccount -ResourceGroupName <STUDENTID>1 -SkuName Standard_LRS -Location westeurope
New-AzStorageAccount -ResourceGroupName <STUDENTID>2 -SkuName Standard_LRS -Location westeurope
```


#### Task 2: Set resource group-level locks to prevent accidental changes

1. After the resources have been created, optionally refresh the page, and open the **<STUDENTID>1** resource group.

1. From the resource group, select Locks.

1. Add a lock with the following settings:

    - Lock name: **myreadonlylock**

    - Lock type: **Read-only**


#### Task 3: Validate functionality of the resource group-level locks

1. In the Azure portal, navigate to the **<STUDENTID>2** virtual machine blade.

1. From the **az1000102b-vm1** virtual machine blade, navigate to the **az1000102b-vm1 - Tags** blade.

1. Try setting the value of the **environment** tag to **dev**. Note that the operation is successful. 

1. In the Azure portal, navigate to the **az1000101b-vm1** virtual machine blade.

1. From the **az1000101b-vm1** virtual machine blade, navigate to the **az1000101b-vm1 - Tags** blade.

1. Try setting the value of the **environment** tag to **dev**. Note that this time the operation fails. The resulting error message indicates that the resource refused tag assignment, with resource lock being the likely reason.

1. Navigate to the blade of the storage account created in the **az1000101b-RG - Locks** resource group. 

1. From the storage account blade, navigate to its **Access keys** blade. Note the resulting error message stating that you cannot access the data plane because a read lock on the resource or its parent.

1. In the Azure portal, navigate to the **az1000101b-RG** resource group blade.

1. From the **az1000101b-RG** resource group blade, navigate to its **Tags** blade.

1. From the **Tags** blade, attempt assigning the **environment** tag with the value **lab** to the resource group and note the error message.


> **Result**: After you completed this exercise, you have created a resource group-level lock to prevent accidental changes and validated its functionality. 
