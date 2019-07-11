# Lab: Deploying a Web App

## Exercise 1: Deploy a Web App from the Azure portal.

#### Task 1: Open the Azure Portal

1. Open your web browser.

2. In the web browser window, navigate to the **Azure Portal** (<https://portal.azure.com>).

3. If prompted, authenticate with the user account the trainer has assigned to you.

#### Task 2: Create a Web App

1. In the upper left corner of the Azure portal, click **Create a resource**.

2. From the **Popular** menu choose **Web App**

3. From the Web App Create blade, create a new web app with the following settings:
    
      Subscription: the name of the Azure subscription you intend to use in this lab

      Resource group: the name of a new resource group: mywebappRG

      App name: any unique, valid name

      Publish: Code
      
      Runtimestack: PHP 7.3
      
      Operating System: Linux
      
      Region: West Europe

      App Service plan: leave default settings
      
4. Klick **Review and Create**, review the webapp settings, and klick **Create**  

#### Task 3: Review your Web App URL 

1. In the Azure portal, navigate to the blade of the newly provisioned web app.

2. On the web app blade, use the Browse toolbar icon to open a new browser tab displaying the default App Service home page.

3. Close the browser tab displaying the default App Service home page.

#### Task 4: Deploy sample code to your Web App

1. 
