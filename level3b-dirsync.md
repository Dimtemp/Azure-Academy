# Lab: Implement Directory Synchronization

### Scenario
  
Adatum Corporation wants to integrate its Active Directory with Azure Active Directory. You will install Azure AD Connect on a domain controller to synchronize Active Directory with Azure Active Directory.


#### Task 1: Deploy an Azure VM hosting an Active Directory domain controller by using an Azure Resource Manager template

1. Open a web browser and browse to the GitHub Azure QuickStart Templates page at  [**https://github.com/Azure/azure-quickstart-templates**](https://github.com/Azure/azure-quickstart-templates).

1. On the Azure Quickstart Templates page, click **active-directory-new-domain**.

1. Click **Deploy to Azure**.

1. A new blade opens. Initiate a template deployment with the following settings:

    - Resource group: Create new: **<STUDENTID>**

    - Admin Username: **Student**

    - Admin Password: **Pa55w.rd1234**

    - Domain Name: **<YOURNAME>.com**, for example: peter.com

    - Dns Prefix: <STUDENTID><6 digit random number>, for example: Peter732538. This name needs to be unique.
    
    - for all other items: accept the default value

   > **Note**: Do not wait for the deployment to complete but proceed to the next task. You will use the virtual machine deployed in this task in the third exercise of this lab.



#### Task 2: Create an Azure Active Directory (AD) tenant

1. In the Azure portal, navigate to the **Create a resource** blade. 

1. From the **Create a resource** blade, search Azure Marketplace for **Azure Active Directory**.

1. Use the list of search results to navigate to the **Create directory** blade.

1. From the **Create directory** blade, create a new Azure AD tenant with the following settings: 

  - Organization name: **AdatumSync**

  - Initial domain name: a unique name consisting of a combination of letters and digits. 

  - Country or region: **United States**

   > **Note**: The green check mark in the **Initial domain name** text box will indicate whether the domain name you typed in is valid and unique. 


#### Task 3: Add a custom DNS name to the new Azure AD tenant
  
1. In the Azure portal, set the **Directory + subscription** filter to the newly created Azure AD tenant.

   > **Note**: The **Directory + subscription** filter appears to the left of the notification icon in the toolbar of the Azure portal 

   > **Note**: You might need to refresh the browser window if the **AdatumSync** entry does not appear in the **Directory + subscription** filter list.

1. In the Azure portal, navigate to the **AdatumSync - Overview** blade.

1. From the **AdatumSync - Overview** blade, display the **AdatumSync - Custom domain names** blade. 

1. On the **AdatumSync - Custom domain names** blade, identify the primary, default DNS domain name associated with the Azure AD tenant. Note its value - you will need it in the next task.

1. From the **AdatumSync - Custom domain names** blade, add the **adatum.com** custom domain.

1. On the **adatum.com** blade, review the information necessary to perform verification of the Azure AD domain name.

   > **Note**: You will not be able to complete the validation process because you do not own the **adatum.com** DNS domain name. This will not prevent you from synchronizing the **adatum.com** Active Directory domain with the Azure AD tenant. You will use for this purpose the default primary DNS name of the Azure AD tenant (the name ending with the **onmicrosoft.com** suffix), which you identified earlier in this task. However, keep in mind that, as a result, the DNS domain name of the Active Directory domain and the DNS name of the Azure AD tenant will differ. This means that Adatum users will need to use different names when signing in to the Active Directory domain and when signing in to Azure AD tenant.


#### Task 4: Create an Azure AD user with the Global Administrator role

1. In the Azure portal, navigate to the **Users - All users** blade of the **AdatumSync** Azure AD tenant.

1. From the **Users - All users** blade, create a new user with the following settings:

     - User name: **syncadmin@***<DNS-domain-name>* where *<DNS-domain-name>* represents the default primary DNS domain name you identified in the previous task. Take a note of this user name. You will need it later in this lab.
    
    - Name: **syncadmin**
    
    - Password: select the checkbox **Show Password** and note the string appearing in the **Password** text box. You will need it later in this task.
    
    - Groups: **0 groups selected**

    - Directory role: click "User" and select **Global administrator**

   > **Note**: An Azure AD user with the Global Administrator role is required in order to implement Azure AD Connect.

1. Open an InPrivate Microsoft Edge window.

1. In the new browser window, navigate to the Azure portal and sign in using the **syncadmin** user account. When prompted, change the password to a new value.

   > **Note**: You will need to provide the fully qualified name of the **syncadmin** user account, including the Azure AD tenant DNS domain name. 

1. Sign out as **syncadmin** and close the InPrivate browser window.




#### Task 5: Configure Active Directory in preparation for directory synchronization

   > **Note**: Before you start this task, ensure that the template deployment you started in task 1 has completed.
  
1. In the Azure portal, set the **Directory + subscription** filter back to the Azure AD tenant associated with the Azure subscription you used in the first exercise of this lab.

   > **Note**: The **Directory + subscription** filter appears to the left of the notification icon in the toolbar of the Azure portal 

1. In the Azure portal, navigate to **Resource Groups**, click **<STUDENTID>** resource group to open it, select the **adVM** virtual machine.

1. From the **Overview** pane of the **adVM** blade, identify it's public IP address.

1. Connect to the VM using RDP.

1. When prompted, authenticate by specifying the following credentials:

    - User name: **Student**

    - Password: **Pa55w.rd1234**

1. Within the Remote Desktop session, click Start, select Administrative Tools and open the **Active Directory Users and Computers**.

1. From **Active Directory Users and Computers**, create a organizational unit named **ToSync**.

1. From **Active Directory Users and Computers**, in the organizational unit **ToSync**, create a new user account with the following settings:

    - Full name: **aduser1**

    - User UPN logon: **aduser1@adatum.com**

    - User SamAccountName logon: **adatum\aduser1**

    - Password: **Pa55w.rd1234**

    - Other password options: **Password never expires**


#### Task 6: Install Azure AD Connect

1. Within the RDP session, open Server Manager, and disable **IE Enhanced Security Configuration**.

1. Within the RDP session, start Internet Explorer and download **Azure AD Connect** from [**https://www.microsoft.com/en-us/download/details.aspx?id=47594**](https://www.microsoft.com/en-us/download/details.aspx?id=47594)

1. Start **Microsoft Azure Active Directory Connect** wizard, accept the licensing terms, and, on the Express Settings page, select the **Customize** option.

1. On the **Install required components** page, leave all optional configuration options deselected and start the installation.

1. On the **User sign-in** page, ensure that only the **Password Hash Synchronization** is enabled.

1. When prompted to connect to Azure AD, authenticate by using the credentials of the **syncadmin** account you created in the previous exercise.

1. When prompted to connect your directories, add the **adatum.com** forest, choose the option to **Create new AD account**, and authenticate by using the following credentials:

    - User name: **ADATUM\\Student**

    - Password: **Pa55w.rd1234**

1. On the **Azure AD sign-in configuration** page, note the warning stating **Users will not be able to sign-in to Azure AD with on-premises credentials if the UPN suffix does not match a verified domain name** and enable the checkbox **Continue without matching all UPN suffixes to verified domain**.

   > **Note**: As explained earlier, this is expected, since you could not verify the custom Azure AD DNS domain **adatum.com**.

1. On the **Domain and OU filtering** page, ensure that only the **ToSync** OU is selected.

1. On the **Uniquely identifying your users** page, accept the default settings.

1. On the **Filter users and devices** page, accept the default settings.

1. On the **Optional features** page, accept the default settings.

1. On the **Ready to configure** page, ensure that the **Start the synchronization process when configuration completes** checkbox is selected and continue with the installation process. 

   > **Note**: Installation should take about 2 minutes.

1. Close the Microsoft Azure Active Directory Connect window once the configuration is completed.


#### Task 7: Verify directory synchronization

1. Within the RDP session, start Internet Explorer, browse to the Azure portal at [**http://portal.azure.com**](http://portal.azure.com) and sign in by using the **syncadmin** account that you created in the previous exercise. 

1. In the Azure portal, navigate to the **AdatumSync - Overview** blade.

1. From the **AdatumSync - Overview** blade, display the **Users - All users** blade of the AdatumSync Azure AD tenant.

1. On the **Users - All users** blade, note that the list of user objects includes the **aduser1** account, with the **Windows Server AD** appearing in the **SOURCE** column.

1. From the **Users - All users** blade, display the **aduser1 - Profile** blade. Note that the **Department** attribute is not set.

1. Within the RDP session to **adVM**, switch to **Active Directory Users and Computers**, open the window displaying properties of the **aduser1** user account, and set the value of its **Department** attribute to **Sales**.

1. Within the RDP session to **adVM**, start **Windows PowerShell** as Administrator.

1. From the Windows PowerShell prompt, start Azure AD Connect delta synchronization by running the following:

   ```pwsh
   Import-Module -Name 'C:\Program Files\Microsoft Azure AD Sync\Bin\ADSync\ADSync.psd1'
   
   Start-ADSyncSyncCycle -PolicyType Delta
   ```

1. Within the RDP session to **adVM**, switch to the Internet Explorer window displaying the Azure portal. 

1. In the Azure portal, navigate back to the **Users - All users** blade and refresh the page. 

1. From the **Users - All users** blade, display the **aduser1 - Profile** blade. Note that the **Department** attribute is now set to **Sales**.

   > **Note**: You might need to wait for another minute and refresh the page again if the **Department** attribute remains not set.


> **Result**: After you completed this task, you have initiated deployment of an Azure VM that will host an Active Directory domain controller by using an Azure Resource Manager template

> **Result**: After you completed this exercise, you have created an Azure AD tenant, added a custom DNS name to the new Azure AD tenant, and created an Azure AD user with the Global Administrator role.


> **Result**: After you completed this exercise, you have configured Active Directory in preparation for directory synchronization, installed Azure AD Connect, and verified directory synchronization.
