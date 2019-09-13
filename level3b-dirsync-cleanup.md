
## Exercise: Remove lab resources

#### Task 1: Open Cloud Shell

1. At the top of the portal, click the **Cloud Shell** icon to open the Cloud Shell pane.

1. At the Cloud Shell interface, select **Bash**.

1. At the **Cloud Shell** command prompt, type in the following command and press **Enter** to list all resource groups you created in this lab:

   ```sh
   az group list --query "[?starts_with(name,'az1000')].name" --output tsv
   ```

1. Verify that the output contains only the resource groups you created in this lab. These groups will be deleted in the next task.

#### Task 2: Delete resource groups

1. At the **Cloud Shell** command prompt, type in the following command and press **Enter** to delete the resource groups you created in this lab

   ```sh
   az group list --query "[?starts_with(name,'az1000')].name" --output tsv | xargs -L1 bash -c 'az group delete --name $0 --no-wait --yes'
   ```

1. Close the **Cloud Shell** prompt at the bottom of the portal.

#### Task 3: Delete the Azure AD tenant.

1. Start Windows PowerShell as Administrator on the lab VM. 

1. From the Windows PowerShell console on the lab VM, install the MsOnline PowerShell module by running the following (when prompted, in the NuGet provider is required to continue dialog box, click **Yes**):

   ```pwsh
   Install-Module MsOnline -Force
   ```
   
1. From the Windows PowerShell console on the lab VM, connect to the AdatumSync Azure AD tenant by running the following (when prompted, sign in with the SyncAdmin credentials):

   ```pwsh
   Connect-MsolService
   ```

1. From the Windows PowerShell console on the lab VM, disable the Azure AD Connect synchronization by running the following:

   ```pwsh
   Set-MsolDirSyncEnabled -EnableDirSync $false -Force
   ```

1. From the Windows PowerShell console on the lab VM, verify that the operation was successful by running the following:

   ```pwsh
   (Get-MSOLCompanyInformation).DirectorySynchronizationEnabled 
   ```   

1. On the lab VM, sign out from the Azure portal and close the Microsoft Edge window. 

1. From the lab VM, start Microsoft Edge, navigate to the Azure portal, and sign in by using the SyncAdmin credentials. 

1. In the Azure portal, navigate to the **Users - All users** blade of the AdatumSync Azure AD tenant and delete all users with the exception of the AdatumSync account.

> **Note**: You might need to wait a few hours before you can complete this step.

1. Navigate to the AdatumSync - Overview blade and click **Properties**.

1. On the **Properties** blade of Azure Active Directory click **Yes** in the **Access management for Azure resource** section and then click **Save**.

1. Sign out from the Azure portal and sign back in by using the SyncAdmin credentials. 

1. Navigate to the **AdatumSync - Overview** blade and delete the Azure AD tenant by clicking **Delete directory**.

1. On the **Delete directory 'AdatumSync'?** blade, click **Delete**.

> **Note**: For any additional  information regarding this task, refer to https://docs.microsoft.com/en-us/azure/active-directory/users-groups-roles/directory-delete-howto  

> **Result**: In this exercise, you removed the resources used in this lab.
