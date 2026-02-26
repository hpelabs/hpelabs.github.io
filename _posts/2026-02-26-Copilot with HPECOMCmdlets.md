---
layout: post
title: "Use GitHub Copilot to help with your infrastructure automation with COM"
image: /assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/banner.jpg
post_end_promo: <i><b>Continue your journey with more HPE Compute Technical Enablement Hands-on Labs for infrastructure, security, technologies, and solutions.</b></i>
excerpt: Experience the power of AI and get code written for you by GitHub Copilot, providing just plain English prompts, using a PowerShell library for Compute Ops Management.
---

Living Lab experience


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
[repository](https://github.com/hpelabs/HPE-COM-PowerShell-Library)
from our HPE Labs team. This repository
is where the source code is developed. You can also track
[releases](https://github.com/hpelabs/HPE-COM-PowerShell-Library/releases),
report and view
[issues](https://github.com/hpelabs/HPE-COM-PowerShell-Library/issues),
and participate in
[discussions](https://github.com/hpelabs/HPE-COM-PowerShell-Library/discussions).

[![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image2.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image2.png){: data-lightbox="gallery"}

This library provides a variety of key features for managing HPE
GreenLake and Compute Ops Management. Here are the main features:

- **Authentication**: Establish secure connections to HPE GreenLake using Single Sign-On (SSO) or single/multi-factor authentication. Whether you have an existing workspace or not, the library supports flexible
authentication methods to suit your needs.

- **Workspace Management**: Create and manage HPE GreenLake workspaces.

- **Session Tracking**: Automatically track sessions with the global session tracker $HPEGreenLakeSession.

- **User Management**: Invite and manage users within your HPE GreenLake environment, assign roles.

- **Resource Management**: Manage resources such as servers, storage, and networking within your HPE GreenLake environment.

- **Service Provisioning**: Provision services like Compute Ops Management, manage service roles and subscriptions.

- **Device Management**: Add devices individually or in bulk using CSV files, manage device subscriptions and auto-subscriptions, set device locations and connect devices to services.

- **Server configuration Management**: Create and apply BIOS, storage, OS, and firmware settings. Manager group and apply configurations to groups of servers.

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

## Preparation for using the PowerShell library

To use the HPE Compute Ops Management PowerShell Library, an HPE
GreenLake account is required. The library supports two authentication
methods:

**HPE Account credentials---single-factor authentication (with or ithout MFA).**

- Requires an HPE Account (username and password)

- Direct authentication using HPE Account credentials

**Single Sign-On (SSO) passwordless authentication**

- Requires a properly configured Identity provider (IdP) such as Okta, PingIdentity, or Microsoft Entra ID.

- User authentication is handled through an external Identity Provider using SAML 2.0.

- For more details, see [SAML Single Sign-On (SSO) with passwordless authentication](https://github.com/hpelabs/HPE-COM-PowerShell-Library?tab=readme-ov-file#saml-single-sign-on-sso-with-passwordless-authentication).

If you have an HPE GreenLake account or a workspace with properly
configured SSO for passwordless access, **skip this section.**

> ⚠️ **Important note**   
>
>{: .small-space}
> 
> If your user account uses an identity provider---whether supported (Okta, Microsoft Entra ID, PingIdentity) or unsupported---that does not use passwordless authentication methods (push notifications or TOTP), authentication with the `Connect-HPEGL` cmdlet will fail.

> 💡 **Note**   
>
>{: .small-space}
> 
> Multi-factor authentication (MFA) was implemented with the release of version [1.0.12](https://github.com/hpelabs/HPE-COM-PowerShell-Library/releases/tag/v1.0.12) of the HPECOMCmdlets PowerShell Library. SAML Single Sign-On (SSO) support for the three main providers was introduced beginning with version [1.0.18](https://github.com/hpelabs/HPE-COM-PowerShell-Library/releases/tag/v1.0.18).

1. To create your HPE account for this library, go the HPE GreenLake interface at <https://common.cloud.hpe.com> and click on **Sign up**:

   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image4.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image4.png){:class="img-600"}{: data-lightbox="gallery"}
   
2. Provide all the required information, accept the terms and conditions
and click on **Create Account**:

   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image5.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image5.png){:class="img-600"}{: data-lightbox="gallery"}

3. Once completed, you are ready to access the lab, then to install and use the library.

## Connecting to the lab environment

To access the HPE Compute BU Enablement Environment, we will use VMware Horizon. Follow these steps:

1. Using your Chrome browser, navigate to the appropriate URL based on your network location to open the Horizon Access Portal:

   - **External to HPE** (not connected to HPE VPN): <https://labs.compute.cloud.hpe.com>

   - **Internal to HPE** (or connected to HPE VPN): <https://techenablement.hpecorp.net>

2. On the Horizon login screen, click the **Omnissa Horizon Web Client** button.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image6.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image6.png){:class="img-600"}{: data-lightbox="gallery"}

3. Login with the credentials provided in your login sheet.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image7.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image7.png){:class="img-500"}{: data-lightbox="gallery"}

4. Click on the graphic that represents your Lab environment.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image8.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image8.png){:class="img-600"}{: data-lightbox="gallery"}

    Since Horizon is presenting a remote desktop session inside of your desktop's browser, it may be helpful to hit **F11** at this time to put the browser in full screen mode.

## Preparation of your environment 

1. You'll start by opening **Visual Studio Code** using the shortcut in the VM's desktop:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image9.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image9.png){:class="img-600"}{: data-lightbox="gallery"}

2. Once opened, click on **Mark Done**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image10.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image10.png){:class="img-600"}{: data-lightbox="gallery"}

3. Start by opening a new file:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image11.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image11.png){:class="img-600"}{: data-lightbox="gallery"}

    This new file will be useful to copy/paste all important information you find useful to keep an eye on.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image12.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image12.png){: data-lightbox="gallery"}

4. Then open a PowerShell terminal using the **Terminal** menu / **New Terminal**: 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image13.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image13.png){: data-lightbox="gallery"}

    All the commands outlined in this lab guide should be executed in this window.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image14.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image14.png){: data-lightbox="gallery"}

4. I recommend you: **1️⃣** expand the window, **2️⃣** close the Copilot agent, and **3️⃣** increase the terminal size to improve your experience:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image13a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image13a.png){: data-lightbox="gallery"}

    **💡 Tip: Using the Copy Button**  
    
    Throughout this lab, you'll see a **Copy** button in the midle-right corner of each code block. Click this button to instantly copy the command(s) to your clipboard, then use **CTRL**+**V** to paste them directly into the PowerShell terminal. This helps avoid typing errors and speeds up your workflow.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image14a.png)]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image14a.png){: data-lightbox="gallery"}

5. While the PowerShell console is opened, you can optionally launch a browser to access the HPE GreenLake website and view the results of the commands you will be executing. If your browser is not already open and connected to HPE GreenLake, open a browser and navigate to <https://common.cloud.hpe.com>.

6. Login with your HPE account credentials:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image15.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image15.png){:class="img-300"}{: data-lightbox="gallery"}

    If this is your first time using HPE GreenLake, it is expected that no workspace will be available in your environment. If you already have one or more workspaces, there is no issue; you can still proceed with this lab.

7. You can now leave the page and begin your zero-touch automation experience.

# Step 1 - How to Install HPECOMCmdlets
(Step 1 of 12) ⏱️ ~5 min

- The first step is to install the library on your Windows virtual machine. Return to the PowerShell console and enter the following command:

    ```powershell
    Install-Module HPECOMCmdlets
    ```

    [![A black screen with white text Description automatically generated]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image16.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image16.png){: data-lightbox="gallery"}

    This command will download and install the module from the official PowerShell Gallery repository. If this is your first time installing a module from the PowerShell Gallery, it will ask you to confirm whether you trust the repository or not. 
    
- Type `Y` when prompted and press **Enter** to continue with the installation.

    This library has no dependencies, so it does not require the installation of any other software or modules to function properly.


[⬆ Back to Top](#)

# Step 2 - Get the exported commands
(Step 2 of 12) ⏱️ ~3 min

- Now that the module is installed, you can get the list of commands exported by the module using:

    ```powershell
    Get-Command -Module HPECOMCmdlets
    ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image17.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image17.png){: data-lightbox="gallery"}

    Version **1.0.22** of the module includes over 200 cmdlets.

- In PowerShell, cmdlets use a verb-noun naming convention (e.g., `Get-HPECOMServer` retrieves server data in HPE Compute Ops
Management). Cmdlets start with **HPECOM** for Compute Ops Management or **HPEGL** for HPE GreenLake (e.g., `New-HPEGLUser`). The library supports both platforms due to their close integration.

- To list all cmdlets in the module related to server resources, use the following command:

    ```powershell
    Get-Command -Module HPECOMCmdlets | ? name -match server
    ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image18.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image18.png){: data-lightbox="gallery"}

    This command is especially helpful when you're dealing with many cmdlets and need to pinpoint the one that fits your needs best.

    >💡**Note**   
    >
    >{: .small-space}
    > 
    > `?` is an alias for `Where-Object` in PowerShell, and `-match` is the operator used to determine if a string matches a regular expression, such as `server` in this example.

- `Get-Help` cmdlet is another essential PowerShell command for locating information about new modules. To utilize this command,  enter:

    ```powershell
    Get-Help Get-HPECOMserver -Full
    ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image19.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image19.png){: data-lightbox="gallery"}

    `Get-Help` (or the alias `Help`) is a PowerShell cmdlet that allows you to retrieve information on other PowerShell cmdlets and functions. 
    
    By running `Get-Help` in the PowerShell console, you can view detailed information about the specified cmdlet, including its syntax, parameters, examples, and related links. Additionally, you can use specific switches such as `-Detailed`, `-Examples`, or `-Full` to customize the output.

- Each cmdlet exported from this module provides detailed examples of how to use the command. To view the examples for the   `Get-HPECOMServer` cmdlet, enter:

    ```powershell
    Help Get-HPECOMServer -Examples
    ```

    This will display a list of examples demonstrating how to use `Get-HPECOMServer` along with detailed explanations of what each
example does.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image20.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image20.png){:class="img-700"}{: data-lightbox="gallery"}


[⬆ Back to Top](#)

# Step 3 - Connection to HPE GreenLake
(Step 3 of 12) ⏱️ ~15 min

After the module is installed, the next first step is to connect to HPE GreenLake using the `Connect-HPEGL` command.

At this point, there are two authentication methods available:

- **Single or Multi-Factor Authentication** (MFA): Authenticate using your email and password, with optional MFA for added security.

- **SAML Single Sign-On (SSO):** SSO is exclusively supported with Okta, Entra ID, and PingID, providing efficient authentication aligned with your organization's SSO configuration. Please note that specific prerequisites must be met for this method, including the requirement for passwordless authentication methods such as push notifications or TOTP. For detailed guidance on configuring SSO and enabling   passwordless authentication, refer to [Configuring-SAML-SSO-with-HPE-GreenLake-and-Passwordless-Authentication-for-HPECOMCmdlets](https://hpelabs.github.io/Configuring-SAML-SSO-with-HPE-GreenLake-and-Passwordless-Authentication-for-HPECOMCmdlets/)

Select the below option according to your user authentication method:

- **Using Single or Multi-Factor Authentication**:

  1. Begin by creating a credential object to securely store your HPE account credentials (email and password):

     ```powershell
     $MyEmail = "your_email@your_domain.com"
     $credentials = Get-Credential -UserName $MyEmail
     ```

  2. Once executed, the command prompts you for the password.
  
  3. Then use the credential object with the `Connect-HPEGL` command:

     ```powershell
     Connect-HPEGL -Credential $credentials
     ```

     [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image21.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image21.png){: data-lightbox="gallery"}

      - When MFA is enabled with Okta:

        The cmdlet will prompt you to validate the push notification from Okta.

        [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image22.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image22.png){: data-lightbox="gallery"}

        On your Okta-enabled device, press **Yes, it's me** to approve the authentication request.

         [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image23.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image23.png){:class="img-300"}{: data-lightbox="gallery"}


      - When MFA is enabled with Google Authenticator:

        The cmdlet will pause and prompt you to enter the MFA token.

        [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image24.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image24.png){: data-lightbox="gallery"}

        Open the Google Authenticator app on your device to retrieve the token and enter it when prompted.

- **Using SAML Single Sign-On (SSO) with Okta, PingID or Entra ID**:

  - Start by creating an email object:

    ```powershell
    $MyEmail = "your_email@your_domain.com"
    ```

  - To connect with SAML SSO through your organization's identity provider (IdP), enter the following command in your terminal:

    ```powershell
    Connect-HPEGL -SSOEmail $MyEmail
    ```

  Once initiated, the cmdlet will prompt you to approve a push notification sent by your IdP. Follow the on-screen authentication steps displayed in your terminal. Typically, you'll need to:

  - Check your IdP-enabled device for a push notification or authentication request.
  
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image25.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image25.png){: data-lightbox="gallery"}

  - Approve the request (for example, tap the number or "Yes, it's me" in Okta or confirm in PingID/Entra ID).
  
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image26.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image26.png){:class="img-300"}{: data-lightbox="gallery"}

  - Complete any additional steps required by your organization's security policies.

Once authentication is successful, a secure connection to HPE GreenLake will be established, allowing you to proceed with subsequent operations.
The `Connect-HPEGL` cmdlet is responsible for initiating and managing this connection. Upon establishment, it maintains a persistent session using the `$HPEGreenLakeSession` connection tracker variable, which supports all further module cmdlet activities. Furthermore, the cmdlet issues a temporary API client credential for both HPE GreenLake and any Compute Ops Management service instances provisioned within your workspace.

> **💡 Note** 
>
>{: .small-space}
> 
> You can use `Get-Help Connect-HPEGL -Full` to access the complete help documentation, technical details, and in-depth explanations for `Connect-HPEGL`.

If you have no workspace tied to your HPE account, the `Connect-HPEGL` command will return a warning message indicating that you need to create your first workspace:

[![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image27.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image27.png){: data-lightbox="gallery"}

If you already have one or more workspaces available, the command will return a warning message indicating that you need to use a second command to connect to one of the workspaces:

[![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image28.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image28.png){: data-lightbox="gallery"}

> **💡 Note**   
>
>{: .small-space}
> 
> The command to directly connect to an existing and known workspace is:
>
>  `Connect-HPEGL -Credential $credentials -Workspace "My_workspace_name"`


[⬆ Back to Top](#)

# Step 4 - Configuration of your workspace
(Step 4 of 12) ⏱️ ~20 min

## Task 1 -- Create your first workspace

1. To create your initial workspace (or an extra one just for this lab --- don't worry, it will be deleted once the lab ends), you need to provide a unique name. Since the name must be unique across all workspaces on the HPE GreenLake platform, we will use a random number to generate the name. Enter:

    ```powershell
    $WorkspaceName = "HPEWorkspaceTxx_$(Get-Random)"
    ```

    **⚠️ Replace `xx` with your team number** (e.g., `01` for team 1, `05` for team 5, `12` for team 12).
    
    For example, **team 5** should use: `$WorkspaceName = "HPEWorkspaceT05_$(Get-Random)"`

    > ### ⚠️ CRITICAL REQUIREMENT ⚠️
    > {: .no_toc }
    >
    > You **MUST** follow the naming convention **HPEWorkspaceTxx_** (with xx your team number) exactly. This is essential for the lab reset scripts to identify and clean up your workspace automatically.
    > <br>   
    > **⚠️ Failure to use this naming format will prevent automatic cleanup and may require manual intervention.**

2. This command generates a name such as *HPEWorkspaceT01_12345678* for team 1. You can verify your workspace name by executing:

    ```powershell
    $WorkspaceName
    ```

3. Build the command step by step using PowerShell's tab completion feature:

    a. Start typing the command with the workspace name:
   
    ```powershell
    New-HPEGLWorkspace -Name $WorkspaceName -Type 
    ```
   
   b. After typing `-Type`, press **SPACE** then press the **Tab** key repeatedly to cycle through available workspace types. Select **'Standard enterprise workspace'**.
   
   c. Continue by adding the country parameter:
   
    ```powershell
    -Country 
    ```
      
    Press **SPACE** then press the **Tab** key to see the list of supported countries, then select your country.
   
   d. Complete the command by adding the street address:
   
    ```powershell
    -Street "Your street address"
    ```
   
   e. Your complete command should look like this:
   
    ```powershell
    New-HPEGLWorkspace -Name $WorkspaceName -Type 'Standard enterprise workspace' -Country Canada -Street "123 Main Street"
    ```

    > **💡 Tip**   
    >
    >{: .small-space}
    > 
    > Press **SPACE** after a parameter name, then press **Tab** to activate PowerShell's auto-completion for parameter values. This shows you valid options and helps avoid typos.

    >  **📌 Note**   
    >
    >{: .small-space}
    > 
    > In the example above, only the `name`, `type`, `country`, and `street` parameters are included because they are required. However, you can also specify optional parameters like `city`, `state`, `email`, and others.

3. After executing this command, the workspace is created, and the command automatically disconnects the session. To connect to your new workspace, enter:

    ```powershell
    Connect-HPEGL -Credential $credentials -Workspace $WorkspaceName
    ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image30.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image30.png){: data-lightbox="gallery"}


4. To check the content of your workspace, enter:

    ```powershell
    Get-HPEGLWorkspace
    ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image31.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image31.png){: data-lightbox="gallery"}


## Task 2 -- Add a user to your workspace

There are several commands that are available to configure a workspace and the different resources available in a workspace, such as adding users, settings roles, location, etc. In this task, you will simply add
a new user with a specific role.

1. Invite **admin@hpelabs.us** as an administrator to your newly created workspace:

    ```powershell
    $NewUserEmail = "admin@hpelabs.us"
    New-HPEGLUser -Email $NewUserEmail -RoleName 'Workspace Administrator'
    ```

    > ### ⚠️ CRITICAL REQUIREMENT ⚠️
    > {: .no_toc }
    >
    > You **MUST** add this admin user (**admin@hpelabs.us**) to your workspace. This is essential for the lab reset scripts to function properly at the end of your session.
    > <br>  
    > **⚠️ Failure to add this user will prevent cleanup and break the lab for the next participant.**


2. To verify the new user, execute the following command:

    ```powershell
    Get-HPEGLUser
    ```

## Task 3 -- Provision Compute Ops Management

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

4. Next, assign the 'Administrator' role for Compute Ops Management to both you and the invited user:

    ```powershell
    $MyEmail, $NewUserEmail | Add-HPEGLRoleToUser -RoleName 'Compute Ops Management administrator'
    ```

    > **💡 Note**   
    >
    >{: .small-space}
    > 
    > The **Tab** key can be used to display the available list of role names.

5. Finally, verify the role assignments with:

    ```powershell
    Get-HPEGLUserRole -Email $MyEmail
    Get-HPEGLUserRole -Email $NewUserEmail
    ```

## Task 4 -- Set a location

Locations in Service Delivery Information (SDI) store addresses, contacts, and support details for automation. Assigning a device to a location links it physically for automated support, including ticket creation with HPE.

This step is essential for automatically creating a ticket with HPE support.

1. To create a location, enter:

    ```powershell
    $LocationName = "Your_customized_location_name"
    New-HPEGLLocation -Name $LocationName -Description "Your customized description" -Country "Your country" -Street "Your customized street address" -City $LocationName -State "NA" -PostalCode "123456789" -PrimaryContactEmail $MyEmail
    ```

    > **💡 Note**   
    >
    >{: .small-space}
    > 
    > You can press the **Tab** key after typing `-Country` to view all supported countries.


2. Check the location with:

    ```powershell
    Get-HPEGLLocation
    ```


# Summary 

Throughout this lab, you explored how to automate server lifecycle management using the HPE Compute Ops Management PowerShell module. You:

- Installed the HPECOMCmdlets library and authenticated to HPE GreenLake.

- Created a workspace, add a user, provision a COM instance, configure a location, and install a subscription key.

- Onboarded a server to COM using an activation key, assigned location and tags, and verified device status.

- Created configuration policies for BIOS, storage, firmware, and iLO, then applied them through a server group.

- Checked and enforced compliance, monitored jobs, and retrieved detailed inventory, health, alerts, support, and warranty data.

- Used COM SSO to access iLO, detected configuration drift, and automatically re‑applied policy.

- Explored firmware compliance, scheduled updates, utilization insights, and sustainability metrics.

- Finished by cleaning the lab: remove device assignments, delete subscriptions, delete the COM instance, and disconnected.

- Finally, executed the COM-Zero-Touch-Automation PowerShell script to automate and streamline the entire configuration workflow---from provisioning and policy application to deprovisioning---enabling consistent, efficient, and error-free server management within the HPE
GreenLake platform.

Completing this lab provides you with a practical, end‑to‑end understanding of automated server management, enabling faster deployments, consistent configuration at scale, reduced manual effort, and improved operational reliability. It equips you with skills to
streamline onboarding, enforce policy‑driven governance, automate compliance, and leverage sustainability and utilization insights for smarter infrastructure decisions.

[⬆ Back to Top](#)

# Want more?

**🚀** Looking to automate the onboarding of HPE servers into HPE
GreenLake and Compute Ops Management, see
[Onboarding-Script](https://github.com/hpelabs/HPE-Compute-Ops-Management/blob/main/PowerShell/Onboarding/Prepare-and-Connect-iLOs-to-COM-v2.ps1).

**🚀** Looking to demonstrate the power of scripting with HPE GreenLake
and Compute Ops Management, see [HPE Compute Ops Management Zero Touch
Automation
Example](https://github.com/hpelabs/HPE-COM-PowerShell-Library/blob/main/Examples/COM-Zero-Touch-Automation.ps1).
This script automates the entire lifecycle from workspace provisioning
through server configuration, policy management, and optional cleanup.
It showcases best practices for programmatic infrastructure deployment
and provides a foundation for building production-ready automation
workflows.

**🔔** Explore a variety of sample scripts designed for the Compute Ops
Management API, including Ansible playbooks, PowerShell, and Python
scripts. These resources offer practical examples to help automate and
streamline server management tasks. Visit the [GitHub
project](https://github.com/hpelabs/HPE-Compute-Ops-Management).

**🛠️** Interested in using Ansible with COM? Visit this open source
[GitHub project](https://github.com/hpelabs/HPE-COM-baremetal)
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


[⬆ Back to Top](#)

