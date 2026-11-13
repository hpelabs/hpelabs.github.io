---
layout: post
title: "HPE Compute Ops Management Zero-Touch Automation"
image: /assets/images/HOLs/COM-ZeroTouch/banner.jpg
post_end_promo: <i><b>Continue your journey with more HPE Compute Technical Enablement Hands-on Labs for infrastructure, security, technologies, and solutions.</b></i>
excerpt: Learn to automate HPE server lifecycle management using the HPE Compute Ops Management PowerShell module—from workspace provisioning and device onboarding to policy enforcement, compliance monitoring, and sustainability insights within HPE GreenLake.
last_modified_at: 2026-06-29
tags: 
  - greenlake
  - com 
  - scripting
# room: 2 # Set to 1 or 2
collapsible: true
collapsible_expanded: true
---

Hands on Lab Guide

# Introduction

Welcome to this Hands-On Lab (HOL). For the next two hours you will
complete a self-paced lab using the HPECOMCmdlets PowerShell library, 
HPE ProLiant DL-series servers and HPE GreenLake Compute Ops Management.

## Lab Objectives

In this hands-on lab, you will discover how the HPE Compute Ops Management PowerShell library can transform the way you manage data center infrastructure. By working through real-world scenarios, you will learn how to replace time-consuming manual operations with automated, repeatable workflows—covering the full server lifecycle from initial provisioning and device onboarding to policy enforcement, compliance monitoring, and decommissioning. You will gain practical experience automating critical IT tasks such as workspace configuration, firmware management, and iLO settings enforcement, while also learning how to leverage sustainability and utilization insights to make smarter infrastructure decisions. By the end of this lab, you will have the skills and confidence to design and implement automation workflows that reduce human error, enforce consistent configurations at scale, and accelerate server deployments across your HPE GreenLake environment.

## Team Assignments

This lab has 25 stations. Each station will have its own HPE DL-series
server to be onboarded into COM. You will be working in a Virtual
Machine using Visual Studio Code with the PowerShell extension.

Your team assignments will be on a separate sheet of paper issued to you
by your lab proctor. Please return the team assignment sheet to your
proctor when finished with this lab.

## Virtual Lab Environment

Upon access to the lab, you will be presented with a Windows desktop.

Each team will have the following physical and virtual infrastructure:

- Windows virtual machine with Visual Studio Code

- One ProLiant DL-series server


# HPE Compute Ops Management PowerShell Library

This lab introduces the HPE Compute Ops Management PowerShell module, a
set of cmdlets for managing and automating your HPE GreenLake
environment. The module enables direct interaction with HPE GreenLake
and Compute Ops Management services from the PowerShell command line,
fitting easily into existing automation workflows.

Development is ongoing. SaaS cloud applications evolve over time. Therefore, this library
will be continuously updated to incorporate new features as they are released by HPE.

This module is available in the PowerShell Gallery under the name [HPECOMCmdlets](https://www.powershellgallery.com/packages/HPECOMCmdlets), following the naming convention used by most HPE modules.

[![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image3.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image3.png){:class="img-600"}{: data-lightbox="gallery"}

The PowerShell Gallery is a repository for sharing and distributing
PowerShell modules and scripts. It's a community-driven platform that
provides access to various PowerShell resources, enabling you to easily
discover, install, and publish your own PowerShell content. The
PowerShell Gallery can be accessed through the PowerShellGet module
(includes `Install-Module`, `Find-Module`, etc.), which comes
pre-installed with Windows PowerShell 5.0 and above.

This project is also associated with a new public GitHub
[repository](https://github.com/jullienl/HPE-COM-PowerShell-Library)
from our community contributor, [Lionel Jullien](https://github.com/jullienl) from HPE. This repository
is where the source code is developed. You can also track
[releases](https://github.com/jullienl/HPE-COM-PowerShell-Library/releases),
report and view
[issues](https://github.com/jullienl/HPE-COM-PowerShell-Library/issues),
and participate in
[discussions](https://github.com/jullienl/HPE-COM-PowerShell-Library/discussions).

[![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image2.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image2.png){:class="img-800"}{: data-lightbox="gallery"}

This library provides a variety of key features for managing HPE
GreenLake and Compute Ops Management. Here are the main features:

- **Authentication**: Establish secure connections to HPE GreenLake using SAML/OIDC Single Sign-On (SSO) or single/multi-factor authentication. Whether you have an existing workspace or not, the library supports flexible
authentication methods to suit your needs.

- **Workspace Management**: Create and manage HPE GreenLake workspaces.

- **Session Tracking**: Automatically track sessions with the global session tracker $HPEGreenLakeSession.

- **User Management**: Invite and manage users within your HPE GreenLake environment, assign roles.

- **Resource Management**: Manage resources such as servers, storage, and networking within your HPE GreenLake environment.

- **Service Provisioning**: Provision services like Compute Ops Management, manage service roles and subscriptions.

- **Device Management**: Add devices individually or in bulk using CSV files, manage device subscriptions and auto-subscriptions, set device locations and connect devices to services.

- **Server Configuration Management**: Create and apply BIOS, storage, OS, and firmware settings. Manage group and apply configurations to groups of servers.

- **Security and Compliance**: Manage iLO security settings and run inventory and compliance checks.

- **Job Scheduling and Execution**: Schedule and execute various tasks like firmware updates, OS installations, and sustainability reports.

- **Notification and Integration**: Enable email notifications for service events and summaries, integrate with external services like ServiceNow.

- **Appliance Management**: Add HPE OneView and Secure Gateway appliances, upgrade HPE OneView appliances.

- **Monitoring and Alerts**: Monitor alerts for your resources to ensure optimal performance and uptime.

- **Reporting**: Generate detailed reports on resource usage, performance, and other metrics.

- **Automation**: Automate repetitive tasks and workflows using PowerShell scripts and cmdlets.

- **Integration**: Seamlessly integrate with other tools and platforms using REST APIs and webhooks.

- **Security**: Implement security best practices and manage access control for your HPE GreenLake environment.

These features collectively provide a comprehensive set of cmdlets to
manage various aspects of your HPE GreenLake environment and any
existing Compute Ops Management service instances.

# Connecting to the lab environment

To access the Windows virtual machine in our VMware Omnissa Horizon lab environment complete these steps:

1. Navigate to <https://labs.compute.cloud.hpe.com>

2. On the Horizon login screen, click the **Omnissa Horizon Web Client** button.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image6.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image6.png){:class="img-500"}{: data-lightbox="gallery"}

3. Login with the Horizon login username and password provided in your login sheet.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image7.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image7.png){:class="img-500"}{: data-lightbox="gallery"}

4. Click on the graphic that represents your Lab environment.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image8.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image8.png){:class="img-600"}{: data-lightbox="gallery"}

    Since Horizon is presenting a remote desktop session inside of your desktop's browser, it may be helpful to hit **F11** at this time to put the browser in full screen mode.

## Preparation of your environment 

1. Start by opening **VS Code** using the shortcut in the VM's desktop:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image9.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image9.png){:class="img-600"}{: data-lightbox="gallery"}

2. VS Code opens with the **Station-Info.ps1** file. This file holds all the credentials and details for your station, so keep it open and within reach:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image10.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image10.png){:class="img-800"}{: data-lightbox="gallery"}

3. A PowerShell terminal is already open in VS Code. Run all the commands of this lab guide in this window:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image11.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image11.png){:class="img-800"}{: data-lightbox="gallery"}

    Your environment is now ready, with **Station-Info.ps1** open in the editor and a PowerShell terminal open for the commands of this lab.

    > **💡 Note: Recovering from a terminal crash**
    >
    > Throughout this lab you will define PowerShell variables (your email, region, workspace name, iLO IP, etc.) and a GreenLake session that only live in memory. If your terminal crashes or is closed, they are lost and the remaining commands will fail.
    > 
    >{: .small-space}
    >
    > To recover quickly, keep **Station-Info.ps1** open and fill in each value of its Lab variables block the moment you define it. Don't forget to save the file (**Ctrl**+**S**) after each update. If your terminal session is lost, open a **new terminal**, run the Lab variables block, and you will be back where you left off in seconds.
    > 
    >{: .small-space}
    >
    > [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image12.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image12.png){:class="img-700"}{: data-lightbox="gallery"}


# Task 1 - How to Install HPECOMCmdlets

<p class="step-meta">(Task 1 of 12) ⏱️ ~5 min</p>

- The first step is to install the library on your Windows virtual machine. Return to the PowerShell console and enter the following command:

  ```powershell
  Install-Module HPECOMCmdlets
  ```

    > **💡 Tip**: Using the **Copy** Button
    >        
    > Throughout this lab, each code block displays a **Copy** button in the middle-right corner. Click it to copy the commands to your clipboard, then press **Ctrl**+**V** to paste them into the PowerShell terminal. This eliminates typing errors and speeds up your workflow.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image16.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image16.png){:class="img-800"}{: data-lightbox="gallery"}

    This command will download and install the module from the official PowerShell Gallery repository. If this is your first time installing a module from the PowerShell Gallery, it will ask you to confirm whether you trust the repository or not. 
    
- Type `Y` when prompted and press **Enter** to continue with the installation.

    This library has no dependencies, so it does not require the installation of any other software or modules to function properly.


[↑ Back to Top](#)

# Task 2 - Get the exported commands

<p class="step-meta">(Task 2 of 12) ⏱️ ~3 min</p>

- Now that the module is installed, you can get the list of commands exported by the module using:

  ```powershell
  Get-Command -Module HPECOMCmdlets
  ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image17.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image17.png){: data-lightbox="gallery"}

    Version [v1.0.27](https://github.com/jullienl/HPE-COM-PowerShell-Library/releases/tag/v1.0.27) of the module includes over 250 cmdlets.

- In PowerShell, cmdlets follow a verb-noun naming convention. In this library, cmdlet names begin with **HPECOM** for Compute Ops Management (e.g., `Get-HPECOMServer`) or **HPEGL** for HPE GreenLake (e.g., `New-HPEGLUser`), reflecting the close integration between both platforms.

- To list all cmdlets in the module related to server resources, use the following command:

  ```powershell
  Get-Command -Module HPECOMCmdlets | ? name -match server
  ```

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image18.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image18.png){:class="img-700"}{: data-lightbox="gallery"}

  This command is especially helpful when you're dealing with many cmdlets and need to pinpoint the one that fits your needs best.

  >💡**Note**   
  >
  >{: .small-space}
  > 
  > `?` is an alias for `Where-Object` in PowerShell, and `-match` is the operator used to determine if a string matches a regular expression, such as `server` in this example.

- `Get-Help` cmdlet is another essential PowerShell command for locating information about new modules. To utilize this command, enter:

  ```powershell
  Get-Help Get-HPECOMserver -Full
  ```

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image19.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image19.png){:class="img-700"}{: data-lightbox="gallery"}

  `Get-Help` (or the alias `Help`) is a PowerShell cmdlet that allows you to retrieve information on other PowerShell cmdlets and functions. 
    
  By running `Get-Help` in the PowerShell console, you can view detailed information about the specified cmdlet, including its syntax, parameters, examples, and related links. Additionally, you can use specific switches such as `-Detailed`, `-Examples`, or `-Full` to customize the output.

- Each cmdlet exported from this module provides detailed examples of how to use the command. To view the examples for the   `Get-HPECOMServer` cmdlet, enter:

  ```powershell
  Help Get-HPECOMServer -Examples
  ```

  This will display a list of examples demonstrating how to use `Get-HPECOMServer` along with detailed explanations of what each example does.

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image20.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image20.png){:class="img-700"}{: data-lightbox="gallery"}


[↑ Back to Top](#)

# Task 3 - Connection to HPE GreenLake

<p class="step-meta">(Task 3 of 12) ⏱️ ~15 min</p>

After the module is installed, the next step is to connect to HPE GreenLake using the `Connect-HPEGL` command.

The library supports three authentication methods:

1. **HPE Account Authentication (Single or Multi-Factor)**

    Authenticate using your HPE account email and password. Multi-factor authentication (MFA) is optionally supported for enhanced security (requires [v1.0.12+](https://github.com/jullienl/HPE-COM-PowerShell-Library/releases/tag/v1.0.12)).

2. **Passwordless SAML/OIDC Single Sign-On (SSO)** (SAML requires [v1.0.18+](https://github.com/jullienl/HPE-COM-PowerShell-Library/releases/tag/v1.0.18) and OIDC requires [v1.0.27+](https://github.com/jullienl/HPE-COM-PowerShell-Library/releases/tag/v1.0.27))

    Connect to a federated (SSO) account using the `-PasswordlessSSOEmail` parameter with your federated email address. Authentication is completed via a push notification or a Time-based One-Time Password (TOTP) — no password is entered.

    - **Supported identity providers:** Okta, PingIdentity, and Microsoft Entra ID. Other IdPs are not supported for SSO — use standard HPE account credentials instead.
    - **Requirement:** Passwordless authentication (push notifications or TOTP) must be enabled on your identity provider. For SAML configuration guidance, refer to [Configuring SAML SSO with HPE GreenLake and Passwordless Authentication](https://jullienl.github.io/Configuring-SAML-SSO-with-HPE-GreenLake-and-Passwordless-Authentication-for-HPECOMCmdlets/).

3. **Password-based SAML/OIDC Single Sign-On (SSO)** (SAML requires [v1.0.26+](https://github.com/jullienl/HPE-COM-PowerShell-Library/releases/tag/v1.0.26) and OIDC requires [v1.0.27+](https://github.com/jullienl/HPE-COM-PowerShell-Library/releases/tag/v1.0.27))

    Connect to a federated (SSO) account that requires a password, using the `-Credential` parameter with your federated email address — federation is detected automatically. If a second factor is required, a push or TOTP challenge fires automatically.

    - **Supported identity providers:** Okta, PingIdentity, and Microsoft Entra ID. Other IdPs are not supported for SSO — use standard HPE account credentials instead.
    - **Unattended automation:** Because no interactive push approval is needed when only a password is required, this method — combined with a securely stored credential — enables truly unattended SSO automation.


## Step 1 - Authenticate to HPE GreenLake

To connect to HPE GreenLake with the PowerShell module, you will use a predefined user account from the lab's organization workspace:

  - Start by setting your email variable. In **Station-Info.ps1**, scroll down to the Lab variables block, click anywhere on the `$MyEmail` line, and press **F8**. VS Code runs that line directly in the PowerShell terminal, so there is no need to copy and paste it:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image21.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image21.png){:class="img-900"}{: data-lightbox="gallery"}

  - Next, store your credentials in a variable. The `Get-Credential` cmdlet opens a prompt that is pre-filled with the email stored in `$MyEmail` as the user name, and returns your credentials as a secure object:

    ```powershell
    $credentials = Get-Credential -UserName $MyEmail
    ```

  - In the prompt, enter the password from your login sheet and click **OK**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image23.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image23.png){:class="img-600"}{: data-lightbox="gallery"}

  - Finally, connect to HPE GreenLake by passing the stored credentials to `Connect-HPEGL`. The connection takes a few seconds:

    ```powershell
    Connect-HPEGL -Credential $credentials -RemoveExistingCredentials
    ```

    The `-RemoveExistingCredentials` parameter deletes any API client credentials that the HPECOMCmdlets module previously created for your account in the lab's organization (for example, during an earlier lab session). This makes sure the module starts with a clean set of credentials.


## Step 2 - Verify your connection

- Once authentication is successful, a secure connection to HPE GreenLake will be established to the lab's organization, allowing you to proceed with subsequent operations.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image24.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image24.png){:class="img-900"}{: data-lightbox="gallery"}
    
    The `Connect-HPEGL` cmdlet is responsible for initiating and managing this connection. Upon establishment, it maintains a persistent session using the `$HPEGreenLakeSession` connection tracker variable, which supports all further module cmdlet activities. Furthermore, the cmdlet issues a temporary API client credential for both HPE GreenLake and any Compute Ops Management service instances provisioned within your workspace.

    > **💡 Note** 
    >
    >{: .small-space}
    > 
    > You can use `Get-Help Connect-HPEGL -Full` to access the complete help documentation, technical details, and in-depth explanations for `Connect-HPEGL`.
    >
    >{: .small-space}
    > 
    > The command to directly connect to an existing and known workspace is: `Connect-HPEGL -Credential $credentials -Workspace "workspace_name"`

Now that you are connected to HPE GreenLake with the PowerShell module, you can optionally open a Chrome browser to access the HPE GreenLake portal and view the results of the commands you will run in the following sections. 

1. From your Horizon desktop, open Google Chrome: 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image25.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image25.png){:class="img-600"}{: data-lightbox="gallery"}
 
2. Click the **HPE GreenLake** bookmark in the **HOL** folder of the bookmarks bar. It opens the portal at `https://common.cloud.hpe.com`. 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image26.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image26.png){:class="img-800"}{: data-lightbox="gallery"}
    
3. Sign in with the GreenLake username listed in **Station Info**:
    
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image27.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image27.png){:class="img-800"}{: data-lightbox="gallery"}

4. On the **Choose sign-in method** page, select **Sign in with SSO**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image28.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image28.png){:class="img-800"}{: data-lightbox="gallery"}

5. On the Microsoft sign-in page, enter the password from your login sheet:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image28a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image28a.png){:class="img-800"}{: data-lightbox="gallery"}

6. You are now on the HPE GreenLake home page.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image28b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image28b.png){:class="img-800"}{: data-lightbox="gallery"}

You may now leave this page open and begin your zero-touch automation experience.


[↑ Back to Top](#)

# Task 4 - Configuration of your workspace

<p class="step-meta">(Task 4 of 12) ⏱️ ~20 min</p>

## Step 1 - Create your first workspace

1. Next, create a workspace. Return to VS Code and, in **Station-Info.ps1**, in the Lab variables block, click anywhere on the `$WorkspaceName` line, and press **F8**. This defines your workspace name variable in the terminal. The name follows the format `COM-ZeroTouch-Lab-xx`, where `xx` is your team number:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image28c.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image28c.png){:class="img-800"}{: data-lightbox="gallery"}

2. Now build the full command using PowerShell's **tab completion** feature. Tab completion is a built-in PowerShell mechanism that, after typing a parameter name followed by a space, lets you press the **Tab** key to cycle through all valid values for that parameter — no need to memorize them.

    - Start by typing the following command in the terminal. Do not press **Enter** until the command is complete:

      ```powershell
      New-HPEGLWorkspace -Name $WorkspaceName -InOrganization
      ```

      The `-InOrganization` parameter creates the new workspace as a member of the lab's organization. **Do not forget it**: without it, an orphan workspace is created outside the organization and you will run into issues later in this lab.

    - Add the `-Country` parameter followed by a space, then press **Tab** to browse the list of supported countries and select yours. You can also type the first letter(s) of your country before pressing **Tab** to jump directly to matching entries. For example, type `I` to jump to countries starting with "I" such as *Iceland*, *India*, *Ireland*, etc.:

      ```powershell
      -Country 
      ```

    - Complete the command with the `-Street` parameter. You can enter any address, real or fictional, since the workspace will be automatically deleted when the lab is reset:

      ```powershell
      -Street "Your street address"
      ```

    - Your complete command should look like:
     
      `New-HPEGLWorkspace -Name $WorkspaceName -InOrganization -Country Canada -Street "123 Main Street"`
       
       Press **Enter** to run it:

        >  **📌 Note**   
        >
        >{: .small-space}
        > 
        > If you struggle to build the command, you can copy this following example with the **Copy** button and paste it into the terminal instead:
        >
        > ```powershell
        > New-HPEGLWorkspace -Name $WorkspaceName -InOrganization -Country Finland -Street "Main street"
        > ```
        >
        >{: .small-space}
        > 
        > In the example above, only the `name`, `type`, `country`, and `street` parameters are included because they are required. However, you can also specify optional parameters like `city`, `state`, `email`, and others.

3. After executing this command, the workspace is created, 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image29.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image29.png){:class="img-900"}{: data-lightbox="gallery"}

4. To connect to your new workspace, enter:

   ```powershell
   Connect-HPEGL -Credential $credentials -Workspace $WorkspaceName
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image30.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image30.png){:class="img-1000"}{: data-lightbox="gallery"}

5. Give the lab administrator account access to your workspace, so the lab team can recover your resources if something goes wrong:

   ```powershell
   New-HPEGLUser -Email "com.demoad@gmail.com" -RoleName 'Workspace Administrator'
   ```

    > **⚠️ Note**
    >
    >{: .small-space}
    > 
    > <span style="color:red">Do not skip this step!</span>
    >
    >{: .small-space}
    > 
    > An organization administrator cannot access a workspace unless a workspace administrator grants access, so without it the lab team cannot release your server and subscription key.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image30a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image30a.png){:class="img-600"}{: data-lightbox="gallery"}

6. To check the content of your workspace, enter:

   ```powershell
   Get-HPEGLWorkspace
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image31.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image31.png){:class="img-800"}{: data-lightbox="gallery"}


## Step 2 - Provision Compute Ops Management

The following step involves setting up services. There are several kinds of services you can provision across different regions.

1. To see all available services, use:

   ```powershell
   Get-HPEGLService -ShowUnprovisioned
   ```

    This command lists all unprovisioned services, including those for networking devices (HPE Aruba Networking Central), compute devices (Compute Ops Management), storage devices (Data Services), OpsRamp, etc.

    The **ProvisionStatus** column will indicate UNPROVISIONED for each listed service. You can choose to provision any of these, as long as you have the needed permissions.

2. In this lab exercise, you'll set up the Compute Ops Management (COM) service in the European central region. Enter:

   ```powershell
   $Region = "eu-central"
   New-HPEGLService -Name "Compute Ops Management" -Region $Region
   ```

    > **💡 Note**   
    >
    >{: .small-space}
    > 
    > Additional regions are available; to view different supported regions, use:  
    > `Get-HPEGLService -Name "Compute Ops Management"`

3. To confirm that the COM instance is provisioned, run:

   ```powershell
   Get-HPEGLService -ShowProvisioned
   ```

4. Next, assign the **Compute Ops Management administrator** role to your user account. This role gives you full access to the COM instance you just provisioned:

   ```powershell
   Add-HPEGLRoleToUser -Email $MyEmail -RoleName 'Compute Ops Management administrator'
   ```

    > **💡 Note**   
    >
    >{: .small-space}
    > 
    > The **Tab** key can be used to display the available list of role names.

5. Finally, verify the role assignments with:

   ```powershell
   Get-HPEGLUserRole -Email $MyEmail
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image31b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image31b.png){:class="img-800"}{: data-lightbox="gallery"}

    The output also shows the **Workspace Administrator** role, which HPE GreenLake automatically assigns to the user who creates a workspace. 

## Step 3 - Set a location

Locations in Service Delivery Information (SDI) store addresses, contacts, and support details for automation. Assigning a device to a location links it physically for automated support, including ticket creation with HPE.

This step is essential for automatically creating a ticket with HPE support.

1. In **Station-Info.ps1**, scroll down to the Lab variables block and replace the value of `$LocationName` with a city name of your choice. Click anywhere on that line and press **F8** to define the variable in the terminal, then save the file with **Ctrl**+**S**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image31a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image31a.png){:class="img-800"}{: data-lightbox="gallery"}

2. To create the location, edit the placeholder values in the following command (description, country, street address, and postal code), then run it. After typing `-Country`, press the **Tab** key to browse all supported countries:  

   ```powershell
   New-HPEGLLocation -Name $LocationName -Description "Your customized description" -Country "Your country" -Street "Your customized street address" -City $LocationName -State "NA" -PostalCode "123456789" -PrimaryContactEmail $MyEmail
   ```

2. Check the location with:

   ```powershell
   Get-HPEGLLocation
   ```

## Step 4 - Add a subscription to your workspace

1. To activate compute devices that will be added later to your workspace, you need to add a COM subscription key. Copy the key from **Station-Info.ps1** and replace the placeholder in the following command, then run it:

   ```powershell
   New-HPEGLSubscription -SubscriptionKey "<subscription key from Station-Info.ps1>"
   ```

2. To check the subscription, enter:

   ```powershell
   Get-HPEGLSubscription
   ```

3. Workspaces have two subscription management options:

    - **Assignment**: Controls automatic subscription assignment when devices are added.

    - **Re-assignment**: Controls if subscriptions are reassigned when one expires or is canceled. Note that auto-reassignment is enabled by default for all device types. 

    To retrieve these options, enter:

   ```powershell
   Get-HPEGLDeviceAutoSubscription
   ```
   ```powershell
   Get-HPEGLDeviceAutoReassignSubscription
   ```

4. Set the automatic subscription assignment for Compute:

   ```powershell
   Set-HPEGLDeviceAutoSubscription -ComputeSubscriptionTier ENHANCED
   ```

    > **💡 Note**
    >
    >{: .small-space}
    > 
    > Auto-reassignment is enabled by default for all device types; therefore, manual configuration of automatic subscription
    > re-assignment for Compute devices is generally unnecessary. For reference, you may enable it manually using  
    > `Set-HPEGLDeviceAutoReassignSubscription -Computes` if it was previously disabled with `Remove-HPEGLDeviceAutoReassignSubscription.`


[↑ Back to Top](#)

# Task 5 - Onboarding devices

<p class="step-meta">(Task 5 of 12) ⏱️ ~15 min</p>

You can add devices to a workspace either one at a time or in bulk.
Another option is to use a COM activation key, which lets you add single
or multiple compute devices directly to a Compute Ops Management (COM)
instance. In this lab, you'll be using that specific method.

> **🎯 Note**
>
>{: .small-space}
> 
> For onboarding multiple servers or in production, a better approach is to use the [HPE Compute Ops Management Onboarding Scripts](https://github.com/jullienl/HPE-Compute-Ops-Management/tree/main/PowerShell/Onboarding). Two complementary scripts are available, pick the one that matches how your iLOs reach COM:
> - [Prepare-and-Connect-iLOs-to-COM-v2.ps1](https://github.com/jullienl/HPE-Compute-Ops-Management/blob/main/PowerShell/Onboarding/Prepare-and-Connect-iLOs-to-COM-v2.ps1) — bulk, CSV-driven onboarding for any connection type (direct, web proxy, or Secure Gateway). It handles authentication, activation key generation, local iLO firmware updates, and initial iLO configuration (DNS, NTP, tags, location).
> - [Discover-and-Onboard-iLOs-via-SecureGateway.ps1](https://github.com/jullienl/HPE-Compute-Ops-Management/blob/main/PowerShell/Onboarding/Discover-and-Onboard-iLOs-via-SecureGateway.ps1) — discovery-driven onboarding for estates entirely behind an HPE Secure Gateway. The gateway discovers the iLOs and updates their firmware server-side, so there is no IP list to build and no firmware files to stage (requires HPECOMCmdlets v1.0.26+).   
>
> Both deliver a consistent zero-touch process at scale.


## Step 1 - Onboard one server

For this lab, you will onboard a single server manually so you can understand each command and validation step.  

1. To generate an activation key for connecting your server to the Compute Ops Management instance in the region you provisioned earlier, use the following command:

   ```powershell
   $Activation_Key = New-HPECOMServerActivationKey -Region $Region
   ```

    This command should be used in conjunction with the `-Region` parameter, consistent with other HPECOM cmdlets, to specify the COM instance---that is, the region where the COM instance is provisioned and where the command will be executed. Please note that the auto-completion tab can be utilized to display the available region codes provisioned within your workspace.

    > **🔔 Note** 
    >
    >{: .small-space}
    > 
    > This method is supported only for the following iLO versions:  
    > - iLO 5: Version 3.09 or later  
    > - iLO 6: Version 1.64 or later
    > - iLO 7: Version 1.12.00 or later 

2. To see the activation key that has been generated, you can enter:

   ```powershell
   $Activation_key
   ```

    > **💡 Note**
    >
    >{: .small-space}
    > 
    > No subscription key is needed with this command because
    > auto-subscription for Compute has been enabled earlier using
    > `Set-HPEGLDeviceAutoSubscription`.

3. Next, define the variables for your iLO. In **Station-Info.ps1**, scroll down to the Lab variables block, select both the `$iLO_IP` and `$iLO_Password` lines, and press **F8** to run them in the terminal. `$iLO_Password` is the password of the iLO **Administrator** account:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image31c.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image31c.png){:class="img-800"}{: data-lightbox="gallery"}

4. Then execute the following commands to connect the iLO to the COM instance using the activation key that was generated earlier:

   ```powershell
   $iLO_SecurePassword = ConvertTo-SecureString $iLO_Password -AsPlainText -Force
   $iLO_credential = New-Object System.Management.Automation.PSCredential("Administrator", $iLO_SecurePassword)
   Connect-HPEGLDeviceComputeiLOtoCOM -iLOCredential $iLO_credential -IloIP $iLO_IP -ActivationKeyfromCOM $Activation_Key -SkipCertificateValidation
   ```

    > **💡 Note**
    >
    >{: .small-space}
    > 
    > The `-SkipCertificateValidation` parameter bypasses
    > all certificate validation steps, including checks for expiration,
    > revocation, and trusted root authority. This approach is insecure
    > and generally discouraged. It should only be used with known hosts
    > that are using self-signed certificates, which applies in our
    > scenario.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image32.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image32.png){:class="img-1000"}{: data-lightbox="gallery"}
    
    <br>

    > 💡 **Note**
    >
    >{: .small-space}
    > 
    > The `Connect-HPEGLDeviceComputeiLOtoCOM` cmdlet provides additional parameters to connect iLO through a COM Secure Gateway or through a web proxy.
    >
    > {: .small-space}
    > 
    > In scenarios involving a Secure Gateway (**not applicable to this lab**), you have two options.
    >
    > {: .small-space}
    > 
    > **Option A — Connect a single iLO through the Secure Gateway** (set the Secure Gateway as the iLO's proxy):
    > 1. Obtain a valid subscription key:  
    > ```powershell
    > $SubscriptionKey = Get-HPEGLSubscription -ShowWithAvailableQuantity -ShowValid -FilterBySubscriptionType Server | Select-Object -First 1 -ExpandProperty key
    > ```
    > 2. Retrieve the Secure Gateway object:  
    > ```powershell
    > $SG = Get-HPECOMAppliance -Region $Region -Name sg01.domain.com
    > ```
    > 3. Create a Secure Gateway activation key:  
    > ```powershell
    > $Activation_Key = New-HPECOMServerActivationKey -Region $Region -SecureGateway $SG -SubscriptionKey $SubscriptionKey
    > ```
    > 4. Use the Secure Gateway activation key to connect the iLO to COM and set the Secure Gateway as the iLO's proxy server:  
    > ```powershell
    > Connect-HPEGLDeviceComputeiLOtoCOM -iLOCredential $iLO_credential -IloIP "xxx.xxx.xxx.xxx" -ActivationKeyfromCOM $Activation_Key -SkipCertificateValidation -IloProxyServer sg01.domain.com -IloProxyPort 8080
    > ```
    >
    >{: .small-space}
    > 
    > **Option B — Discover and onboard an entire estate behind a Secure Gateway in one batch job** (requires [v1.0.26+](https://github.com/jullienl/HPE-COM-PowerShell-Library/releases/tag/v1.0.26)). This native, gateway-driven workflow needs **no activation key** (COM generates it automatically) and **updates the iLO firmware automatically** on any server that is below the minimum required version:
    > 1. Discover the iLOs reachable through the Secure Gateway:  
    > ```powershell
    > Invoke-HPECOMSecureGatewayServerDiscovery -Region $Region -SecureGateway "sg01.domain.com"
    > ```
    > 2. Onboard every discovered server in a single batch job (firmware compliance handled automatically):  
    > ```powershell
    > Get-HPECOMSecureGatewayServerDiscovery -Region $Region -SecureGateway "sg01.domain.com" |
    >     Connect-HPECOMSecureGatewayDiscoveredServer -IloCredential $iLO_credential -SubscriptionKey $SubscriptionKey
    > ```
    > `Connect-HPECOMSecureGatewayDiscoveredServer` can also configure DNS/NTP and assign a location, tags, and a service delivery contact inline using `-Dns`, `-Ntp`, `-LocationName`, `-Tags`, and `-ServiceDeliveryContact`. Add `-WhatIf` to preview every action without making any change.
    >
    >{: .small-space}
    >
    > To automate this at scale, see [🛡️ Discover-and-Onboard-iLOs-via-SecureGateway.ps1](https://github.com/jullienl/HPE-Compute-Ops-Management/blob/main/PowerShell/Onboarding/Discover-and-Onboard-iLOs-via-SecureGateway.ps1) (v1.0.26+). This Secure-Gateway-native onboarding script discovers every iLO behind an HPE Secure Gateway and onboards them in a single batch job — no CSV of IP addresses and no local firmware staging required (the gateway discovers the iLOs and updates their firmware server-side). It automates GreenLake authentication, COM instance / Secure Gateway / subscription / location validation, optional iLO DNS/NTP, subscription, location, tags and service-delivery contact, shared or per-iLO credentials (CSV), with a `-Check` pre-flight triage table and CSV status reporting. For direct, web-proxy, or CSV-driven onboarding, use its companion [Prepare-and-Connect-iLOs-to-COM-v2.ps1](https://github.com/jullienl/HPE-Compute-Ops-Management/blob/main/PowerShell/Onboarding/Prepare-and-Connect-iLOs-to-COM-v2.ps1) instead.
    >
    > 
    {: .no-copy}


6. You can then verify the onboarded servers using the following cmdlet:

   ```powershell
   Get-HPEGLDevice
   ```

    [![A screenshot of a computer Description automatically generated]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image33.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image33.png){:class="img-1000"}{: data-lightbox="gallery"}

    > **💡 Note**
    >
    >{: .small-space}
    > 
    > This method not only automatically assigns servers to
    > the COM service instance but also automatically applies a
    > subscription key to the devices.

7. As the device has been automatically assigned to your COM instance with a subscription key, you are now able to utilize COM cmdlets. For instance, you may use:

   ```powershell
   Get-HPECOMServer -Region $Region
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image34.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image34.png){:class="img-1000"}{: data-lightbox="gallery"}

    Note that the output differs slightly from the output of the `Get-HPEGLDevice` command. It adds additional information such as the power state, the connected state, the iLO IP address, and more. 
    
    However, always remember that the output is a formatted view and does not show the entire content of the returned object. To get the full details, you need to pipe the command to `| Format-List` (or `| fl`) at the end.

8. To determine the number of remaining licenses, execute the following command:

   ```powershell
   Get-HPECOMServer -Region $Region -ShowSubscriptionDetails
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image35.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image35.png){:class="img-900"}{: data-lightbox="gallery"}

9. Before proceeding with the next steps in the lab, ensure that your server is powered on by checking the **PowerState** column in the output above. If the server is not **ON**, run the following command:

   ```powershell
   Get-HPECOMServer -Region $Region | Start-HPECOMServer
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image36.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image36.png){:class="img-700"}{: data-lightbox="gallery"}

    This command powers on all servers managed by COM. Since you currently have only one server onboarded, it will start that specific device.

## Step 2 - Set device location and tags

1. Next you need to set the device location. As indicated earlier, this step is important to ensure that support cases are automatically created in the event of device failures. To do so, enter:

   ```powershell
   Get-HPEGLdevice | Set-HPEGLDeviceLocation -LocationName $LocationName
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image37.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image37.png){:class="img-500"}{: data-lightbox="gallery"}

2. To verify that the location has been correctly assigned to your device, use the following command:

   ```powershell
   Get-HPEGLdevice
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image38.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image38.png){:class="img-1000"}{: data-lightbox="gallery"}

    > **📝 Note**
    >
    >{: .small-space}
    > 
    > Expand the PowerShell console to its maximum width to ensure that you can see the Location property in the output.

3. Next, you can assign tags to your device. A tag is a form of metadata that uses a key-value pair (e.g., App=AI) and can be applied to any resource. Tags are primarily used to categorize resources based on purpose, owner, environment, or other criteria.

    > **ℹ️ Note**
    >
    >{: .small-space}
    > 
    > Tags are particularly important for extending filtering
    > capabilities and enhancing the use of scope-based access control,
    > which allows you to limit users' abilities to perform actions on a
    > selected list of resources. These resources can be categorized based
    > on various criteria, such as generation, model, groups, and most
    > importantly, tags.

4. Add two tags to your device: one for country location and one for AI application type. Use this command:

   ```powershell
   Get-HPEGLDevice | Add-HPEGLDeviceTagToDevice -Tags "Country=FR, App=AI"
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image39.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image39.png){:class="img-900"}{: data-lightbox="gallery"}

5. To verify that the tags have been correctly assigned to your device, use the following command:

   ```powershell
   Get-HPEGLdevice -ShowTags
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image40.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image40.png){:class="img-800"}{: data-lightbox="gallery"}


[↑ Back to Top](#)

# Task 6 - Configuration of Compute Ops Management

<p class="step-meta">(Task 6 of 12) ⏱️ ~25 min</p>

The following step involves setting up Compute Ops Management. This
process includes various tasks like setting up server configurations,
forming groups, assigning servers to these groups and much more. The
steps to complete this setup are outlined below:

## Step 1 - Create server settings

A setting in COM is a collection of parameters that you can apply to one
or more servers through groups. These settings include parameters such
as BIOS, internal storage, firmware, OS, etc.

### Server Bios Settings

Server BIOS Settings allow you to create a new BIOS configuration for
servers using either a workload profile or custom parameters, ensuring
consistent settings across server groups. The
`New-HPECOMSettingServerBios` cmdlet provides many options; for
details on available parameters and how they behave with different iLO
versions and server generations, refer to the help section of the
cmdlet.

> **ℹ️ Note**
>
>{: .small-space}
> 
> Server BIOS settings can't be managed from the UI---they
> can only be created today through the COM API using the
> `New-HPECOMSettingServerBios` cmdlet.

1. To create a bios setting with a few customized options, enter:

   ```powershell
   $BiosSettingName = "Custom-Bios-For-AI"
   New-HPECOMSettingServerBios -Region $Region -Name $BiosSettingName -WorkloadProfileName  "Virtualization - Max Performance" -AsrStatus:$True -AsrTimeoutMinutes Timeout10
   ```

    This command creates a new BIOS setting configuration tailored for virtualization with maximum performance. It also enables the Automatic Server Recovery (ASR) feature and sets the timeout for the ASR feature to 10 minutes.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image41.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image41.png){:class="img-600"}{: data-lightbox="gallery"}

2. To verify the newly created BIOS setting, enter:

   ```powershell
   Get-HPECOMSetting -Region $Region -Name $BiosSettingName
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image42.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image42.png){:class="img-1000"}{: data-lightbox="gallery"}

### Server Internal Storage Settings

These settings allow you to configure a new server storage setup with different volumes using selected RAID type and size, ensuring uniform storage across groups.

3. To configure for example a configuration with two volumes: OS on RAID1 with two SAS drives, and data on RAID5 with three SSDs plus two spares, enter:

   ```powershell
   $InternalStorageSettingName = "RAID-Configuration-for-AI-Servers"
   $volume1 = New-HPECOMSettingServerInternalStorageVolume -RAID RAID5 -DriveTechnology  NVME_SSD -IOPerformanceMode ENABLED -ReadCachePolicy OFF -WriteCachePolicy  WRITE_THROUGH -SizeinGB 100 -DrivesNumber 3 -SpareDriveNumber 2
   $volume2 = New-HPECOMSettingServerInternalStorageVolume -RAID RAID1 -DriveTechnology  SAS_HDD
   New-HPECOMSettingServerInternalStorage -Region $Region -Name $InternalStorageSettingName -Volumes $volume1, $volume2 -Description "RAID1 and RAID5 server settings for AI systems"
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image43.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image43.png){:class="img-800"}{: data-lightbox="gallery"}

4. To verify the newly created internal storage setting, enter:

   ```powershell
   Get-HPECOMSetting -Region $Region -Name $InternalStorageSettingName
   ```
    
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image44.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image44.png){:class="img-700"}{: data-lightbox="gallery"}

5. To verify the two volumes that are defined:

   ```powershell
   Get-HPECOMSetting -Region $Region -Name $InternalStorageSettingName -ShowVolumes
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image45.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image45.png){:class="img-500"}{: data-lightbox="gallery"}

### Server Firmware Settings

These settings allow you to set baselines for updating server firmware,
helping maintain consistent firmware versions across groups of servers.

6. To set up firmware, start by finding the latest baseline for the relevant generation using:

   ```powershell
   Get-HPECOMFirmwareBaseline -Region $Region -Generation 11 -LatestVersion
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image46.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image46.png){:class="img-700"}{: data-lightbox="gallery"}

7. To create the firmware setting with the latest baselines for both Gen10 and Gen11, enter:

   ```powershell
   $FirmwareSettingName = "Latest-Firmware-Baselines-for-AI"
   $Gen10_Firmware_Baseline = Get-HPECOMFirmwareBaseline -Region $Region -LatestVersion -Generation 10 | select -ExpandProperty releaseVersion
   $Gen11_Firmware_Baseline = Get-HPECOMFirmwareBaseline -Region $Region -LatestVersion -Generation 11 | select -ExpandProperty releaseVersion
   New-HPECOMSettingServerFirmware -Region $Region -Name $FirmwareSettingName -Description "FW baseline for AI servers" -Gen10FirmwareBaselineReleaseVersion $Gen10_Firmware_Baseline -Gen11FirmwareBaselineReleaseVersion $Gen11_Firmware_Baseline
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image47.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image47.png){:class="img-700"}{: data-lightbox="gallery"}

8. To verify the newly created firmware setting, enter:

   ```powershell
   Get-HPECOMSetting -Region $Region -Name $FirmwareSettingName
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image48.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image48.png){:class="img-900"}{: data-lightbox="gallery"}

### iLO Settings

ILO settings enable the configuration of specific parameters to standardize iLO management across server groups. These settings support a range of options, including network protocols, SNMP, user accounts, security features, and update services. The `New-HPECOMSettingiLOSettings` cmdlet provides many options; for details on available parameters, refer to the help section of the cmdlet.

1. To configure iLO settings, enter:

   ```powershell
   $iLOSettingName = "AI_iLO_Settings"
   New-HPECOMSettingiLOSettings -Region $Region -Name $iLOSettingName -Description "iLO Settings for AI Servers" -VirtualMedia Enabled -AccountServicePasswordComplexity Enabled -WebServerSSL Enabled -AcceptThirdPartyFirmwareUpdates Disabled
   ```
    
    This command activates iLO virtual media, enforces password complexity, enables HTTPS, and disables third-party firmware updates.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image49.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image49.png){:class="img-600"}{: data-lightbox="gallery"}

2. To verify the newly created iLO settings, enter:

   ```powershell
   Get-HPECOMSetting -Region $Region -Name $iLOSettingName
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image50.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image50.png){:class="img-900"}{: data-lightbox="gallery"}

## Step 2 - Create a group

In this task you will create a new group incorporating the different settings created earlier. Groups enable you to organize your servers into custom-defined sets for easier monitoring and manageability. The server-related settings and policies you created earlier can be applied to a single group, as you will do in this lab, or to multiple groups as needed.

1. To create a new group, enter:

   ```powershell
   $GroupName = "AI_Group"
   New-HPECOMGroup -Region $Region -Name $GroupName -Description "My new group for AI servers"  -BiosSettingName $BiosSettingName -AutoBiosApplySettingsOnAdd:$false -iLOSettingName $iLOSettingName -AutoIloApplySettingsOnAdd:$true -FirmwareSettingName $FirmwareSettingName -AutoFirmwareUpdateOnAdd:$false -PowerOffServerAfterFirmwareUpdate:$false -FirmwareDowngrade:$false -StorageSettingName $InternalStorageSettingName -AutoStorageVolumeCreationOnAdd:$false -AutoStorageVolumeDeletionOnAdd:$false -TagUsedForAutoAddServer "App=AI"
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image51.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image51.png){:class="img-500"}{: data-lightbox="gallery"}

    This command creates the new group "AI_Group" with previously configured BIOS, firmware, storage, and iLO settings. Additionally, the command specifies whether certain actions, such as applying settings or creating storage volumes, should be automated when servers are added to the group. These are called group policies. The "App=AI" tag is defined so that any server with this tag during onboarding will automatically be added to this group.

    > **💡 Note**
    >
    >{: .small-space}
    > 
    > The server operating system image setting is not used
    > in this command but is another setting that can be utilized to
    > install the operating system using an ISO image and optionally a
    > kickstart file.

2. To verify the newly created group, enter:

   ```powershell
   Get-HPECOMGroup -Region $Region
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image52.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image52.png){:class="img-900"}{: data-lightbox="gallery"}

    Note that, as configured earlier, 4 settings are applied to that group.

3. To display the settings list, type:

   ```powershell
   Get-HPECOMGroup -Region $Region -Name $GroupName -ShowSettings
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image53.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image53.png){:class="img-700"}{: data-lightbox="gallery"}

4. Additionally, you may review the policies currently assigned to the group by using the following:

   ```powershell
   Get-HPECOMGroup -Region $Region -Name $GroupName -ShowPolicies
   ```
    
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image54.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image54.png){:class="img-600"}{: data-lightbox="gallery"}

    Keep in mind that only the iLO settings take effect right away after you add servers to the group.

## Step 3 - Add servers to the group

The next task is to add your server to the new group. According to the group policies, only the iLO settings will be applied immediately upon adding the servers to the group. 

1. To assign all servers (in this instance, only one server) to the newly created group, proceed as follows:

   ```powershell
   Get-HPECOMServer -Region $Region | Add-HPECOMServerToGroup -GroupName $GroupName
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image55.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image55.png){:class="img-700"}{: data-lightbox="gallery"}

2. To verify that the new server has been added to the group, enter the following command:

   ```powershell
   Get-HPECOMGroup -Region $Region -Name $GroupName -ShowMembers
   ```
    
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image56.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image56.png){:class="img-600"}{: data-lightbox="gallery"}

3. To monitor the progress of active related group jobs, execute the following command at regular intervals:

   ```powershell
   Get-HPECOMJob -Region $Region -Category Group -ShowRunning
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image57.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image57.png){:class="img-800"}{: data-lightbox="gallery"}

    This command shows all the running jobs associated with the group category.

    > **📝 Note**
    >
    >{: .small-space}
    > 
    > Each time a server is added to a group that includes
    > firmware or iLO settings, an automatic process is initiated. This
    > process triggers a group firmware compliance report job and a group
    > iLO settings compliance job to ensure the servers meet the
    > requirements of the associated firmware baselines and iLO settings.

4. To review the related server jobs that are presently active, execute the command multiple times:

   ```powershell
   Get-HPECOMJob -Region $Region -Category Server -ShowRunning
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image58.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image58.png){:class="img-800"}{: data-lightbox="gallery"}

    This command lists active jobs for the server category, focusing on the "add to group" action.

5. Once all jobs have finished running, execute the command below to check their status:

   ```powershell
   Get-HPECOMJob -Region $Region
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image59.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image59.png){:class="img-900"}{: data-lightbox="gallery"}

    > **📝 Note**
    >
    >{: .small-space}
    > 
    > Compute Ops Management tracks iLO settings and compares
    > them to the desired configuration. Whenever iLO changes are
    > detected, Compute Ops Management automatically verifies compliance.

6. You can check the compliance status of firmware and ILO settings in several ways, such as by using `Get-HPECOMGroup` or `Get-HPECOMServer`. To verify the group compliance, use the following method:

   ```powershell
   Get-HPECOMGroup -Region $Region -Name $GroupName -ShowCompliance
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image60.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image60.png){:class="img-1000"}{: data-lightbox="gallery"}

    This command generates a comprehensive compliance status report for all types, including firmware, iLO settings, and external storage. Notably, the iLO settings status is 'COMPLIANT,' which confirms that the group-defined iLO settings have been properly implemented on the iLO.

    > **📝 Note**
    >
    >{: .small-space}
    > 
    > The COM API does not track BIOS settings compliance.
    > This is why you only see these three compliance types in the cmdlets

    > **💡 Note**
    >
    >{: .small-space}
    > 
    > `Get-HPECOMServer` includes several parameters `-ShowGroupCompliance`, `-ShowGroupiLOSettingsCompliance`, or `-ShowGroupFirmwareCompliance`---that allow you to directly check compliance on a specified server.


[↑ Back to Top](#)

# Task 7 - Gathering Comprehensive Server Inventory Information

<p class="step-meta">(Task 7 of 12) ⏱️ ~5 min</p>

Keeping accurate server inventory is crucial for effective IT
management---it enables quick troubleshooting, ensures compliance, and
helps identify issues before they escalate. Compute Ops Management
streamlines this by automatically collecting and updating detailed
server inventory, so administrators always have the latest information
on hand.

To obtain detailed server inventory information, use the `Get-HPECOMServerInventory` cmdlet along with the `-Name` parameter. The `-Name` parameter accepts either the server's name or its serial number, allowing you to specify the server from which you wish to retrieve inventory data.

1. But before that, capture the serial number of your server to facilitate all subsequent commands, enter:

   ```powershell
   $SN = Get-HPECOMServer -Region $Region | Select-Object -ExpandProperty SerialNumber
   ```

2. Then to generate a detailed memory report of your server using the `$SN` variable, run:

   ```powershell
   Get-HPECOMServerInventory -Region $Region -Name $SN -ShowMemory
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image61.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image61.png){:class="img-1000"}{: data-lightbox="gallery"}

3. Additional reporting options are available via the same command, like for a report on the CPU:

   ```powershell
   Get-HPECOMServerInventory -Region $Region -Name $SN -ShowProcessor
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image62.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image62.png){:class="img-1000"}{: data-lightbox="gallery"}

    There are several **Show** commands for different server inventory data. For efficiency, type **-Show** and press **CTRL**+**SPACE** to view all property options or use **Tab** for auto-completion.

    > **💡 Note**
    >
    >{: .small-space}
    > 
    > Running `-ShowSoftware` may return no data if your
    > server's operating system or HPE Agentless Management Service (AMS)
    > is not installed or running. Same with `-ShowSmartUpdateTool` if SUT
    > is not installed and running.

    > 💡 **Note**
    >
    >{: .small-space}
    > 
    > If it is necessary to initiate the collection of server
    > inventory data (for example, if existing data may be outdated), the
    > following command can be used to force a hardware inventory
    > collection:
    > ```powershell
    > Get-HPECOMServer -Region $Region | New-HPECOMServerInventory -Async
    > ```
    > The `-Async` parameter allows the cmdlet to return the asynchronous
    > job resource immediately. By default, the cmdlet will wait for the job
    > to finish before returning.
    {: .no-copy}

[↑ Back to Top](#)

# Task 8 - Monitoring Server Health, Support, and Warranty Status

<p class="step-meta">(Task 8 of 12) ⏱️ ~10 min</p>

One of the key responsibilities in server management is troubleshooting
issues, managing open cases, monitoring server health, and ensuring that
servers remain under warranty coverage. In Task 8, effective server
management includes tasks such as confirming operational status,
reviewing health summaries, monitoring current activities and alerts,
retrieving support details and cases, and identifying servers with
recent support incidents for proactive maintenance. The
`Get-HPECOMServer` cmdlet, along with its related inventory and job
parameters, provides a comprehensive toolkit for these tasks.
Specifically, you can:

- Check overall server health and component status (fans, memory,
  network, power supplies, processor, storage, temperature, BIOS, health
  LEDs) using `-ShowHealthStatus`.

- Review current activities and alerts with `-ShowActivities` and `-ShowAlerts`.

- Retrieve detailed support information and warranty details using `-ShowSupportDetails`.

- Manage and track open support cases with `-ShowSupportCases`, and identify servers with recent support cases via `-ShowServersWithRecentSupportCases`.

- Review recent jobs performed on the server using `-ShowJobs`.

These features collectively enable robust monitoring, efficient troubleshooting, and proactive resolution of server issues, ensuring optimal server performance and support coverage.

## Step 1 - Getting server health status, activities, jobs and alerts

The first step in server troubleshooting is to confirm that the server is operational and verify the absence of any active alerts. 

1. To review your server's health status, execute the following command:

   ```powershell
   Get-HPECOMServer -Region $Region -Name $SN -ShowHealthStatus
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image63.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image63.png){:class="img-800"}{: data-lightbox="gallery"}

2. To retrieve the list of activities from the past month on your server, you can use:

   ```powershell
   Get-HPECOMServer -Region $Region -Name $SN -ShowActivities
   ```
    
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image64.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image64.png){:class="img-900"}{: data-lightbox="gallery"}

    > You can use the dedicated cmdlet `Get-HPECOMActivity -Region $Region -SourceName $SN` to retrieve COM activities, which offers enhanced options such as filtering by time, category, or source name.

3. To retrieve all alerts associated with your server, use:

   ```powershell
   Get-HPECOMServer -Region $Region -Name $SN -ShowAlerts
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image65.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image65.png){:class="img-1000"}{: data-lightbox="gallery"}

    > Alerts provide security information and issues related to servers. By
    > default, all alerts associated with your server are returned. You can
    > use the dedicated cmdlet `Get-HPECOMAlert` to get more options and
    > filters.

4. You may receive some returned alerts with a less-than-ideal output view. To view different properties, consider running:

   ```powershell
   Get-HPECOMServer -Region $Region -Name $SN -ShowAlerts | Format-List
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image66.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image66.png){:class="img-700"}{: data-lightbox="gallery"}

5. To obtain a comprehensive list of jobs associated with your server for the last month, including their current state "PENDING" (waiting to start), "RUNNING" (in progress), "STALLED" (stuck), "ERROR" (failed), or "COMPLETE" (finished successfully), you can run:

   ```powershell
   Get-HPECOMServer -Region $Region -Name $SN -ShowJobs
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image67.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image67.png){:class="img-700"}{: data-lightbox="gallery"}

    > You can also utilize the specialized cmdlet `Get-HPECOMJob -Region $Region -SourceName $SN` to retrieve a list of jobs associated with a specific source name. By default, this command returns jobs from the past seven days, but you can broaden your search using parameters like `-ShowLastMonth` to include the previous month or `-ShowAll` for the complete job history. Additionally, you have the option to filter results to display only jobs that are currently running with `-ShowRunning`, or to show only jobs that are waiting in the queue by using `-ShowPending`.

6. Please be advised that to obtain the list of jobs related to your group, you may use the following method:

   ```powershell
   Get-HPECOMJob -Region $Region -SourceName $GroupName
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image68.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image68.png){:class="img-1000"}{: data-lightbox="gallery"}

7. If you need to view detailed job information or troubleshoot specific tasks, you can refine your queries further by using additional parameters. For example, to quickly identify and analyze the most recent job that has failed, you can target your search accordingly:

   ```powershell
   Get-HPECOMJob -Region $Region | Where-Object resultCode -eq FAILURE | Select-Object -First 1 | Format-List
   ```

    This flexibility helps in managing and monitoring server operations more effectively, especially in large or complex environments.

## Step 2 - Getting server support details

The subsequent phase in server troubleshooting involves verifying the
support details. This information is crucial for determining warranty
status and its duration.

1. To make sure the server is still supported, you can run.

   ```powershell
   Get-HPECOMServer -Region $Region -Name $SN -ShowSupportDetails
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image69.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image69.png){:class="img-800"}{: data-lightbox="gallery"}

    > **⚠️ Note**
    >
    >{: .small-space}
    > 
    > Your assigned lab server may not have a support contract warranty.

2. You can use the following command to verify whether COM has automatically created a support case:

   ```powershell
   Get-HPECOMServer -Region $Region -Name $SN -ShowSupportCases
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image70.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image70.png){:class="img-700"}{: data-lightbox="gallery"}

    Note that if no support cases are found for the specified server, the cmdlet returns no output.

    > **💡 Note**
    >
    >{: .small-space}
    > 
    > `Get-HPECOMServer -Region $Region -ShowServersWithRecentSupportCases` can be used to list servers with recent support cases.

## Step 3 - Collecting and downloading server logs

When encountering a critical server issue, HPE support may request the
collection and submission of your server's Active Health System (AHS)
logs for deeper analysis. Traditionally, gathering these logs can be a
complex and time-consuming task. Fortunately, the provided module
streamlines this process by offering a straightforward method to collect
server logs for any specified server, making troubleshooting more
efficient and accessible.

1. To initiate the collection and download of server logs, enter:

   ```powershell
   Get-HPECOMServerLogs -Region $Region -Name $SN -DownloadAHSLogs -Path .
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image71.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image71.png){:class="img-1000"}{: data-lightbox="gallery"}

    > **💡 Note**
    >
    >{: .small-space}
    > 
    > The `-DownloadAHSLogs` parameter enables you to include Active
    > Health System (AHS) logs along with the regular server logs. AHS logs
    > offer extensive diagnostic information that HPE support often asks for
    > when investigating hardware problems or reviewing support cases. These
    > logs give detailed insights into hardware health and performance.
    > Normally, only standard server logs are gathered, so activate this
    > option if HPE support requests AHS logs specifically for case
    > analysis.
    >
    >{: .small-space}
    >   
    > The `-Path` parameter allows you to specify the destination folder
    > for the downloaded server logs. In the example above, we used a single
    > period "." to indicate the current directory, so the logs will be
    > saved locally. Since no custom filename was provided, the module
    > automatically creates a file named in the format
    > "server-logs-<servername>-<timestamp>.zip", making it easy to
    > identify and organize logs for different servers and collection times.
    > Please note that the log collection process may require 2 to 4 minutes
    > to complete, as it compiles comprehensive diagnostic data from the
    > server.

2. Once the task completes, the zip file can be found using:

   ```powershell
   Get-ChildItem -Path . -Filter *.zip | Select-Object Name, Length, LastWriteTime
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image72.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image72.png){:class="img-500"}{: data-lightbox="gallery"}

3. To see what is inside the archive, extract it with the built-in `Expand-Archive` cmdlet and list the extracted files:

   ```powershell
   Get-ChildItem -Path . -Filter *.zip | Expand-Archive -DestinationPath .\AHS -Force; Get-ChildItem .\AHS
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image72a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image72a.png){:class="img-600"}{: data-lightbox="gallery"}

    Alternatively, you can open the zip file in Windows Explorer:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image73.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image73.png){:class="img-800"}{: data-lightbox="gallery"}

    This makes it easy to inspect individual log files and share relevant data with support teams for further troubleshooting.

## Step 4 - Enabling email notification

An essential aspect of effective server management is receiving timely
alerts when issues arise. To address this, COM provides configurable
email notification policies for each service instance as well as for
individual servers. In this step, you will establish an email
notification policy at the COM instance level, ensuring that whenever a
server is added to COM, the preferred email notification settings are
automatically applied.

1. To subscribe your user account to receive email notifications, including service events, critical or warning severity events, and daily summary updates, execute the following command:

   ```powershell
   Enable-HPECOMEmailNotificationPolicy -Region $Region -DailySummary -ServiceEventAndCriticalAndWarningIssues
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image74.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image74.png){:class="img-1000"}{: data-lightbox="gallery"}

    > **📝 Note**
    >
    >{: .small-space}
    >     
    > A service event refers to a failure that requires the creation of an HPE support case and may necessitate a service repair.

2. To review the current status of the email notification policy, use the following command:

   ```powershell
   Get-HPECOMEmailNotificationPolicy -Region $Region
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image75.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image75.png){:class="img-800"}{: data-lightbox="gallery"}


[↑ Back to Top](#)

# Task 9 - Updating and Ensuring Server Firmware Compliance

<p class="step-meta">(Task 9 of 12) ⏱️ ~10 min</p>

This section outlines the procedures for configuring key server
management functions in COM. It covers maintaining server firmware
compliance to uphold security and performance standards, reviewing group
firmware deviations, and scheduling group firmware updates. Adhering to
these steps will enhance the efficiency of monitoring and maintaining
your server infrastructure.

## Step 1 - Checking group firmware compliance 

The initial step in this process is to verify your group's firmware
compliance status. This compliance report provides a clear assessment of
how closely your servers align with the firmware baseline established
for your group. Not only does it indicate the number of components that
are out of compliance, but it also offers a detailed
breakdown---including the total download size required for all necessary
firmware updates. This comprehensive view is essential for understanding
the scope of updates needed and for planning any remediation actions
efficiently.

1. To check your group's current firmware compliance status, run this command:

   ```powershell
   Get-HPECOMGroup -Region $Region -Name $GroupName -ShowFirmwareCompliance
   ```
    
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image76.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image76.png){:class="img-1000"}{: data-lightbox="gallery"}

    This command returns the following properties for the server:

    - **Server**: Server name

    - **SerialNumber**: Server serial number

    - **Group**: Group name the server belongs to

    - **State**: Compliance state (Compliant, Not Compliant, Unknown, etc.)

    - **Score**: Compliance score percentage (e.g., 25% indicates 25% compliant)

    - **ErrorReason**: Reason for compliance failure if applicable

    - **Criticality**: Severity level of the firmware update (Recommended, Critical, Optional)

    - **Deviations**: Number of firmware components that deviate from the group's baseline

    - **WillItRebootTheServer**: Indicates if applying the update will reboot the server (Yes/No)

    - **GracefullShutdownAttempt**: Indicates if a graceful shutdown will be attempted before reboot (Yes/No)

    - **TotalDownloadSize**: Total size of firmware updates to download (e.g., 65 MB)

    These properties describe the firmware compliance status of each group member. COM calculates the group compliance status by analyzing the group members for adherence to the server firmware settings configured in the group.

    > **🔔 Note**
    >
    >{: .small-space}
    >     
    > You may achieve a perfect 100% compliance score with no deviations depending on the status of your allocated server.

## Step 2 - Checking group firmware deviations

Before updating the server firmware, you can examine any deviations in
firmware components from your group's established baseline. This step
allows you to accurately identify which specific components require
updates to align with the group definition. The components identified
for update correspond to the total firmware size of 65 MB, as indicated
in the TotalDownloadSize column of the firmware compliance report.

1. To view your group's firmware deviations, use:

   ```powershell
   Get-HPECOMServer -Region $Region -Name $SN -ShowGroupFirmwareDeviation
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image77.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image77.png){:class="img-800"}{: data-lightbox="gallery"}

    This command returns the following properties for each firmware component that deviates:

    - **ComponentName**: Name of the firmware component (e.g., System ROM, NIC, Boot Controller)

    - **ExpectedVersion**: Firmware version expected by the group's baseline

    - **InstalledVersion**: Currently installed firmware version on the server

    - **ComponentFilename**: Filename of the firmware update package  
   

    > ⚠️ **Note**
    >
    >{: .small-space}
    > 
    > If there are no deviations, this command will not return any response.  

    > 🔔 **Note** 
    >
    >{: .small-space}
    > 
    > The Firmware Compliance feature does not monitor HPE driver and software versions.

## Step 3 - Scheduling group firmware update

After identifying the firmware deviation within the group definition,
you may choose to perform a group firmware update. For this exercise,
however, you will instead create a scheduled task to initiate the
firmware update for all servers in your group during the upcoming
weekend (in four days).

> 🎯 **Note**
>
>{: .small-space}
> 
> A live group firmware update will not be performed in
> this lab because of time constraints and the potential impact on
> servers used by other sessions. Thank you for your understanding.

1. To create a scheduled firmware update task, you need to use the `Update-HPECOMGroupServerFirmware` cmdlet with the `-ScheduleTime` parameter as shown below:

   ```powershell
   Update-HPECOMGroupServerFirmware -Region $Region -GroupName $GroupName -AllowFirmwareDowngrade -InstallHPEDriversAndSoftware -ScheduleTime (Get-Date).AddDays(4)
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image78.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image78.png){:class="img-900"}{: data-lightbox="gallery"}

    This update, scheduled in four days, allows firmware downgrades and installs HPE drivers and software.

    > **📝 Note**
    >
    >{: .small-space}
    > 
    > To benefit from HPE's drivers and software update
    > functionality, always make sure your servers fulfill the required
    > [prerequisites](https://support.hpe.com/hpesc/public/docDisplay?docId=sd00004003en_us&page=GUID-7D3436DF-F986-4910-AAC6-685CD5639A3F.html#ariaid-title1).

2. To list all scheduled tasks, you can use:

   ```powershell
   Get-HPECOMSchedule -Region $Region
   ```

    There are several other important parameters with the `Update-HPECOMGroupServerFirmware`:

    The `-ServerSerialNumber` parameter allows you to update only a
    specific server within the group instead of updating all servers in the
    group at once. Testing firmware updates on an individual server prior to
    deploying them across the entire group is a recommended best practice.

    By default, `Update-HPECOMGroupServerFirmware` runs updates in parallel
    across eligible servers. The `-SerialUpdates` parameter ensures that
    only one server in the group updates at a time. This prevents all
    servers from being offline simultaneously. When you combine
    `-SerialUpdates` with `-StopOnFailure`, the update process stops
    immediately if any server fails the firmware update, preventing further
    servers from being updated until you investigate the issue.

    The `-PowerOffAfterUpdate` parameter automatically powers off servers
    after a successful firmware update, which can be useful for data center
    maintenance schedules or when you want to perform physical maintenance.

    The `-DisablePrerequisiteCheck` parameter bypasses prerequisite
    validation checks before the update starts. Use this parameter only in
    trusted environments where you have already verified that all
    prerequisites are met, as skipping these checks can lead to failed
    updates.

    The `-SkipComponentUpdatesThatAreBlockedByKnownIssues` parameter
    automatically avoids updating specific firmware components that are
    known to cause problems or issues in your environment.

    The `-Async` parameter returns control to your PowerShell prompt
    immediately without waiting for the firmware update to complete. This is
    useful when you want to schedule multiple operations or continue with
    other tasks while the firmware updates run in the background.


[↑ Back to Top](#)

# Task 10 - Essential Next Steps for Server Management and Sustainability

<p class="step-meta">(Task 10 of 12) ⏱️ ~15 min</p>

After completing setup and firmware updates, the next essential steps
focus on ongoing server management and sustainability. Use HPE Compute
Ops Management PowerShell cmdlets to monitor server performance and
sustainability, generate utilization insights, and review energy
reports. Streamline authentication for accessing iLO interfaces by
implementing Single Sign-On (SSO), and confirm that your COM
configuration of iLO settings is correct through practical verification.

## Step 1 - Server utilization insights

Server utilization insights play a crucial role in optimizing data
center efficiency and sustainability. Leveraging AI-powered analytics,
these insights provide detailed visibility into key performance metrics
such as CPU usage, memory utilization, bus activity, and I/O bus
performance. By continuously monitoring and analyzing server workloads,
administrators can proactively identify bottlenecks, balance resource
allocation, and make informed decisions to maximize both performance and
energy efficiency.

By default, COM automatically enables metrics data collection and
utilization alerts. This feature allows COM to gather essential metrics
for generating sustainability AI insights, creating utilization reports,
and issuing utilization alerts. 

1. To check the current configuration status, you can run:

   ```powershell
   Get-HPECOMMetricsConfiguration -Region $Region
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image79.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image79.png){:class="img-500"}{: data-lightbox="gallery"}

    COM metrics provides information on CPU, memory bus, and I/O bus usage. These insights help organizations monitor and manage the performance of their server infrastructure.

2. To view detailed CPU utilization insights for your server, use the following command:

   ```powershell
   Get-HPECOMServerUtilizationInsights -Region $Region -SerialNumber $SN -CPUUtilization
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image80.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image80.png){:class="img-900"}{: data-lightbox="gallery"}


    > **⚠️ Note**
    >
    >{: .small-space}
    > 
    > Please be advised that server utilization insights are only for HPE ProLiant **Intel** based servers and the utilization insight data might **not** be available at this time.
    >
    > {: .small-space}
    >    
    > ![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image81.png){: .bordered-image-thin}  
    >
    > {: .small-space}
    >
    > Since your server was only recently added to the COM instance, a minimum of one day is required for sufficient data collection. The screenshot is included to illustrate the anticipated output of the cmdlets after several days of data collection.

3. By default, this cmdlet provides CPU utilization data for the past 90 days. If you want to customize the reporting period, add the `-LookbackDays` parameter. For example, to see CPU utilization insights for the last 7 days, enter:

   ```powershell
   Get-HPECOMServerUtilizationInsights -Region $Region -SerialNumber $SN -CPUUtilization -LookbackDays 7
   ```

    The cmdlet also offers several important metrics:

    - MemoryBusUtilization

    - IOBusUtilization

    - CPUInterconnectUtilization

    > These measurements give a broad view of your server's resource usage,
    > allowing you to make smart choices that boost performance and
    > efficiency.

## Step 2 - Server sustainability insights

The Server Sustainability Insights feature is essential for enhancing
data center efficiency and promoting environmentally responsible
operations. In today's landscape, where sustainability is increasingly
prioritized, it's critical to monitor and optimize energy usage across
server infrastructure. Compute Ops Management (COM) offers comprehensive
sustainability insights by providing detailed reports on energy
consumption, carbon dioxide (CO2) emissions, and associated energy
costs.

These three report types---covering energy consumption, CO2 emissions,
and cost savings---empower organizations to assess, track, and manage
the environmental impact of their servers. With these insights, IT teams
can make data-driven decisions to reduce their carbon footprint and
operational expenses.

1. To access in-depth energy consumption data for a specific server, use the following command:

   ```powershell
   Get-HPECOMSustainabilityInsights -Region $Region -SerialNumber $SN -EnergyConsumption
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image82.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image82.png){:class="img-800"}{: data-lightbox="gallery"}

    By default, similar to the server utilization insights, this cmdlet provides the total estimated figures for the previous 90 days. Specifying your server's serial number ensures that the results are focused on the server of interest.

    > **⚠️ Note**
    >
    >{: .small-space}
    > 
    > Please be advised that sustainability insight data will
    > **not** be available at this time. Since your server was
    > only recently added to the COM instance, a minimum of one day is
    > required for sufficient data collection.
    > The screenshots are included to illustrate the anticipated output of
    > the cmdlets after several days of data collection.

2. If you want to view aggregate sustainability metrics for all servers managed by your COM instance, use the following command:

   ```powershell
   Get-HPECOMSustainabilityInsights -Region $Region -EnergyConsumption
   ```

    > This screenshot illustrates the output generated by a COM instance operating with multiple servers:
    >
    >{: .small-space}
    > 
    > ![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image83.png){: .bordered-image-thin}

    The report provides the total estimated energy consumption (in kilowatt-hours, kWh) for all servers in the specified region. The data includes collected values from the past 90 days (3 months), as well as projected consumption for the next 180 days (6 months) helping with planning and decision-making.

3. To retrieve this summary specifically for the region, use:

   ```powershell
   Get-HPECOMSustainabilityInsights -Region $Region -EnergyConsumptionTotal
   ```

   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image84.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image84.png){:class="img-800"}{: data-lightbox="gallery"}

4. Additionally, you can explore other sustainability insights by modifying the parameters:

    - `-EnergyCost`: Displays energy cost data for your servers.

    - `-Co2Emissions`: Provides information about carbon emissions.

5. To extend your historical data analysis, you can look back up to 180 days by using the `-LookBackDays` parameter. For example, to estimate future CO2 emissions based on trends from the past 3 months, run:

   ```powershell
   Get-HPECOMSustainabilityInsights -Region $Region -Co2Emissions -LookBackDays 180
   ```

   This command returns projected CO2 emissions, allowing you to better assess and manage the environmental impact of your server operations.

## Step 3 - Interacting with iLOs using Compute Ops Management SSO

Direct interaction with iLOs from this library is a key capability that
enhances server management efficiency. Starting in January 2025, Compute
Ops Management introduced support for single sign-on (SSO) access to
iLO, significantly streamlining the authentication process. This
advancement enables seamless integration with iLOs, allowing
administrators to perform a range of tasks---from executing native iLO
API RedFish commands to leveraging the HPEiLOCmdlets module for various
iLO operations. The following section outlines how to generate an iLO
access token and demonstrates several ways to interact with an iLO,
making day-to-day management tasks more intuitive and secure.

To authenticate to your server's iLO using single sign-on (SSO), follow these 4 steps for clarity and precision:

1. Generate an iLO SSO Session Object

    Run the following command to obtain a session object for SSO authentication. Replace with your server's serial number and ensure `$Region` is set appropriately.

   ```powershell
   $SSOObject = Get-HPECOMServer -Region $Region -Name $SN | Get-HPECOMServeriLOSSO -GenerateXAuthToken -SkipCertificateValidation
   ```
    
    This command generates an SSO session object, which you'll use to authenticate with HPEiLOCmdlets.

2. To view the details of the session object, enter:

   ```powershell
   $SSOObject
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image85.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image85.png){:class="img-800"}{: data-lightbox="gallery"}

    > **⚠️ Note**
    >
    >{: .small-space}
    > 
    > SSO is currently not supported by servers managed
    > through HPE OneView via HPE Compute Ops Management - OneView
    > Edition (COM-OVE).

3. Install and import the **HPEiLOCmdlets** module, a separate PowerShell module for managing iLO directly:

   ```powershell
   Install-Module HPEiLOCmdlets
   Import-Module HPEiLOCmdlets
   ```

    Type `Y` if prompted to install from an untrusted repository, and press **Enter** to continue. Then press `Y` to accept the license terms.

4. Connect to iLO Using the SSO Token

    Use the following command to establish a connection to your iLO, substituting with the appropriate IP address. The SSO token will be passed from the session object.

   ```powershell
   $connection = Connect-HPEiLO -Address $iLO_IP -XAuthToken $SSOObject."X-Auth-Token" -DisableCertificateAuthentication
   ```

    If the connection is successful, no error message will be returned.

5. To verify the connection, inspect the $connection object:

   ```powershell
   $connection
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image86.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image86.png){:class="img-1000"}{: data-lightbox="gallery"}

6. Perform iLO Operations

    With the established connection, you can now execute various iLO management tasks. For example, to retrieve the iLO event log, use:

   ```powershell
   (Get-HPEiLOEventLog -Connection $connection).Eventlog
   ```

    These steps streamline authenticating to iLO with Compute Ops Management SSO and let you manage your servers more efficiently with PowerShell cmdlets. This method requires no iLO credentials: the iLO permissions granted by your Compute Ops Management role are applied automatically in iLO.

## Step 4 - Testing ILO settings configuration

In this task, you will verify that the iLO settings you configured in
your group (Step6 -- Task 1) have been correctly applied to your server.
Specifically, you will check the AcceptThirdPartyFirmwareUpdates
parameter, then change it and observe how COM detects the configuration
drift and re-applies the correct settings.

1. Verify the current iLO firmware policy setting

    Begin by querying the iLO directly with the HPEiLOCmdlets and your connection object to check the current firmware update policy. Use the following command to retrieve the firmware policy from your iLO:

   ```powershell
   $FirmwareUpdatePolicy = Get-HPEiLOFirmwarePolicy -Connection $connection
   $FirmwareUpdatePolicy.Accept3rdPartyFirmware
   $FirmwareUpdatePolicy
   ```
    
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image87.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image87.png){:class="img-400"}{: data-lightbox="gallery"}

    This command should return **false**, indicating that the AcceptThirdPartyFirmwareUpdates option is set to Disabled as per your group's iLO policy. With this setting, installation of third-party firmware on your server is blocked, aligning with recommended security
best practices.

2. Simulate a configuration drift by changing the setting in COM

    Now you will change the iLO setting in COM from ***Disabled*** to ***Enabled*** to simulate a configuration change. This will cause your server to become non-compliant with the group's iLO policy. Run this command to update the iLO setting:

   ```powershell
   Set-HPECOMSettingiLOSettings -Region $Region -Name $iLOSettingName -Description "iLO Settings for AI Servers" -VirtualMedia Enabled -AccountServicePasswordComplexity Enabled -WebServerSSL Enabled -AcceptThirdPartyFirmwareUpdates Enabled
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image88.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image88.png){:class="img-600"}{: data-lightbox="gallery"}

3. Check the compliance status

    After changing the setting, check the group's compliance status. You should see that the iLO settings are now marked as not compliant because the group policy expects Disabled but the setting now says Enabled:

   ```powershell
   Get-HPECOMGroup -Region $Region -Name $GroupName -ShowCompliance
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image89.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image89.png){:class="img-1000"}{: data-lightbox="gallery"}

    The compliance check will show that your server's iLO configuration no longer matches the group's iLO policy.

4. Re-apply the correct iLO configuration

    Now you will use COM to re-apply the correct iLO configuration to your server. This will change the **AcceptThirdPartyFirmwareUpdates** parameter back to **Enabled** on the iLO itself. Run the following command using the Async parameter so you don't have to wait for the job to complete:

   ```powershell
   $task = Invoke-HPECOMGroupServeriLOConfiguration -Region $Region -GroupName $GroupName -ServerSerialNumber $SN -Async
   ```

5. Check the job status

   ```powershell
   $task
   ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image90.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image90.png){:class="img-800"}{: data-lightbox="gallery"}

    The `$task` variable contains the job object returned by the `-Async` parameter, showing the job is currently in a *Running* state.

6. Monitor the job progress

   While the iLO configuration is being applied, you can check the job status using these commands:

   ```powershell
   Get-HPECOMJob -Region $Region -Category Group -ShowRunning
   ```
   ```powershell
   Get-HPECOMJob -Region $Region -Category Group -JobResourceUri $task.resourceUri
   ```

   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image91.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image91.png){:class="img-800"}{: data-lightbox="gallery"}

   ```powershell
   Get-HPECOMJob -Region $Region -Category Group
   ```
    
   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image92.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image92.png){:class="img-1000"}{: data-lightbox="gallery"}
    
   The job will take approximately 1 to 2 minutes to complete.
    
   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image93.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image93.png){:class="img-800"}{: data-lightbox="gallery"}

7. Verify the setting has been applied

   Once the job is completed, query the iLO again to verify that AcceptThirdPartyFirmwareUpdates has been changed back to Enabled on your iLO:

   ```powershell
   $FirmwareUpdatePolicy = Get-HPEiLOFirmwarePolicy -Connection $connection
   $FirmwareUpdatePolicy.Accept3rdPartyFirmware
   $FirmwareUpdatePolicy
   ```

   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image94.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image94.png){:class="img-400"}{: data-lightbox="gallery"}

   This should now return "**true**" confirming that COM successfully applied the new iLO configuration to your server.

**Key Learnings:**

- Methods for connecting to an iLO via SSO without the requirement of a dedicated iLO account.

- Techniques for directly querying iLO settings using HPEiLOCmdlets to verify current hardware configurations.

- Processes by which COM identifies configuration drift when group policies differ from server configurations.

- Use of Invoke-HPECOMGroupServeriLOConfiguration to re-apply relevant group policies to designated servers.

- Approaches for monitoring COM jobs in order to track the progress of configuration changes.

These points illustrate the effectiveness of COM's policy-based management approach, enabling administrators to specify desired states within group settings and allowing COM to automatically detect and remediate configuration drift across servers.


[↑ Back to Top](#)

# Task 11 - Clean up your workspace

<p class="step-meta">(Task 11 of 12) ⏱️ ~3 min</p>

Before running the zero-touch script in Task 12, release your server and subscription key so the script can reuse them. Run the following commands in order to delete everything you created in your workspace. The lab is reset automatically for the next participant, so no other cleanup is needed.

1. Remove your server from the workspace:

   ```powershell
   Get-HPEGLDevice | Remove-HPEGLDevice -Force
   ```
    
   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image95.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image95.png){:class="img-700"}{: data-lightbox="gallery"}

2. Remove the subscription key:

   ```powershell
   Get-HPEGLSubscription | Remove-HPEGLSubscription
   ```
    
   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image97.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image99.png){:class="img-700"}{: data-lightbox="gallery"}

3. Remove the COM service instance:

   ```powershell
   Get-HPEGLService -ShowProvisioned | Remove-HPEGLService -Force
   ```
    
   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image98.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image98.png){:class="img-600"}{: data-lightbox="gallery"}

4. Delete the workspace:

   ```powershell
   Remove-HPEGLWorkspace -Force
   ```
    
   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image100.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image100.png){:class="img-100pct"}{: data-lightbox="gallery"}

   This permanently deletes the workspace and ends your session in it.

[↑ Back to Top](#)

# Task 12 - Explore Zero Touch Automation with the Sample Script (Optional)

<p class="step-meta">(Task 12 of 12) ⏱️ ~</p>

To see the full value of this library, run the [Zero Touch Automation script](https://github.com/jullienl/HPE-COM-PowerShell-Library/blob/main/Examples/COM-Zero-Touch-Automation.ps1) from GitHub. It automates everything you did manually in this lab, from workspace provisioning and server configuration to policy management and scheduling a firmware update, in a single run. It reports a result message for each step, so you can easily follow its progress.

1. Open Chrome **in the lab virtual machine**. Copy the address below with the **Copy** button, then paste it into the Chrome address bar with **Ctrl**+**V**:

    ```text
    https://github.com/jullienl/HPE-COM-PowerShell-Library/blob/main/Examples/COM-Zero-Touch-Automation.ps1
    ```

    > **⚠️ Note**
    >
    >{: .small-space}
    > 
    > Do not click the script links in this guide. A link opens in the browser of the PC you are reading the guide on, not in the Omnissa virtual machine, so the script would be downloaded to the wrong computer.

2. Click **Download raw file**.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image103.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image103.png){:class="img-800"}{: data-lightbox="gallery"}

3. Chrome saves the script to the **Downloads** folder automatically. Click **Show in folder**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image104.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image104.png){:class="img-500"}{: data-lightbox="gallery"}

4. Right-click the script and select **Open with Code**.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image105.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image105.png){:class="img-800"}{: data-lightbox="gallery"}

5. In the script, update the following 5 variables. Your own details (email, subscription key, iLO IP and iLO password) are in **Station-Info.ps1**. The other two values are given below:

    - For `$MyEmail`, at line **512**, replace the value with the email you used earlier to connect to HPE GreenLake:

        [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image106.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image106.png){:class="img-700"}{: data-lightbox="gallery"}

    - For `$AdditionalUser`, at line **546**, enter:
    
      ```powershell
      com.demoad@gmail.com
      ```

      replacing the existing value:

      [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image107.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image107.png){:class="img-500"}{: data-lightbox="gallery"}

    - For `$OrganizationName`, at line **566**, enter:
    
      ```powershell
      HOL06-HPETechEnablement-Org
      ```
      replacing the existing value:

      [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image107a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image107a.png){:class="img-800"}{: data-lightbox="gallery"}

    - For `$SubscriptionKeys`, at line **587**, delete the second key and add your subscription key from **Station-Info.ps1**. Make sure you remove the comma at the end of the line:

        [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image108.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image108.png){:class="img-500"}{: data-lightbox="gallery"}

    - For `$Servers`, at lines **591**+, replace the values with your server's iLO IP and iLO password from **Station-Info.ps1**, and remove the other  server entries. Make sure you remove the comma at the end of line **578**:

        [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image109.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image109.png){:class="img-500"}{: data-lightbox="gallery"}
   
6. Save the file with **Ctrl**+**S**.

7. Switch back to the PowerShell terminal and navigate to the **Downloads** folder:

   ```powershell
   cd Downloads
   ```

8. Set the execution policy:

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
   ```

9. Run the script, passing your workspace name:

   ```powershell
   .\COM-Zero-Touch-Automation.ps1
   ```

10. Enter your password when prompted.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image112.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image112.png){:class="img-600"}{: data-lightbox="gallery"}

11. When provisioning finishes, check how long it took.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image113.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image113.png){:class="img-600"}{: data-lightbox="gallery"}

12. Press `Y` when prompted with "Do you want to clean up the environment now? (Y/N)". Deprovisioning then removes everything, including the newly created workspace.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image114.png){: .bordered-image-thin style="width:650px; max-width:100%; height:auto"}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image114.png){: data-lightbox="gallery"}

    The environment is now provisioned and cleaned up again, leaving no residual resources.

By combining this script with the HPECOMCmdlets library, tasks that normally require manual work, such as provisioning, configuration, and deprovisioning, run in a fraction of the time. This reduces human error and operational delays, and it lets administrators scale operations, keep configurations consistent, and respond quickly to changing business needs.

With this final step complete, you have successfully concluded the hands-on lab.

[↑ Back to Top](#)

# Summary 

Throughout this lab, you explored how to automate server lifecycle management using the HPE Compute Ops Management PowerShell module. You:

- Installed the HPECOMCmdlets library and authenticated to HPE GreenLake.

- Created a workspace, added a user, provisioned a COM instance, configured a location, and installed a subscription key.

- Onboarded a server to COM using an activation key, assigned location and tags, and verified device status.

- Created configuration policies for BIOS, storage, firmware, and iLO, then applied them through a server group.

- Checked and enforced compliance, monitored jobs, and retrieved detailed inventory, health, alerts, support, and warranty data.

- Used COM SSO to access iLO, detected configuration drift, and automatically re‑applied policy.

- Explored firmware compliance, scheduled updates, utilization insights, and sustainability metrics.

- Cleaned up your workspace by removing the server, the subscription key, the COM service instance, and the workspace itself.

- Finally, executed the COM-Zero-Touch-Automation PowerShell script to automate and streamline the entire configuration workflow---from provisioning and policy application to deprovisioning---enabling consistent, efficient, and error-free server management within the HPE
GreenLake platform.

Completing this lab provides you with a practical, end‑to‑end understanding of automated server management, enabling faster deployments, consistent configuration at scale, reduced manual effort, and improved operational reliability. It equips you with skills to
streamline onboarding, enforce policy‑driven governance, automate compliance, and leverage sustainability and utilization insights for smarter infrastructure decisions.

[↑ Back to Top](#)

# Want more?

**🚀** Looking to automate the onboarding of HPE servers into HPE
GreenLake and Compute Ops Management, see
[Onboarding-Script](https://github.com/jullienl/HPE-Compute-Ops-Management/blob/main/PowerShell/Onboarding/Prepare-and-Connect-iLOs-to-COM-v2.ps1).

**🚀** Looking to demonstrate the power of scripting with HPE GreenLake
and Compute Ops Management, see [HPE Compute Ops Management Zero Touch
Automation
Example](https://github.com/jullienl/HPE-COM-PowerShell-Library/blob/main/Examples/COM-Zero-Touch-Automation.ps1).
This script automates the entire lifecycle from workspace provisioning
through server configuration, policy management, and optional cleanup.
It showcases best practices for programmatic infrastructure deployment
and provides a foundation for building production-ready automation
workflows.

**🔔** Explore a variety of sample scripts designed for the Compute Ops
Management API, including Ansible playbooks, PowerShell, and Python
scripts. These resources offer practical examples to help automate and
streamline server management tasks. Visit the [GitHub
project](https://github.com/jullienl/HPE-Compute-Ops-Management).

**🛠️** Interested in using Ansible with COM? Visit this open source
[GitHub project](https://github.com/jullienl/HPE-COM-baremetal)
dedicated to server provisioning. Originally developed to support ESXi,
RHEL, and Windows Server platforms, the project demonstrates extensive
COM API capabilities---from initial setup (Day 0 operations), through
activation and configuration (Day 1), to ongoing management and
maintenance (Day 2), such as automated firmware updates.

**🖥️** When you're ready to dive deeper, schedule a personalized
session on the [HPE Demonstration
Portal](https://hpedemoportal.ext.hpe.com/).

**✨** You can also request a [90-day
evaluation](https://www.hpe.com/us/en/hpe-compute-ops-management.html?emodal=/us/en/greenlake/fragments/modal-fragment/uc-modal-form.fragment.html)
of Compute Ops Management to experience its full capabilities.


[↑ Back to Top](#)

