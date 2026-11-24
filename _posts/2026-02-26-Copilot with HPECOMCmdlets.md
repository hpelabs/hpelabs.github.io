---
layout: post
title: "Use GitHub Copilot to help with your infrastructure automation with COM"
image: /assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/banner.jpg
post_end_promo: <i><b>Continue your journey with more HPE Compute Technical Enablement Hands-on Labs for infrastructure, security, technologies, and solutions.</b></i>
excerpt: Experience the power of AI and get code written for you by GitHub Copilot, providing just plain English prompts, using a PowerShell library for Compute Ops Management.
tags: 
  - greenlake
  - com 
  - scripting
  - AI
# room: 2 # Set to 1 or 2
collapsible: true
collapsible_expanded: true
---
Hands-On Lab Guide

Experience the power of AI and get code written for you by GitHub
Copilot, providing just plain English prompts, using a PowerShell
library for Compute Ops Management.

# Introduction

Welcome to this Hands-On Lab (HOL). For the next two hours you will
complete a self-paced lab using HPE ProLiant DL-series servers, HPE
GreenLake Compute Ops Management, and GitHub Copilot AI.

## Lab Objectives

In this lab, you will use GitHub Copilot and the HPECOMCmdlets
PowerShell library to build an automation workflow for HPE GreenLake
Compute Ops Management (COM), even if you have limited PowerShell
experience. You will practice writing prompts, reviewing generated code,
and troubleshooting errors while automating workspace setup, server
onboarding, configuration, and firmware scheduling.

## Team Assignments

This lab has 25 stations. Each station will have its own HPE DL-series
server to be onboarded into COM. You will be working in a Virtual
Machine using Visual Studio Code with GitHub Copilot integration.

Your team assignments will be on a separate sheet of paper issued to you
by your lab proctor. Please return the team assignment sheet to your
proctor when finished with this lab.

## Virtual Lab Environment

Upon access to the lab, you will be presented with a Windows desktop.

Each team will have the following physical and virtual infrastructure:

- Windows virtual machine with Visual Studio Code

- One ProLiant DL-series server

[↑ Back to Top](#)

# HPE Compute Ops Management PowerShell Library

The HPE Compute Ops Management PowerShell module provides cmdlets for
managing and automating your HPE GreenLake environment. You can interact
with HPE GreenLake and Compute Ops Management services from the
PowerShell command line and integrate them into automation workflows.

The library continues to evolve as HPE releases new SaaS features.

This module is available in the PowerShell Gallery under the name
[HPECOMCmdlets](https://www.powershellgallery.com/packages/HPECOMCmdlets),
following the naming convention used by most HPE modules.

[![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image3.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image3.png){:class="img-900"}{: data-lightbox="gallery"}

The PowerShell Gallery is a repository for sharing and distributing
PowerShell modules and scripts. It's a community-driven platform that
provides access to various PowerShell resources, enabling you to easily
discover, install, and publish your own PowerShell content. The
PowerShell Gallery can be accessed through the PowerShellGet module
(includes `Install-Module`, `Find-Module`, etc.), which comes
pre-installed with Windows PowerShell 5.0 and above.

This project is also associated with a public GitHub
[repository](https://github.com/jullienl/HPE-COM-PowerShell-Library)
from community contributor [Lionel Jullien](https://github.com/jullienl) from HPE. This repository
is where the source code is developed. You can also track
[releases](https://github.com/jullienl/HPE-COM-PowerShell-Library/releases),
report and view
[issues](https://github.com/jullienl/HPE-COM-PowerShell-Library/issues),
and participate in
[discussions](https://github.com/jullienl/HPE-COM-PowerShell-Library/discussions).

The library covers the HPE GreenLake platform and every Compute Ops Management instance in your workspace:

- **Authentication and sessions**: Connect with SAML 2.0 or OIDC single sign-on (Okta, Microsoft Entra ID, PingIdentity), passwordless or password-based, or with an HPE Account with or without MFA. One session covers every COM region, and sessions can be saved and restored for multi-workspace automation.

- **Workspace, identity and access**: Create and manage workspaces, organizations and tenant workspaces; claim domains and configure SSO connections and authentication policies; invite users and manage user groups, roles, and scope-based access control (SBAC).

- **Services, subscriptions and devices**: Provision Compute Ops Management, manage subscriptions and auto-subscription policies, add devices individually or in bulk from CSV files, set locations and tags, and remove (unclaim) devices.

- **Server onboarding and configuration**: Connect iLOs to COM directly, through a web proxy, or through a Secure Gateway (with automatic discovery). Create BIOS, storage, OS, firmware and iLO settings, and apply them to server groups.

- **Operations, compliance and insights**: Schedule firmware updates and other jobs, require approval for sensitive operations, check firmware, iLO settings and external storage compliance, collect inventory, health, warranty and logs, and review utilization and sustainability insights.

- **Notifications, integration and appliances**: Enable email notifications, deliver platform events to external endpoints with webhooks, integrate with ServiceNow, and manage HPE OneView, OVE and Secure Gateway appliances.

[↑ Back to Top](#)

# Connecting to the Lab

One of the HPE HOL instructors will be happy to assist with getting you
setup for this lab.

1.  Open a Chrome or similar HTML5 capable browser and navigate to:
    <https://labs.compute.cloud.hpe.com/>

2.  Choose **Omnissa Horizon Web Client**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image4.jpg){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image4.jpg){:class="img-300"}{: data-lightbox="gallery"}

3.  Login with your provided credentials from the team assignment sheet.

4.  Click the **GitHub Copilot** icon.

5.  At the warning message "You need to grant microphone and camera
    permission to use RTAV", click **OK**.

6.  At the Fullscreen message: "Click OK to grant permission for full
    screen", you can click **OK** or not, based on your preference and the
    display setup in front of you, and you can click on **Allow** at the
    message "labs.compute.cloud.hpe.com wants to manage windows on all
    your displays".

7.  After a few moments, a Horizon-Published Windows desktop will
    appear.

[↑ Back to Top](#)

# Task 1 - Getting familiar with Visual Studio Code

**Visual Studio Code (VS Code)** is a free, open-source code editor
developed by Microsoft. It is widely used for writing, editing, and
debugging code in many programming languages. VS Code offers features
like syntax highlighting, intelligent code completion, integrated
terminal, version control, and a rich ecosystem of extensions. It is
available for all major operating systems, Windows, MacOS and Linux.

- To start VS Code, double-click the **VS Code** shortcut on the desktop:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image5.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image5.png){:class="img-600"}{: data-lightbox="gallery"}

  VS Code opens your lab folder, **GitHubCopilotLab**, with the file **Station-Info.txt**. This file holds all the values for your station: your HPE GreenLake account, your subscription key, and your server and iLO details. Keep it at hand, you will use it throughout the lab. Your GreenLake password is not in the file, it is on your login sheet.

- Your VS Code window should look like this:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image6.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image6.png){:class="img-900"}{: data-lightbox="gallery"}

- You will spend most of the lab in the **Copilot Chat** pane on the right. Type or paste your prompts in the prompt field at the bottom of this pane:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image7.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image7.png){:class="img-700"}{: data-lightbox="gallery"}

- Copilot answers can be long, so give the chat pane more room. First, drag the left edge of the Copilot pane to make it wider:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image7c.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image7c.png){:class="img-700"}{: data-lightbox="gallery"}

- Now check that VS Code is correctly set up for Copilot. Click the user icon at the bottom of the Activity bar:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image8.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image8.png){: data-lightbox="gallery"}

  A menu should open with at the top **bot-compute-lab<span style="color:red">nn</span>_hpeprod (GitHub)** where **<span style="color:red">nn</span>** is your team number. This is the user with which you are logged
into GitHub, ensuring your rights to Copilot.

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image7a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image7a.png){:class="img-600"}{: data-lightbox="gallery"}

- You should also look just below the area where you will enter Copilot prompts:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image9.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image9.png){:class="img-400"}{: data-lightbox="gallery"}

  This area shows how Copilot is set up for your session:

  - **Copilot Fusion** is the model selection, and **Standard** is its setting. You will keep this default for the whole lab (see below).
  - **Copilot** is the agent that carries out your requests.
  - **Interactive** means Copilot works with you step by step in this chat.
  - **Manual permissions** means Copilot asks for your approval before it runs a command or fetches information. You will see these requests during the lab.

  Copilot relies on an LLM, or Large Language Model, to answer you. An LLM is a
type of artificial intelligence that uses deep learning to understand
and generate human-like text. LLMs are trained on massive amounts of
data and can perform tasks such as answering questions, summarizing
information, translating languages, and generating content.

  **Copilot Fusion** is not a single LLM. For each request, it picks the model best suited to the task, or combines several models, so you get strong results without having to choose a model yourself. In this lab, Copilot will write PowerShell code, and Fusion automatically selects a powerful model for this kind of work, as you will see with your first prompt. **Keep Copilot Fusion selected.**

[↑ Back to Top](#)

# Task 2 - Your first prompt

You are now ready to start coding.

> ⚠️ **Important note**   
>
>{: .small-space}
> 
> ```text
> In the rest of this document text like this represents a prompt that 
 you should type or copy and paste into the Copilot prompt area.
> ```

In AI, a prompt is the input or instruction you give to an artificial
intelligence model---such as a question, command, or statement---to
guide it in generating a specific response. The prompt provides the AI
with context or directions, helping it produce output that matches your
intent, whether that's text, code, images, or other results. 

The quality and clarity of your prompt directly affect how useful and relevant the
AI's response will be. If you feel adventurous, you can change the
prompts slightly, but this lab has been tested with the prompts
provided. Results will be different with other prompts, and could also
be different even with the exact same prompts, that is the nature of AI.

- Here is your first prompt, which you can copy using the `Copy` button:

  ```text
  I want to write PowerShell code that connects to HPE Greenlake and COM using the HPECOMcmdlets library. 
  The code should take a username (email) as a parameter and prompt for a password
  ```

- You can then paste it into the Copilot prompt field then press the **Send** icon:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image9a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image9a.png){:class="img-500"}{: data-lightbox="gallery"}

- Just below your prompt, Copilot tells you which model Copilot Fusion picked for this request. Here it selected **Claude Opus 5.5** because the task has high complexity.

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image9g.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image9g.png){:class="img-500"}{: data-lightbox="gallery"}

  Fusion makes this choice again for every request, so you may see a different model mentioned later in the lab, or a different model than your neighbor for the same prompt. That is expected.

- Because **Manual permissions** is on, Copilot asks before it does anything outside the chat. Here it wants to read the HPECOMCmdlets documentation on GitHub, so it can use the module correctly. When a request like the one below appears, click **Allow Once** (or **Allow**, depending on the request):

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image10a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image10a.png){:class="img-500"}{: data-lightbox="gallery"}

  > 💡 **Note**
  >
  >{: .small-space}
  >
  > Expect several of these requests for this prompt, one after the other, and more throughout the lab, for example to read a web page, read a file, or run a PowerShell command. Read each request, then allow it so Copilot can continue. 

- If you are not sure what a request does, click **Explain** in the request: Copilot describes in plain English what the agent is trying to do and why. Copilot waits until you answer, so if it seems stuck, check the chat for a pending request.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image10b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image10b.png){:class="img-500"}{: data-lightbox="gallery"}

  > 💡 **Note**
  >
  >{: .small-space}
  >
  > You can reduce or avoid these requests by clicking **Manual permissions** below the prompt field and choosing another level. **Assisted permissions** lets a model approve the actions it judges safe and asks you about the rest. **Allow all** approves Copilot's actions without asking at all. In this lab, keep **Manual permissions** on purpose: reviewing each request shows you exactly what the agent is doing, step by step. Outside of a lab, choose the level that matches how much you trust the task and the environment.
  >
  >{: .small-space}
  >
  > [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image10c.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image10c.png){:class="img-500"}{: data-lightbox="gallery"}

- After a few seconds, Copilot will respond in plain English, summarizing what it did. Your response may look slightly different, that's expected with AI. 

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image9b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image9b.png){:class="img-500"}{: data-lightbox="gallery"}

- Note that the code itself is in a file that Copilot created. Click on the file it created in the Explorer window,
as depicted below:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image10.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image10.png){:class="img-500"}{: data-lightbox="gallery"}

- The ![](/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image11.png) icon next to the file name means the file
has pending changes from Copilot.

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image12.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image12.png){:class="img-100pct"}{: data-lightbox="gallery"}

- The code Copilot generated has a green background, which means it is a proposed change that you have not accepted yet. To accept it, click **Keep**:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image13.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image13.png){:class="img-100"}{: data-lightbox="gallery"}

  The counter next to **Keep** and **Undo** shows how many changes Copilot proposed. Here it reads **1 of 1**, because there is a single change. Later in the lab, Copilot will often propose several changes at once and the counter will read **1 of n**. You can then use the arrows to move from one change to the next, or accept them all in one go with the **Keep** button in the files changed bar above the chat prompt.

- The green background disappears, and so does the icon next to the file name in the tab. If you are ever unhappy with a change proposed by Copilot, click **Undo** instead of **Keep** to discard it, then write another prompt.

You can see that with this simple first prompt, Copilot wrote fairly
comprehensive code with comments (text in green), error handling
(try/catch blocks), parameter binding, etc. 

 > ⚠️ **Note**
 >
 >{: .small-space}
 >
 > Do not run the script yet. The goal of this lab is to build it incrementally from Task 2 through Task 5, then review and polish it in Task 6, before finally executing it in Task 7.

If this code looks like gibberish to you, that's OK, your Copilot assistant is here to handle the
technical details!

- Get used to watching the bottom right of the prompt area, this will give
you a clue whether Copilot is still thinking or if it's ready to accept
the next prompt. When it's thinking it will show this icon:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image15.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image15.png){:class="img-500"}{: data-lightbox="gallery"}

- When it's ready for your next prompt, it will show this icon instead,
that you can click to submit your prompt (pressing **Enter** has the same
effect):

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image16.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image16.png){:class="img-500"}{: data-lightbox="gallery"}

- Before moving on, instruct Copilot to make the script **idempotent**, meaning it can be safely re-run without side effects. This is essential: if the script fails midway and you need to restart it, steps that already succeeded will be skipped rather than repeated.

  ```text
  I want my script to be fully idempotent so it can be safely run multiple times.
  From now on, apply this idempotency principle to every piece of code you generate:
  always check whether a resource already exists before creating it, and skip creation if it does.
  ```
  
  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image16a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image16a.png){:class="img-500"}{: data-lightbox="gallery"}

[↑ Back to Top](#)

<!-- # Task 3 - Copilot can make mistakes

While Copilot is a great help, it is not perfect right from the start.
You still need to be in control and check your assistant's work. In this
particular case, the names of the cmdlets that Copilot generated are not
correct, they do not match what the HPECOMcmdlets library provides. This
is because the LLM does not know this library (yet), so it
"hallucinates" some of its responses. This is very common in AI, a
hallucination occurs when an AI model generates information that is
inaccurate, misleading, or entirely fabricated, even though it may sound
plausible. These outputs are not based on real data or facts but are the
result of the model making incorrect predictions or \"guesses\". But do
not fear, you can easily fix that by providing Copilot with some context.
This is the equivalent of sending your junior coder to training, except
it's vastly faster than with human beings.

- To fix this, point Copilot to the official HPECOMCmdlets source repository so it can learn the correct cmdlet names and syntax:

  ```text
  The cmdlet names you used are incorrect. From now on, always refer to the official HPECOMCmdlets
  source code and examples at https://github.com/jullienl/HPE-COM-PowerShell-Library before generating any code.
  ```

- When you instruct Copilot to fetch information from the Internet, it may ask for your permission. If you see a prompt like the one below, click the down arrow next to **Allow Once**:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image14.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image14.png){:class="img-600"}{: data-lightbox="gallery"}

- Then click the response highlighted in red in the screenshot to give Copilot the widest permission.

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image14a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image14a.png){:class="img-900"}{: data-lightbox="gallery"}

  This will take slightly longer as Copilot fetches information from the
repository. You should see it changes the cmdlet to connect to Greenlake
to the proper one `Connect-HPEGL`. Click **Keep** to accept the changes.

[↑ Back to Top](#)
 -->
# Task 3 - Create a workspace

In HPE GreenLake, a workspace is an environment where users can organize
and manage resources, such as servers, storage, and services, for
specific projects or teams. Workspaces help separate and control access
to different sets of resources, making it easier to manage permissions,
monitor usage, and automate tasks within a defined scope.

- Copy the following prompt as is, without changing anything. Copilot reads your workspace name from **Station-Info.txt** in your lab folder:

  ```text
  Create or reuse the workspace whose name is given as "Workspace name" in the file Station-Info.txt of this folder. 
  Use that exact name as a constant in the script, do not read the file at run time.
  Create it as a member workspace of the organization I am connected to, using the -InOrganization switch. 
  If the workspace already exists, do not create a new one. 
  In both cases, connect to the workspace afterwards.
  Use the following parameters:
  - Email: the email address used to connect
  - Street: make up an address
  - City: make up a city
  - Country: United States
  ```

  > **🔔 Note**   
  >
  >{: .small-space}
  >
  > The "create or reuse" logic means re-running the script won't create duplicate workspaces: it will simply reconnect to the existing one.
  >
  >{: .small-space}
  >
  > The `-InOrganization` switch creates the workspace as a member of the lab's organization, **HOL09-HPETechEnablement-Org**. Without it, an orphan workspace is created outside the organization and you will run into issues later in this lab. Check that the generated `New-HPEGLWorkspace` command includes it.

  Check that the workspace name in the generated script matches the one in **Station-Info.txt** (<code>COM-Copilot-Lab-<span style="color:red">xx</span></code> with <span style="color:red">xx</span> your team number).

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image16b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image16b.png){:class="img-800"}{: data-lightbox="gallery"}




- Review the diff highlighted in the editor: <span style="background-color:red">red</span> = removed code, <span style="background-color:green">green</span> = added code. Click **Keep** to accept.

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image17.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image17.png){:class="img-900"}{: data-lightbox="gallery"}

  > **🔔 Note**   
  >
  >{: .small-space}
  >
  > Always accept pending changes before sending your next prompt: click **Keep** next to each change, or click **Keep** in the files changed bar above the chat prompt to accept all of them at once. If you don't, changes from your earlier prompt stay pending and pile up with the new ones, making it harder to see what each prompt changed.




## Give the lab administrator access to your workspace

- Give the lab administrator account access to your workspace, so the lab team can recover your resources if something goes wrong:

  ```text
  Add the user com.demoad@gmail.com to the workspace with the Workspace
  Administrator role. Skip this step if the user is already a member.
  ```


## Provision Compute Ops Management in the workspace

- Make Compute Ops Management available in your workspace. This is called
provisioning a service in GreenLake. Services can be provisioned in
multiple regions, so you need to specify the region you want:

  ```text
  Provision service Compute Ops Management in region eu-central
  ```

- Then give your signed-in user the Administrator role for the COM service:

  ```text
  Add Compute Ops Management Administrator role to the signed-in user in the workspace.
  ```

## Create a location

Locations are part of the Service Delivery Information (SDI) that is
available to automate support workflows. Locations capture addresses,
contacts, and service delivery information for operations, management,
and commerce. Assigning a device to a location is the process of
attaching a device to a physical location to automate support and
services for this device.

- Use the following prompt to create your location:

  ```text
  Create a location with name Mydatacenter and these parameters:
  Country, Street, City and PostalCode the same as the workspace.
  State "none" and for the primary contact Email, use the user's email.
  ```

Because the script is designed to be idempotent, Copilot should add a pre-check to verify the location does not already exist before attempting to create it.


## Add a subscription

- To activate compute devices that will be added later to your workspace,
you need to install a COM subscription key (a license to use COM). Copy the
prompt as is, Copilot reads your key from **Station-Info.txt**:

  ```text
  Add the subscription key given as "Subscription key" in the file Station-Info.txt of this folder. 
  Use that exact key as a constant in the script, do not read the file at run time.
  ```

  ```text
  Set automatic subscription assignment and reassignment for Compute. 
  The COM subscription tier is enhanced.
  ```

[↑ Back to Top](#)

# Task 4 - Onboarding devices

You are now ready to add a server to your COM workspace. You will use a
method that works just as well for dozens or even hundreds of servers,
even though in this lab you will only add one. Start by preparing a file
with the details of the servers you want to add.

- In VS Code menu click **File** ➜ **New File**:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image18.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image18.png){:class="img-300"}{: data-lightbox="gallery"}

- Type the file name **iLOs.csv** and **Enter**:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image19.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image19.png){:class="img-600"}{: data-lightbox="gallery"}

  A standard Windows dialog will appear to choose the location where you
want to save the file. It should be in folder **HOL09-T<span style="color:red">nn</span>** \> **GitHubCopilot Lab**. 

- Click **Create File**.

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image20.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image20.png){:class="img-800"}{: data-lightbox="gallery"}

- Decline VS Code's suggestion to install an extension to handle CSV files
(at the bottom right of the screen). You don't need it for this simple file:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image21.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image21.png){:class="img-500"}{: data-lightbox="gallery"}

- Open **Station-Info.txt**, copy the two lines under **Content of iLOs.csv**, and paste them into the **iLOs.csv** file:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image21a1.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image21a1.png){:class="img-500"}{: data-lightbox="gallery"}

  Make sure the data is on 2 lines like shown below: 

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image21a2.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image21a2.png){:class="img-800"}{: data-lightbox="gallery"}

- Save the file with **Ctrl**-**S** or **File** ➜ **Save** in VS Code's menu.

  > If you had more servers to onboard, you would simply add more lines to
this file, and your script would process each line.

- Go back to your PowerShell script tab in VS Code and tell Copilot to import the csv file:

  ```text
  Import file iLOs.csv. Double check the field names in the csv file. Do not use module HPEiLOCmdlets.
  ```

  You should see it generated code to import the file into a variable using `Import-Csv`. It may have put the code in the middle of the script, before creating the workspace, but that's OK.

- To connect a server to COM, its iLO needs an activation key, which COM generates for you. The key contains the information the iLO needs to connect to the right place, such as your workspace ID. Ask Copilot to generate one:

  ```text
  Generate a COM activation key.
  ```

- You now have everything you need to bring your server into COM:

  ```text
  Connect all the iLOs from the CSV file to COM. Make sure the activation key is created before this step.
  ```

  Copilot's code may use a `foreach` loop to process each iLO (for example using a variable like `$iLOList` or `$iLOs`). Check that the generated code processes every device in the CSV file, creates credentials from each row's username and password, and uses `Connect-HPEGLDeviceComputeiLOtoCOM` to connect each iLO with the activation key. The exact code structure and variable names may differ.


## Set device location and tags

Next, assign your server to the location you created previously. This is needed to ensure that support cases are automatically created in the event of device failures.

- Enter:

  ```text
  Assign the location we created previously to the device.
  ```

  *Tags* in HPE GreenLake are metadata labels---key-value pairs---that
you can attach to cloud resources. Their main purpose is to help you
categorize, organize, and manage resources based on criteria like
purpose, owner, environment, cost center, or other custom attributes.

  ```text
  Add tag "Country=US, App=AI" to the device.
  ```

  > ⚠️ **Important note**   
  >
  >{: .small-space}
  > Time Check 
  >
  > Now would be a good time to look at the clock and determine how much
  > time you have left before the end of the lab. If you have less than
  > \~20 minutes, consider skipping to [Task 6 - Review the
  > script](#task-6---review-the-script). You have generated enough PowerShell
  > code already to be able to run it and get meaningful results. If you
  > still have time, you can continue generating more code, but be sure
  > to keep an eye on the clock and allow enough time to run the script
  > and see the results of your (and Copilot's) work.


[↑ Back to Top](#)

# Task 5 - Configuration of Compute Ops Management

Now that your server is onboarded, you will use some of the
features that COM provides for server management.

## Create server settings

Server settings are predefined or custom configuration templates that
define how servers should be configured. They allow administrators to
apply consistent configurations---such as firmware baselines, BIOS
settings, workload profiles, or other system parameters---to one or more
servers at scale.

- First create BIOS settings:

  ```text
  Create a BIOS setting with name Custom-Bios-For-AI, Workload Profile "Virtualization -- Max Performance", 
  Automatic Server Recovery on with a timeout of 10 minutes.
  ```

- Next, create settings for internal storage:

  ```text
  Create an internal storage setting with name RAID-1, RAID level 1, take the entire disk.
  ```

- Create firmware settings:

  ``` text
  Create firmware settings with the latest firmware bundles for Gen10 and Gen11.
  ```

## Create a server group

A server group containing the settings you just created keeps the
configuration consistent across all servers added to that group.

- To create a server group, enter:

  ```text
  Create a server group named AI_Group with the 3 settings we created previously. 
  Make sure the settings are not applied automatically when a server is added to the group.
  ```

## Add servers to the group

- Now add your server to the group:

  ```text
  Add the server to the group.
  ```

## Set iLO auto firmware update

- To automate the iLO firmware update, run:

  ```text
  Set our server to automatically update iLO firmware to the newest available.
  ```

## Update server firmware

The firmware update step is crucial to ensure that servers are up to
date. Administrators typically need to perform this task regularly to
maintain optimal performance and security. 

- In this step, you will create
a scheduled task to run a firmware update during the next weekend for
all servers in your group. Do NOT try to run a firmware update
immediately, keep the schedule to next Sunday:

  ```text
  Schedule a server firmware update through the group for next Sunday at 5am.
  ```

This concludes the code writing exercise. You are now ready to test the
script you created by running it.

[↑ Back to Top](#)

# Task 6 - Review the script

Before running the script, it is worth taking a moment to have Copilot review and validate what it has generated. AI models are often better at catching their own mistakes when given a second pass. This step can save you significant debugging time during execution.

- Ask Copilot to verify all cmdlet names and options against the official library:

  ```text
  Double check the code to make sure the cmdlet names and options you used from HPECOMcmdlets are all correct. 
  Use everything you find at https://github.com/jullienl/HPE-COM-PowerShell-Library as a reference.
  ```

- You may get multiple prompts for permission to run specific commands as Copilot progresses through its understanding of the HPECOMCmdlets PowerShell module. Click **Allow each time**, or click the arrow to give a wider permission

  > At some point, Copilot may even present you the following prompt. Click **Continue**, the process can take time but it should complete eventually and do a thorough job of reviewing and correcting the code it generated.
  >
  >{: .small-space}
  >
  > [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image14b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image14b.png){:class="img-300"}{: data-lightbox="gallery"}

  You will likely see multiple edits throughout the file. Unlike humans, an AI agent can be quite good at fixing its own errors if you give it appropriate data.

- A scripting best practice is to halt execution as soon as a failure is detected, rather than letting the script continue in an error state. Ask Copilot to add this behavior:

  ```text
  Can you modify my script so that after each step, if the returned status is "Failed", 
  the script stops execution immediately? 
  Statuses "Warning" and "Complete" should be treated as success and allow execution to continue.
  ```

  This way, as the script runs and you encounter errors, you can ask Copilot to fix them and re-run the script, one issue at a time.

- As a final check before running, ask Copilot to do a quick review of the entire script:

  ```text
  Quickly assess the script and fix any issues.
  ```

- Copilot may offer additional improvements at the end of its response: feel free to accept or skip them. The key point is that these last three prompts have already brought the script to a state where it is ready to run. 

[↑ Back to Top](#)

# Task 7 - Execute the script

With all the code now generated and reviewed, it is time to put it to the test. In this section, you will run the script you built with Copilot's assistance and observe it automating the full workflow, from workspace creation and device onboarding to server configuration and firmware scheduling, all without writing a single line of code manually.

- To run the script, return to its tab in VS Code and select **Run** > **Run Without Debugging**:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image22.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image22.png){:class="img-900"}{: data-lightbox="gallery"}

  > 💡 **Note**  
  >
  >{: .small-space}
  >   
  > If the **Run** menu is greyed out, save your script first (`Ctrl`+ `S`), then close and reopen VS Code.
  >
  >{: .small-space}
  >
  >   [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image22c.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image22c.png){:class="img-700"}{: data-lightbox="gallery"}

- Select the **PowerShell Extension** terminal tab, not the **pwsh** tab used by Copilot. For a better view of the script output, expand the terminal panel using the ❷ icon:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image22e.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image22e.png){:class="img-900"}{: data-lightbox="gallery"}

- Watch the terminal for a username prompt. Enter the HPE GreenLake account shown in **Station-Info.txt**.

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image22b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image22b.png){:class="img-800"}{: data-lightbox="gallery"}

  > 💡 **Note**  
  >
  >{: .small-space}
  >   
  > If no username prompt appears, check the script's parameters and how it requests credentials. Depending on the code Copilot generated, you may need to supply the username as a parameter when running the script.

- Then enter the password, the rest of the script will run, displaying what it is doing.   

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image22d.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image22d.png){:class="img-800"}{: data-lightbox="gallery"}

- Check the terminal output for errors.

    > 💡 **Note**  
    >
    >{: .small-space}
    >   
    > If you encounter an error, copy the full error message into the Copilot pane and ask Copilot to help fix it. Copilot may need additional context to diagnose the issue.


- If Copilot suggests a fix, review and accept the changes, then run the script again from the beginning.
 
  > **💡 Note**   
  >
  >{: .small-space}
  > 
  > Just a year ago, the code generated for this lab often needed manual fixes and adjustments. Today, Claude Opus 5.5 usually produces very good results, sometimes without requiring any fixes. Results can still vary, so review the generated code and its output.

You can also follow the script's progress in the COM graphical user interface (GUI): 

- Open the Chrome browser from the VM's desktop and click the **HPE GreenLake** bookmark in the **HOL** folder of the bookmarks bar. It opens the portal at `https://common.cloud.hpe.com`:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image23a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image23a.png){:class="img-100pct"}{: data-lightbox="gallery"}

- Enter the same HPE GreenLake account used in the script. On the **Choose sign-in method** page, select **Sign in with SSO**:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image23b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image23b.png){:class="img-700"}{: data-lightbox="gallery"}

- Then enter your password on the Microsoft sign-in page:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image23c.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image23c.png){:class="img-500"}{: data-lightbox="gallery"}

- In the list of workspaces, select **Launch** next to the workspace created by the script (<code>COM-Copilot-Lab-<span style="color:red">xx</span></code> with <span style="color:red">xx</span> your team number):

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image23.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image23.png){:class="img-800"}{: data-lightbox="gallery"}

  > **💡 Note**   
  >
  >{: .small-space}
  > 
  > If you do not see a workspace with a name following the template used in
this lab, it would indicate that the workspace creation did not work. In
this case you should inspect the terminal window in VS Code and look for
any errors.

- Once you are in the lab's workspace, launch the COM service:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image24.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image24.png){:class="img-900"}{: data-lightbox="gallery"}


  > **💡 Note**   
  >
  >{: .small-space}
  > 
  > If the COM service is not visible yet, the script may still be provisioning it. Check the VS Code terminal for progress or errors.

- In COM, go to **Servers** and check that your server appears in the list:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image27.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image27.png){:class="img-900"}{: data-lightbox="gallery"}

- Even if the script finishes without errors, the server may take several minutes to show a state of `Connected` in COM. You can also monitor its connection status in iLO:

  1. On the VM desktop, open the Chrome shortcut named **Team-xx iLO**, where **xx** is your team number.

      [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image27a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image27a.png){:class="img-700"}{: data-lightbox="gallery"}

  2. Sign in as **Administrator** using the iLO password from **Station-Info.txt**.

      [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image27b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image27b.png){:class="img-600"}{: data-lightbox="gallery"}

  3. In the left-hand menu, select **HPE Compute Ops Management**:

      [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image28.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image28.png){:class="img-900"}{: data-lightbox="gallery"}

  4. Check the connection status. The page may show intermediate steps before the status changes to `Connected`:

      [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image29.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image29.png){:class="img-900"}{: data-lightbox="gallery"}

- In COM, explore the groups created by the script, then go to **Manage** > **Settings**. Look for the three settings you defined:

  - `BIOS/Workload profile` — type `API defined`
  - `Server internal storage` — type `User defined`
  - `Server firmware` — type `User defined`

  Unlike the built-in settings marked `HPE pre-defined`, these were created by your script. The BIOS/workload profile is marked `API defined` because BIOS settings must currently be created through the API, rather than the GUI.

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image30.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image30.png){:class="img-900"}{: data-lightbox="gallery"}

- Go to **Manage** > **Groups** and check that the new group contains one device and has three settings applied:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image30a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image30a.png){:class="img-900"}{: data-lightbox="gallery"}

- Open the group and verify that a firmware update is scheduled for next Sunday at 5:00 a.m.:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image30b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image30b.png){:class="img-900"}{: data-lightbox="gallery"}

- If the script completed without errors, you may or may not see a success message at the end of the terminal output, depending on what Copilot generated:

  [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image31.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Copilot-With-HPECOMCmdlets/image31.png){:class="img-600"}{: data-lightbox="gallery"}



[↑ Back to Top](#)

# Summary

Congratulations on completing this hands-on lab!

You used GitHub Copilot and the **HPECOMCmdlets** PowerShell library to build an automation workflow that creates a workspace, configures services, and onboards and manages an HPE ProLiant server through HPE GreenLake Compute Ops Management.

Along the way, you practiced guiding Copilot with prompts, reviewing its generated code, and troubleshooting errors. You can apply the same approach to other server management tasks.

[↑ Back to Top](#)

# Want more?

**🧪** Explore the [HPE Compute Ops Management Zero-Touch Automation hands-on lab]({{ site.baseurl }}/PowerShell-COM-Zero-Touch/) for a step-by-step server lifecycle workflow using HPECOMCmdlets.

**📖** Read the [PowerShell Library for HPE Compute Ops Management article](https://jullienl.github.io/PowerShell-library-for-HPE-GreenLake) for installation, authentication, session management, onboarding examples, best practices, and troubleshooting. For the most complete and up-to-date library reference, consult the [HPECOMCmdlets README](https://github.com/jullienl/HPE-COM-PowerShell-Library/blob/main/README.md).

**🚀** Explore the [Zero-Touch Automation example](https://github.com/jullienl/HPE-COM-PowerShell-Library/blob/main/Examples/COM-Zero-Touch-Automation.ps1), which demonstrates workspace provisioning, server onboarding and configuration, firmware updates, and optional cleanup.

**🚀** To prepare and onboard multiple servers from a CSV file, see [Prepare-and-Connect-iLOs-to-COM-v2.ps1](https://github.com/jullienl/HPE-Compute-Ops-Management/blob/main/PowerShell/Onboarding/Prepare-and-Connect-iLOs-to-COM-v2.ps1). To discover and onboard servers through a Secure Gateway, see [Discover-and-Onboard-iLOs-via-SecureGateway.ps1](https://github.com/jullienl/HPE-Compute-Ops-Management/blob/main/PowerShell/Onboarding/Discover-and-Onboard-iLOs-via-SecureGateway.ps1).

**🔔** Find more Ansible, PowerShell, and Python examples in the [HPE Compute Ops Management GitHub project](https://github.com/jullienl/HPE-Compute-Ops-Management), and explore Ansible-based server provisioning in [HPE-COM-baremetal](https://github.com/jullienl/HPE-COM-baremetal).

**🖥️** Schedule a personalized session on the [HPE Demonstration Portal](https://hpedemoportal.ext.hpe.com/) or request a [90-day evaluation](https://www.hpe.com/us/en/hpe-compute-ops-management.html?emodal=/us/en/greenlake/fragments/modal-fragment/uc-modal-form.fragment.html) of Compute Ops Management.

[↑ Back to Top](#)