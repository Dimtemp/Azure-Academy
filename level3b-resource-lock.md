
### Exercise: Implement Azure resource locks

#### Task 1: Create resource group-level locks to prevent accidental changes

1. In the Azure portal, navigate to the **az1000101b-RG** resource group blade.

1. From the **az1000101b-RG** resource group blade, display the **az1000101b-RG - Locks** blade.

1. From the **az1000101b-RG - Locks** blade, add a lock with the following settings:

    - Lock name: **az1000101b-roLock**

    - Lock type: **Read-only**


#### Task 2: Validate functionality of the resource group-level locks

1. In the Azure portal, navigate to the **az1000102b-vm1** virtual machine blade.

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
