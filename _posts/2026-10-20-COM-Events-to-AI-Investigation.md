---
layout: post
title: "From HPE COM Events to AI-Assisted Incident Investigation and Remediation"
image: /assets/images/HOLs/COM-Events/banner.jpg 
post_end_promo: <i><b>Continue your journey with more HPE Compute Technical Enablement Hands-on Labs for infrastructure, security, technologies, and solutions.</b></i>
excerpt: Build an event-driven operations pipeline that connects HPE Compute Ops Management webhooks to reliable notifications and simulated ITSM tickets. Then add AI-assisted incident investigation using simulated iLO Redfish evidence and HPE Customer Advisories.
last_modified_at: 2026-10-20
tags: 
  - greenlake
  - com 
  - webhooks
  - AI
  - docker
room: 2 # Set to 1 or 2
exclude: true
---

Hands-on Lab Guide

# Introduction

This lab takes you through a Compute Ops Management (COM) event from webhook registration to delivery. You will first observe a real server power event, then use simulated events to explore AI analysis, Redfish evidence, and HPE Customer Advisory context.


[↑ Back to Top](#)

# Lab Objectives

By the end of the lab, you will be able to create COM webhooks and use the open-source [HPE COM Event Integrations](https://github.com/jullienl/HPE-COM-Event-Integrations) project, in its Relay + Shim deployment, to follow an event as it is authenticated, queued, normalized, de-duplicated, correlated, and delivered to Mattermost and GitHub. You will then enrich a simulated incident with iLO evidence, an AI analysis, and HPE Customer Advisories, and compare the result with a baseline without enrichment.

Throughout this lab, you’ll learn:
- How HPE COM webhooks, event filters, handshake verification, and shared-secret authentication work
- How to create a RAISE webhook and a CLEAR webhook in COM with the COM API
- How the Relay, the queue, and the Shim work together, and why a durable queue protects events when a target is slow or down
- How to deliver the same event to several targets by changing the `TARGETS` setting
- How de-duplication avoids repeated messages and tickets, and how raise/clear correlation closes the ticket when the server recovers
- How to enable enrichers with the `ENRICHERS` setting without changing the Relay, the queue, or the targets
- How the Shim reads read-only evidence from an iLO through Redfish, and how an AI agent turns it into a report
- How to separate observed evidence, probable causes, and unverified hypotheses, and how to use the confidence level of the report
- How HPE Customer Advisories add context to an incident
- How to position this open-source solution with your customers and partners

[↑ Back to Top](#)

# About HPE COM Event Integrations

This lab is built on [HPE COM Event Integrations](https://github.com/jullienl/HPE-COM-Event-Integrations), an open-source project that routes HPE Compute Ops Management (COM) webhook events to ITSM, SIEM, monitoring, and ChatOps targets, with durable delivery, optional AI enrichment, and no inbound port into your network.

[↑ Back to Top](#)

## Why this project exists

COM can send events to an HTTPS endpoint through webhooks. In theory a target that accepts webhooks could receive them directly. In practice an enterprise integration needs more than a forwarded payload:

| Need | What the project provides |
|---|---|
| Compatibility | The COM verification handshake and shared-secret authentication, which most targets do not support. |
| Payload transformation | Every COM event becomes a neutral `CanonicalEvent`, and one adapter per target maps it to the API that target expects. |
| Reliability | A durable queue, retry, and safe handling of target outages. |
| Event lifecycle | A stable `correlation_key` that ties a problem to its recovery, so the ticket opened by the raise can be closed by the clear. |
| Fan-out | One COM event delivered to several targets, each with its own de-duplication. |
| Security | An option where the public endpoint lives in the cloud and your network stays outbound-only. |

[↑ Back to Top](#)

## The components used in this lab

| Component | Role in the lab |
|---|---|
| **Relay** ([com-event-relay](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-relay)) | The public HTTPS endpoint in Azure. It answers the COM handshake, checks the shared secret, and puts each event on the queue. |
| **Queue** (Azure Service Bus) | The durable buffer between the Relay and the Shim. |
| **Shim** (`com-event-shim` image) | Runs on your VM. It pulls events from the queue, then normalizes, de-duplicates, enriches, and delivers them. |
| **Core** ([com-event-core](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-core)) | The shared package inside the Shim: normalization, de-duplication, raise/clear correlation, all target adapters, and the enrichers. |
| **AI Gateway** ([ai-gateway](https://github.com/jullienl/ai-gateway), separate project) | The analyzer that Task 3 calls to turn iLO evidence into a report. |

The project offers two deployment models. This lab uses **Relay + Shim**, where the public endpoint is hosted in Azure or AWS and your network stays outbound-only. The other model, **Bridge**, is a single container that you host yourself. 

[![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-18b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-18b.png){: data-lightbox="gallery"}{:class="img-1000"}

See [Choose a deployment model](#choose-a-deployment-model) at the end of this guide to compare them.

[↑ Back to Top](#)

## How the lab maps to the project

| Part of the lab | What you use from the project |
|---|---|
| Task 1 | The COM webhook contract: verification handshake, shared-secret header, and the raise filter. |
| Task 2 | The Relay, the queue, the Shim, the Mattermost and GitHub adapters, de-duplication, and raise/clear correlation. |
| Task 3 | The `ilo_ai` and `hpe_advisories` enrichers, and the AI Gateway. |

> **Note**: This project is not an officially supported HPE product. As with the HPECOMCmdlets and HPE OneView PowerShell libraries, anyone, including customers, can [open an issue on GitHub](https://github.com/jullienl/HPE-COM-Event-Integrations/issues), and it will be investigated and addressed, usually within a few days.

[↑ Back to Top](#)

# Lab information

This lab has 25 stations, one per team. Each station has its own HPE GreenLake workspace and its own HPE DL-series server, already onboarded into Compute Ops Management. You work in a virtual machine that provides all the software the lab needs.

Your lab proctor will give you a login sheet with your team assignment: your station number and the login details for your station. Keep it with you during the lab, and return it to your proctor when you finish.

## Virtual Lab Environment

Upon access to the lab, you will be presented with a Windows desktop.

Each team will have the following physical and virtual infrastructure:

- A Windows virtual machine with all the software used in this lab

- An HPE GreenLake workspace with a Compute Ops Management instance, already provisioned  

- An HPE ProLiant DL-series server, already onboarded into that instance


[↑ Back to Top](#)

## Connecting to the lab environment

To access the Windows virtual machine in our VMware Omnissa Horizon lab environment complete these steps:

1. Navigate to <https://labs.compute.cloud.hpe.com>

2. On the Horizon login screen, click the **Omnissa Horizon Web Client** button.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0a.png){: data-lightbox="gallery"}{:class="img-600"}

3. Login with the Horizon login username and password provided in your login sheet.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0b.png){: data-lightbox="gallery"}{:class="img-400"}

4. Click on the graphic that represents your Lab environment.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0c.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0c.png){: data-lightbox="gallery"}{:class="img-700"}

    Since Horizon is presenting a remote desktop session inside of your desktop's browser, it may be helpful to hit **F11** at this time to put the browser in full screen mode.

[↑ Back to Top](#)


## Preparation of your environment 

1. Start by opening **Station Info** from the shortcut on the VM's desktop:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0d.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0d.png){: data-lightbox="gallery"}{:class="img-800"}

2. This file holds all the credentials and details you need during the lab, so keep it open and within reach:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0e.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0e.png){: data-lightbox="gallery"}{:class="img-700"}

> **💡 Tip: Using the Copy Button**  
>
>{: .small-space}
>
> Throughout this lab, each code block displays a **Copy** button in the middle-right corner. Click it to copy the commands to your clipboard, then press **Ctrl**+**V** to paste them into the PowerShell terminal. This eliminates typing errors and speeds up your workflow.
>
> Always paste with the keyboard (**Ctrl**+**V**, or **Ctrl**+**Shift**+**V**), not with a right-click. The Horizon web client only sends your clipboard to the VM when you paste from the keyboard, and in the terminal a right-click copies instead of pasting when some text is selected.
>
> [![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image14a.png)]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image14a.png){: data-lightbox="gallery"}{:class="img-600"}

  
[↑ Back to Top](#)

# Task 1 - Webhook creation

<p class="step-meta">(Task 1 of 3) ⏱️ ~20 min</p>

In this first task you will create a webhook in COM that sends an event every time your server is powered off. These are real events from your own server.

## What are webhooks?

At their core, webhooks are automated messages sent from apps when something happens. They’re a way for apps to communicate and pass information along instantly, setting off a chain reaction of tasks without the need for manual intervention.

With COM, webhooks offer a seamless avenue for triggering events across your systems. When a specific event occurs, be it an outage, a new alert raised or a new server connection, webhooks spring into action, notifying your other tools and services, and potentially initiating predefined operations tasks.

This proactive approach ensures that teams are promptly alerted, allowing for swift action and minimizing potential downtime or disruptions.

[↑ Back to Top](#)

## Available resources in Compute Ops Management

The concept of available resources in the context of webhooks refers to the different types of events or actions within an application or service that a webhook can be configured to listen for. With COM, you can set up webhooks to monitor a large range of event resources such as servers, alerts, groups, server settings, jobs, compliance checks, and firmware bundles.

For each resource, certain specific properties are capable of initiating the dispatch of a webhook. These triggers are detailed in the table below:


| Resource Type | API Documentation | Monitorable Properties |
|---|---|---|
| `compute-ops/server` | [Get v1 server by ID](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/public/openapi/compute-ops-mgmt-latest/operation/get_v1_server_by_id/) | `hardware`, `state`, `firmwareInventory`, `softwareInventory`, `lastFirmwareUpdate`, `tags`, `autoIloFwUpdate` |
| `compute-ops/alert` | [Get v1 server alerts](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/public/openapi/compute-ops-mgmt-latest/operation/get_v1_server_alerts/) | N/A - no specific properties can be monitored. Will only send `Created` and `Deleted` events |
| `compute-ops/group` | [Get v1beta2 group by ID](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/public/openapi/compute-ops-mgmt-latest/operation/get_v1beta2_group_by_id/) | `name`, `autoFwUpdateOnAdd`, `groupComplianceStatus`, `serverSettingsUris`, `devices`, `serverPolicies`, `autoAddServerTags` |
| `compute-ops/server-setting` | [Get v1beta1 server settings by ID](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/public/openapi/compute-ops-mgmt-latest/operation/get_v1beta1_server_settings_by_id/) | `name`, `settings` |
| `compute-ops/job` | [Get v1beta3 job by ID](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/public/openapi/compute-ops-mgmt-latest/operation/get_v1beta3_job_by_id/) | `state` |
| `compute-ops/group/compliance` | [Get v1beta2 compliance by compliance ID](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/public/openapi/compute-ops-mgmt-latest/operation/get_v1beta2_compliance_by_compliance_id/#!c=200&path=id&t=response) | `complianceStatus` |
| `compute-ops/firmware-bundle` | [Get v1beta2 firmware bundle by id](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/public/openapi/compute-ops-mgmt-latest/operation/get_v1beta2_firmware_bundle_by_id/) | `advisories`, `isActive` |


  > The process of creating webhooks in Compute Ops Management and the various resource types that are available are documented in the [API documentation](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/webhooks/overview/). 



A webhook definition needs two things:

- **A resource type**: the kind of COM resource to watch. A power change is a change to a server, so the resource type is `compute-ops/server`.
- **A filter**: the condition an event must meet before COM sends it. Here, the power state of the server must change.

[↑ Back to Top](#)

## Filter syntax

A filter is a condition written in OData syntax, as described in the [HPE GreenLake specification](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/public/guide/#filtering). The general form is `property op value`, where:

- `property` is the field to filter on.
- `op` is the operator: `eq` (equal), `ne` (not equal), `gt` (greater than), `ge` (greater or equal), `lt` (less than), `le` (less or equal).
- `value` is the value to compare against.

For example, `type eq 'compute-ops/job'` matches events whose `type` is `compute-ops/job`.

A few rules apply to every filter:

- Write text values in single quotes, such as `'compute-ops/job'`. Write the Boolean values `True` and `False` without quotes.
- Combine conditions with `and`, `or` and `not`, for example `type eq 'compute-ops/alert' and operation eq 'Created'`.
- Use `/` to reach a nested property, for example `hardware/powerState`.

[↑ Back to Top](#)

## Filter attributes

The property in a filter is one of these attributes:

- **`type`** matches the resource type.
- **`operation`** matches `Created`, `Deleted` or `Updated`.
- **`new`, `old` and `changed`** look at the state of the resource after the event, before the event, and whether a property changed.

The table below describes each attribute with an example:



| Property | Description | Example Values | Example *eventFilter* | Result |
|---|---|---|---|---|
| `type` | Allows matching on [resource types](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/webhooks/resources/#resource-types) | `compute-ops/job`, `compute-ops/server` | `type eq 'compute-ops/job'` | Match all events related to jobs |
| `operation` | Allows matching on different operations | `Created`, `Deleted`, `Updated` | `type eq 'compute-ops/alert' and operation eq 'Created'` | Match all events related to created alerts |
| `changed` | Allows matching on [monitorable properties](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/webhooks/resources/#resource-types) if the value has changed | `changed/name`, `changed/state` | `type eq 'compute-ops/group' and changed/name eq True` | Match any events related to groups whose `name` property changed |
| `new` | Allows matching on [monitorable properties](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/webhooks/resources/#resource-types) of the current state of the resource | `new/complianceStatus`, `new/isActive` | `type eq 'compute-ops/group' and new/groupComplianceStatus ne 'Compliant'` | Match any events related to groups whose `groupComplianceStatus` is not currently `Compliant` |
| `old` | Allows matching on [monitorable properties](https://developer.greenlake.hpe.com/docs/greenlake/services/compute-ops-mgmt/webhooks/resources/#resource-types) of the previous state of the resource | `old/devices`, `old/settings` | `type eq 'compute-ops/group' and old/name eq 'Group Name'` | Match any events related to a group whose previous `name` was "Group Name" until the group's name is changed again |
| `name` | Alias for `new/name` | | `type eq 'compute-ops/group' and name ne 'New Group'` | Match any events related to groups whose current `name` is not "New Group" |

[↑ Back to Top](#)

## How `new`, `old` and `changed` work

When an event modifies data, COM can compare two snapshots of the resource: the `new` state (the data after the change, for example the power is `OFF`) and the `old` state (the data before it, for example the power was `ON`). The `changed` attribute is `True` when a monitorable property has a different value in the two snapshots. Combining them lets you fire a webhook only for the transition you care about.

The filter only decides whether COM sends the event. The event itself carries the current state of the server, not just the property that changed.

[↑ Back to Top](#)

## The filter for this task

The filter starts by selecting the `compute-ops/server` resource type with `type`. It then uses `old` to check that the server was on before the event, and `changed` to make sure the power state actually changed.

```txt
type eq 'compute-ops/server' and old/hardware/powerState eq 'ON' and changed/hardware/powerState eq True
```

This matches any server event whose power state changed from `ON` to something else, which is a power off.

> **Note**: Write the Boolean value `True` without quotes. It is a logical value, not text. `old` is the state before the event, so `old/...powerState eq 'ON'` means the server was on.

[↑ Back to Top](#)


## Connecting to the HPE GreenLake Cloud Platform

HPE GreenLake is the cloud platform that hosts COM. Each station has its own workspace, and your server is already onboarded into the COM instance of that workspace. In this part you sign in to HPE GreenLake and check your workspace. Later you will power your server off and on to generate the events that your webhook reacts to.

1. From your Horizon desktop, open Google Chrome:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-1a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-1a.png){: data-lightbox="gallery"}{:class="img-600"}
    
2. Click the **HPE GreenLake** bookmark in the **HOL** folder of the bookmarks bar. It opens the portal at `https://common.cloud.hpe.com`. 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-1b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-1b.png){: data-lightbox="gallery"}{:class="img-800"}
    
3. Sign in with the GreenLake username listed in **Station Info**:
    
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0f.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-0f.png){: data-lightbox="gallery"}{:class="img-800"}

4. On the **Choose sign-in method** page, select **Sign in with SSO**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-2.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-2.png){: data-lightbox="gallery"}{:class="img-300"}

5. On the Microsoft sign-in page, if asked, re-enter the GreenLake username then the password from your login sheet:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-3.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-3.png){: data-lightbox="gallery"}{:class="img-300"}

6. You are now on the HPE GreenLake home page. Your workspace name appears
    to the right of the HPE GreenLake logo. Do not launch COM
    yet:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-4.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-4.png){: data-lightbox="gallery"}{:class="img-900"}

    > **Note**: If your workspace name is not visible and the global navigation menu (≡) is missing to the left of the HPE GreenLake logo, right-click the GreenLake tab, select **New tab to the right**, and click the **HPE GreenLake** bookmark again. You stay signed in, and the (≡) menu and workspace name appear.
    >
    >{: .small-space}
    >
    >    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-4a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-4a.png){: data-lightbox="gallery"}{:class="img-500"}


[↑ Back to Top](#)

## Create a Personal API client

Today, webhooks in COM can only be configured through the COM API. The COM GUI does not provide any option for it yet.

Before you can call the COM API, you must authenticate. API calls carry an access token, and you obtain tokens with a **personal API client**: a client ID and a client secret that belong to your user. A token has the same permissions as the user who created the client, and it is valid for a limited time (120 minutes for COM). You create the personal API client once, and you can generate new tokens from it whenever you need.

1. On the HPE GreenLake Quick links pane, click **Manage workspace**.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-5.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-5.png){: data-lightbox="gallery"}{:class="img-900"}

2. Select **API access** > **Create personal API client**.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-6.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-6.png){: data-lightbox="gallery"}{:class="img-600"}

3. Enter a name for the API client, for example `COM-HOL`.

4. For **Service**, select **GreenLake Cloud Platform**.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-7.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-7.png){: data-lightbox="gallery"}{:class="img-500"}

5. Click **Create personal API client**. HPE GreenLake shows that your credentials were created.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-8.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-8.png){: data-lightbox="gallery"}{:class="img-500"}

6. Click **Copy** next to **Client ID** and next to **Client Secret**, and paste both into a new text file in Notepad that you keep open during the lab.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-9.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-9.png){: data-lightbox="gallery"}{:class="img-500"}

    > **Important**: HPE GreenLake does not store the client secret. This is the only time it is displayed. If you lose it, you must reset the credentials of the API client.

7. Click **Close**. You are back on the **Personal API clients** page.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-10.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-10.png){: data-lightbox="gallery"}{:class="img-500"}

You now have everything needed to authenticate to the COM API and create your webhook in your COM instance.

[↑ Back to Top](#)


## Configure the webhook with Bruno

In the next steps you call the COM API with **Bruno**, an API client installed on your desktop. Bruno sends the HTTP requests and shows you exactly what is sent to COM and what COM returns.

The **COM Webhooks HOL** collection is already loaded in Bruno and contains the requests you need. Your station's Relay URL and shared secret are already set in its environment, so you do not have to enter them. You will use the Client ID and Client Secret you just saved to authenticate to the COM API, and then create your webhook.

> **Note**: A public [Postman collection for COM](https://www.postman.com/jullienl/lionel-jullien-s-public-workspace/http-request/nralhjo/list-all-webhooks?sideView=agentMode) is also available. It contains more webhook request examples that you can reuse after the lab.

1. From your Horizon desktop, open Bruno:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-11.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-11.png){: data-lightbox="gallery"}{:class="img-500"}

2. In the collections pane, open **COM Webhooks HOL** > **Create session**.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-12.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-12.png){: data-lightbox="gallery"}{:class="img-900"}

3. The collection includes a **GreenLake** environment that already defines the values needed to connect to HPE GreenLake and call the COM API. Click **GreenLake** in the top right-hand corner. 
   
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-12a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-12a.png){: data-lightbox="gallery"}{:class="img-900"}

4. Click **Configure**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-12b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-12b.png){: data-lightbox="gallery"}{:class="img-900"}

    The only values missing are `ClientID` and `ClientSecret`. 

5. Paste the Client ID you saved earlier into the **ClientID** field, then click **Save** to store it as an environment variable. 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-13.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-13.png){: data-lightbox="gallery"}{:class="img-700"}

6. Open the **Secrets** tab, paste the Client Secret into the **ClientSecret** field, then click **Save**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-14.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-14.png){: data-lightbox="gallery"}{:class="img-700"}

    Bruno now has the credentials it needs to request a session from the COM instance.

7. Go back to **Create session** and click **Send** to request a session from the COM instance:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-15.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-15.png){: data-lightbox="gallery"}{:class="img-900"}

    GreenLake returns an access token. A Bruno script captures it automatically and reuses it in every subsequent request you send.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-15a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-15a.png){: data-lightbox="gallery"}{:class="img-900"}

8. Now that you have a token, check whether any webhooks are already configured in your COM instance. Expand the **Webhooks** folder, select **List all webhooks**, and click **Send**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-16.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-16.png){: data-lightbox="gallery"}{:class="img-900"}

    The response shows `"total": 0`, which means no webhooks are defined yet.

9. To create the webhook, select the **RAISE - Create a webhook that activates when server powered off - For Azure Relay** request:     

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-17.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-17.png){: data-lightbox="gallery"}{:class="img-900"}

    Defining a webhook in COM takes a `POST` request with a JSON payload. The payload contains the URL of the webhook listener, the events to subscribe to, a name, a state, and the headers to send with each event. 

    A webhook destination must be publicly reachable so that COM can post events to it. This also means that anyone who discovers the URL can send `POST` requests to it. Without an additional check, a malicious caller could inject forged events into your pipeline and cause bogus notifications, false tickets, or even a denial-of-service flood.

    The `headers` property of the webhook definition addresses this.  

10. The request sets an `x-shim-secret` header to a secret value stored in the Bruno environment. Hover over `{% raw %}{{process.env.SHARED_SECRET}}{% endraw %}` to reveal it. This value works like a password: the receiver compares it with its own configured secret, which confirms that the webhook comes from your COM instance.        

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-18.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-18.png){: data-lightbox="gallery"}{:class="img-900"}

11. Now look at the `destination` property of the payload:

    {% raw %}
    ```json
    "destination": "{{process.env.RELAY_URL}}",
    ```
    {% endraw %}

    This is the URL where COM posts every event that matches your filter. COM is a SaaS service, so it can only deliver to a publicly reachable HTTPS endpoint, and your lab VM is not one. In this lab the destination is the **Relay**, a small receiver hosted in Azure.

    The Relay is part of [HPE COM Event Integrations](https://github.com/jullienl/HPE-COM-Event-Integrations), the open-source project described in the section [About HPE COM Event Integrations](#about-hpe-com-event-integrations) at the start of this guide. 
    
    This lab uses its **Relay + Shim** deployment:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-18a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-18a.png){: data-lightbox="gallery"}{:class="img-600"}

    - **Relay**: the public HTTPS endpoint. It answers the COM verification handshake, checks the `x-shim-secret` header, and puts each valid event on a durable cloud queue.
    - **Shim**: runs on your lab VM, and you start it in Task 2. It pulls events from the queue, then normalizes, de-duplicates, and delivers them to your targets.

    The Shim only makes outbound connections, so no inbound port is opened into your network. The Relay URL for your station is already set in the Bruno environment, so you do not need to change it.

12. Next, look at the `state` property:

    ```json
    "state": "ENABLED",
    ```

    `state` is the on/off switch of the webhook:

    | Value | Meaning |
    |---|---|
    | `ENABLED` | The webhook is ready to send events to the destination. COM starts the handshake with the destination as soon as the webhook is created. |
    | `DISABLED` | The webhook sends nothing until you set it back to `ENABLED`. |

    COM also reports a read-only `status`. It is `PENDING` while the handshake runs and becomes `ACTIVE` once the destination has answered correctly, which is when events start to flow. If deliveries keep failing, COM sets the state to `DISABLED` on its own and does not re-enable it, so you have to do that yourself.

13. Finally, look at the `eventFilter` property:

    ```json
    "eventFilter": "type eq 'compute-ops/server' and old/hardware/powerState eq 'ON' and changed/hardware/powerState eq True",
    ```

    This is the filter you built earlier in this task. COM evaluates it against every server event and sends only those that match all three conditions:

    | Condition | Meaning |
    |---|---|
    | `type eq 'compute-ops/server'` | The event is about a server. |
    | `old/hardware/powerState eq 'ON'` | Before the change, the server was powered on. |
    | `changed/hardware/powerState eq True` | The power state is different after the change. |

    Together they match one transition only: a server going from `ON` to something else, which is a power off. A server powering on does not match, because its previous state is not `ON`. This is why the request is named **RAISE**: it reports the problem, and a separate webhook is needed to report the recovery.

    Without a filter, the destination would receive a full snapshot of the server for every change, such as firmware, tags or health, and your pipeline would have to discard most of them.

14. Click **Send** to create the webhook. COM answers with the definition of your new webhook, including its `id`. The `state` is `ENABLED` and the `status` is `PENDING`, because COM is now running the handshake with your Relay.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-19.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-19.png){: data-lightbox="gallery"}{:class="img-900"}

15. Verify that the handshake succeeded. Select **List all webhooks** again and click **Send**. The response now shows `"total": 1` and your webhook with `"status": "ACTIVE"`.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-20.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-20.png){: data-lightbox="gallery"}{:class="img-900"}

    If the status is still `PENDING`, wait a few seconds and send the request again. If it is `WARNING`, read the `statusReason` field: the handshake failed, which most often means the destination or the `x-shim-secret` value is wrong. Ask your proctor for help.

Your webhook is now active, so COM sends an event to the Relay each time your server powers off. In the next task you look more closely at the Relay in Azure and at what happens to an event once it arrives.

[↑ Back to Top](#)

# Task 2 - Live COM event

<p class="step-meta">(Task 2 of 3) ⏱️ ~60 min</p>

In Task 1 you registered a webhook that points to the Relay. In this task you follow a real event from COM to your applications:

1. You look at the Relay and its queue in Azure.
2. You start the Shim on your VM and send the event to Mattermost.
3. You power off your server to generate a real event and follow it through the pipeline.
4. You add a second target, GitHub, by changing one parameter.
5. You create a second webhook so that a recovery closes the GitHub issue.

> **Note**: A power action in COM takes a few minutes to complete, and COM can take another minute or two to send the event. Wait until the server shows its new power state, and until the Shim logs the event, before you start the next action.


## Inspect your queue and Relay in Azure

Before you generate any event, look at the two Azure components behind the URL your webhook points to: the **Relay** and the **queue** it writes to.

**Why a Relay and a queue?**

COM is a SaaS service. It can only deliver a webhook to a public HTTPS endpoint, and it sends each event once: COM does not retry a failed delivery, and repeated failures make COM disable the webhook. The systems that should receive your events, such as an ITSM tool or a chat tool, are usually private, so they cannot be that public endpoint. They can also be slow or down, and that must never look like a failure to COM.

The solution splits the work in two parts and puts a durable queue between them:

```text
                                                HPE Compute Ops Management (SaaS)
                                                                |
                                                                |  HTTPS POST, one per event
                                                                v
                                                +------------------------------------------------+
                                                |  RELAY   (Azure Container App, in the cloud)   |
                                                |   - answers the COM verification handshake     |
                                                |   - checks the x-shim-secret header            |
                                                |   - writes the event to the queue              |
                                                |   - answers COM with 202 immediately           |
                                                +------------------------------------------------+
                                                                |
                                                                v
                                                +------------------------------------------------+
                                                |  QUEUE   (Azure Service Bus, in the cloud)     |
                                                |   durable buffer: events wait here until a     |
                                                |   consumer takes them                          |
                                                +------------------------------------------------+
                                                                ^
                                                                |  outbound connection only
                                                +------------------------------------------------+
                                                |  SHIM    (container on your VM, next section)  |
                                                |   pulls events and delivers them to targets    |
                                                +------------------------------------------------+
```
{: .no-copy}

- The **Relay** is deliberately simple. It does one job, accepting events from COM safely and quickly, so COM always sees a healthy endpoint.
- The **queue** keeps every accepted event until the Shim confirms it processed it. If the Shim is stopped or a target is down, events wait in the queue instead of being lost.
- The **Shim** only makes outbound connections to the queue, so no inbound port is ever opened into your network.

The Relay and the queue of every station were deployed with the open-source project [HPE COM Event Integrations](https://github.com/jullienl/HPE-COM-Event-Integrations). Its runbooks give the step-by-step instructions to build the same thing from scratch in your own environment:

- [Azure runbook](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-relay/docs/Deploy-End-to-End-to-Azure.md): Relay on Azure Container Apps and queue on Azure Service Bus.
- [AWS runbook](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-relay/docs/Deploy-End-to-End-to-AWS.md): Relay on AWS App Runner and queue on Amazon SQS.
- [Relay documentation](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-relay/README.md): architecture, delivery guarantees and configuration.

Your lab account can read only your own queue and Relay, so you can follow your own traffic without seeing anyone else's. In the next steps you sign in to Azure with the Azure CLI and look at both components. All the values you need are in **Station Info**, in the **Azure CLI variables** block.

1. To sign in to Azure, open **Terminal** from the desktop:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-22.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-22.png){: data-lightbox="gallery"}{:class="img-800"}

2. Then run:

    ```powershell
    az login 
    ```

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-22a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-22a.png){: data-lightbox="gallery"}{:class="img-800"}

3. Complete the sign-in in the browser window with the username and password from your login sheet. When asked, use the **Work or school account** option:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-23.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-23.png){: data-lightbox="gallery"}{:class="img-400"}

4. At the **Sign in to all apps and websites on this device?** message, click **No, this app only**: 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-24.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-24.png){: data-lightbox="gallery"}{:class="img-400"}

5. Press **Enter** at the **Select a subscription and tenant** dialogue:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-25.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-25.png){: data-lightbox="gallery"}{:class="img-700"}

6. In **Station Info**, find the **Azure CLI variables** block and copy it: 
    
    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-25a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-25a.png){: data-lightbox="gallery"}{:class="img-700"}

    The block contains four PowerShell variables that the commands in this task reuse. They hold the names of your own Azure resources: the resource group, the Service Bus namespace, your queue, and your Relay app. 
    
    The variables exist only in the terminal where you set them, so keep using the same terminal until the end of this task.
       
7. Paste the block into the terminal to set the variables: 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-26.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-26.png){: data-lightbox="gallery"}{:class="img-600"}

8. Check that the Relay is running. It is a container in Azure Container Apps, and this command lists its running replicas:

    ```powershell
    az containerapp replica list --resource-group $ResourceGroup --name $Relay --query "[].{replica:name, state:properties.runningState}" -o table
    ```

    You should see at least one replica in the `Running` state. The Relay is kept running for the whole lab: COM does not retry, so an event sent while the Relay is down would be lost.

9. Look at your Relay log:

    ```powershell
    az containerapp logs show --resource-group $ResourceGroup --name $Relay --tail 30
    ```

    Each line is a JSON object. Look for this message:

    ```text
    handshake received; echoing verification token
    ```

    This is the verification handshake that COM ran when you created your webhook in Task 1: COM sent a challenge, and the Relay echoed it back, which turned the webhook `status` to `ACTIVE`. 

10. Get the public address of your Relay:
    
    ```powershell
    $FQDN = az containerapp show --resource-group $ResourceGroup --name $Relay --query properties.configuration.ingress.fqdn -o tsv
    $FQDN        # Display the Relay URL
    ```

11. Check the health of the Relay. It exposes two endpoints that need no secret:

    - `/healthz` is the **liveness** check. It answers `ok` when the Relay process is running.
    - `/readyz` is the **readiness** check. It answers `ready` only when the Relay can also reach the queue. Otherwise it returns `503`, which means events cannot be queued.

    Using the public address of your Relay, call both endpoints:

    ```powershell
    curl.exe -s "https://$FQDN/healthz"    # {"status":"ok"}
    curl.exe -s "https://$FQDN/readyz"     # {"status":"ready"}
    ```

    A monitoring tool can poll these two URLs in the same way to alert you when the Relay stops accepting events.

12. See how the Relay was started. It is a container image published on [GitHub Container Registry](https://github.com/jullienl/HPE-COM-Event-Integrations/pkgs/container/com-event-relay), run as an Azure Container App with a public HTTPS address. This command shows its main settings:

    ```powershell
    az containerapp show --resource-group $ResourceGroup --name $Relay --query "{image:properties.template.containers[0].image, url:properties.configuration.ingress.fqdn, port:properties.configuration.ingress.targetPort, minReplicas:properties.template.scale.minReplicas, env:properties.template.containers[0].env[].{name:name, value:value, secretRef:secretRef}}"
    ```

    Look at the result:

    - `image` is the Relay container image.
    - `url` and `port` are the public address and the port the container listens on. Azure terminates the TLS connection and forwards the request to the container, so the Relay does not manage any certificate.
    - `minReplicas` is the number of copies kept running, so the Relay is always ready to answer COM.
    - `env` lists the Relay settings: the queue backend (`servicebus`), the queue name, and the name of the header that carries the shared secret (`x-shim-secret`). The two sensitive values, the shared secret and the queue key that only allows sending, appear as `secretRef`. They are stored as Container App secrets and their values are never shown.

    The deployment script in the [Azure runbook](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-relay/docs/Deploy-End-to-End-to-Azure.md) creates the queue, its keys and this container with a handful of `az` commands.

13. Look at your queue. The first command shows how many events are waiting and the rules the queue applies:

    ```powershell
    az servicebus queue show --resource-group $ResourceGroup --namespace-name $Namespace --name $Queue --query "{active:countDetails.activeMessageCount, deadLetter:countDetails.deadLetterMessageCount, lockDuration:lockDuration, maxDeliveryCount:maxDeliveryCount, timeToLive:defaultMessageTimeToLive}"
    ```

    | Value | Meaning |
    |---|---|
    | `active` | Events waiting for a consumer. It is `0` now because your server has not sent any event yet. |
    | `deadLetter` | Events that could not be processed after several attempts. They are set aside here instead of being lost or retried forever. |
    | `lockDuration` | When the Shim receives an event, the event is locked for this time. If the Shim does not confirm it in time, the event goes back to the queue. `PT5M` is a duration in ISO 8601 format, and it means 5 minutes. |
    | `maxDeliveryCount` | The number of attempts before an event moves to the dead-letter queue. |
    | `timeToLive` | How long an event can wait in the queue before it expires. `P14D` means 14 days. |

    Two access keys protect the queue. The Relay holds a key that can only send, and the Shim uses a key that can only listen. Neither can do the other's job.

Keep this terminal open. You will come back to the queue and the Relay log after your first real event.

[↑ Back to Top](#)


## Run the Shim on your VM

The Relay and the queue are the cloud part of the pipeline. The **Shim** is the part that decides what happens to an event, and it runs on your VM as a Docker container.

**What the Shim does**

```text
                                        Queue (Azure Service Bus)
                                                |
                                                |  1. pulls an event (outbound connection only)
                                                v
                                        +--------------------------------------------------------------+
                                        |  SHIM  (Docker container on your VM)                         |
                                        |                                                              |
                                        |   2. Normalize     the COM payload becomes a neutral event   |
                                        |   3. Correlate     a problem and its recovery share one key  |
                                        |   4. De-duplicate  an event already delivered is skipped     |
                                        |   5. Deliver       each target has its own adapter           |
                                        +--------------------------------------------------------------+
                                                |                    |                     |
                                                v                    v                     v
                                        Mattermost adapter    GitHub adapter    ServiceNow, Jira, Slack,
                                                                                Teams, PagerDuty, Splunk ...
                                                |
                                                |  6. confirms the event to the queue (or sets it aside)
                                                v
                                              Queue
```
{: .no-copy}

- **Normalize**: a COM server event is a full snapshot of the server, not a description of what changed. The Shim turns it into a neutral event with a title, a severity, and the server identity, so adapters never depend on the COM format. The `SERVER_MONITORS` setting tells it which condition to watch, for example `power` or `health`.
- **Correlate**: a problem and its later recovery get the same `correlation_key`, for example `server:<serial>:power`. The action is `raise` for the problem and `clear` for the recovery, so a target can close the item it opened.
- **De-duplicate**: the Shim remembers what it delivered, per target, for a limited time (one hour by default). It skips a repeat of the same event, so a redelivery or a repeated alert does not create a second ticket or a second message.
- **Deliver**: one adapter per target turns the neutral event into the call that target expects. The `TARGETS` setting selects one or several adapters, and the project provides 18 of them. If a target fails, the Shim gives the event back to the queue so it is retried, and the targets that already succeeded are not repeated.

The `SERVER_MONITORS` setting selects which conditions of the server snapshot become raise and clear events. `health` is the default. This lab uses `power` in Task 2 and `health` in Task 3:

| Condition | Raise when | Clear when | Severity |
|---|---|---|---|
| `health` (default) | The health summary leaves `OK` | The health summary returns to `OK` | Mapped from the COM health value |
| `power` | The server powers off | The server powers back on | warning |
| `connection` | The server disconnects from COM | The server reconnects | major |
| `subscription` | The subscription leaves `SUBSCRIBED` or expires | The subscription is `SUBSCRIBED` and valid | minor |

Each condition has its own correlation key, such as `server:<serial>:power`, so a recovery for one condition never closes an incident opened for another. Each monitored transition needs its own pair of COM webhooks, one for the raise and one for the clear, like the two you create in this task.

> **Note**: Chat adapters such as Slack, Mattermost and Teams only post, so they show a `Resolved` message for every enabled condition that is healthy in a snapshot. Enable only the conditions you want alerts on.

**Why Mattermost in this lab**

ChatOps is the most common destination for events, and Slack is the usual choice. A Slack integration needs a Slack workspace, an app approved by the workspace administrator, and security settings that cannot be shared between 25 participants in a lab. This lab uses **Mattermost** instead, an open-source ChatOps tool hosted in the lab network. Each team has its own account and its own private channel, and the Shim sends to it with the same incoming webhook concept as Slack.

1. Docker is already installed on your VM. Open a **PowerShell** tab in **Windows Terminal**, go to your station folder, and check that the setup completed:

    ```powershell
    cd $env:USERPROFILE\hol
    docker version
    Get-Content .\logon.log -Tail 3
    ```

    `docker version` must show a `Server` section, and the last line of `logon.log` must be `ready`. This means the Docker engine is running and the Shim image is downloaded.

2. Look at the Shim settings prepared for your station:

    ```powershell
    Get-Content .\shim-1-mattermost.env
    ```

    The file holds the minimum for this step: the queue to read and the Mattermost target. Your folder has one settings file per step of the lab, and each one adds to the previous one. Sensitive values are not in these files. Each one is a `..._FILE` setting that points to a file in the `secrets` folder, which Docker mounts into the container as read-only files. This keeps the secrets out of the container environment.

3. Start the Shim with a single target, Mattermost:

    ```powershell
    cd $env:USERPROFILE\hol
    docker run --rm --name com-event-shim `
      --env-file .\shim-1-mattermost.env `
      -v "${PWD}\secrets:/run/secrets:ro" `
      -e TARGETS=mattermost `
      -e SERVER_MONITORS=power `
      ghcr.io/jullienl/com-event-shim:1.0.6
    ```

    | Part of the command | Meaning |
    |---|---|
    | `--rm` | Removes the container when it stops. Its memory, including the de-duplication memory, starts empty at every run. |
    | `--env-file .\shim-1-mattermost.env` | Loads the settings of this step. |
    | `-v "${PWD}\secrets:/run/secrets:ro"` | Makes your secret files available to the container, read-only. |
    | `-e TARGETS=mattermost` | Delivers events to the Mattermost adapter only. |
    | `-e SERVER_MONITORS=power` | Watches the power state of the server. A power off is a problem (`raise`) and a power on is a recovery (`clear`). |
    | `ghcr.io/jullienl/com-event-shim:1.0.6` | The Shim image. |

    > **Note**: If the image cannot be downloaded, load the backup copy from your folder with `docker load -i .\com-event-shim.tar`, then run the command again.

    The `TARGETS` setting selects the target adapters. The HPE COM Event Integrations framework supports many of them, such as ServiceNow, Jira, Slack, Teams, PagerDuty and Splunk, and a generic webhook adapter for any other HTTP endpoint. See the [list of supported integrations](https://github.com/jullienl/HPE-COM-Event-Integrations#supported-integrations).

4. The Shim logs that it started and which targets it uses:

    ```text
    shim starting; targets=mattermost draining queue outbound-only
    ```
    {: .no-copy}

    Leave this window open and running. Open a second **PowerShell** tab for the other commands of this lab (**Ctrl**+**Shift**+**T**). Stop the Shim with **Ctrl**+**C** when asked.

5. Open Mattermost from the desktop:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-30.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-30.png){: data-lightbox="gallery"}{:class="img-600"}

6. Sign in with your Mattermost username and password from the **Station Info**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-31.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-31.png){: data-lightbox="gallery"}{:class="img-700"}

7. Open your channel, `COM-Events-team-NN`. It is private to your team and has no messages yet. The Shim posts your notifications there.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-32.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-32.png){: data-lightbox="gallery"}{:class="img-700"}

[↑ Back to Top](#)


## Generate a real COM event

Everything is in place: the webhook in COM, the Relay, the queue, and the Shim. Power off your server from HPE GreenLake to generate a real event.

1. In the HPE GreenLake tab of Chrome, launch COM from **≡** > **Services** > **Compute Ops Management**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-33.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-33.png){: data-lightbox="gallery"}{:class="img-900"}

2. Open **Servers**, select your server, then click **Actions**, select **Power off**, and confirm.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-34.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-34.png){: data-lightbox="gallery"}{:class="img-800"}

    COM detects the new power state and sends the event to your webhook. This can take up to a minute or two.

3. Watch the Shim window. When the event arrives, the Shim logs that it delivered it:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-35.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-35.png){: data-lightbox="gallery"}{:class="img-800"}   

4. Open Bruno and select the **List deliveries of server shutdown raise webhook** request:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-35a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-35a.png){: data-lightbox="gallery"}{:class="img-1000"}

    This COM API request calls `/webhooks/<webhook_id>/deliveries`. It returns the 10 most recent deliveries of the webhook and its 5 most recent failures.

5. Click **Send**:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-35b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-35b.png){: data-lightbox="gallery"}{:class="img-800"}

    The response contains a lot of data. It is the payload that COM sent to the Relay when your server was powered off. It follows the `server` data schema, because the `eventFilter` you defined when you created the webhook selects the `compute-ops/server` resource type (`type eq 'compute-ops/server'`). 

6. Open Mattermost. Your channel shows a new notification, `Server <name> is powered OFF`, with the severity, the action (`raise`), the model, and the serial number of your server.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-36.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-36.png){: data-lightbox="gallery"}{:class="img-800"}

7. Go back to your Azure terminal and run the Relay log command from the previous section again:

    ```powershell
    az containerapp logs show --resource-group $ResourceGroup --name $Relay --tail 10
    ```

    The Relay logged `event enqueued` with status `202`. Now check the queue:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-37.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-37.png){: data-lightbox="gallery"}{:class="img-900"}

    ```powershell
    az servicebus queue show --resource-group $ResourceGroup --namespace-name $Namespace --name $Queue --query countDetails
    ```

    `activeMessageCount` is back to `0`: the Shim took the event from the queue and confirmed it. If your Shim had been stopped, the event would still be waiting here.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-38.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-38.png){: data-lightbox="gallery"}{:class="img-900"}

> **Troubleshooting**: If no notification appears after two or three minutes, check these points in order:
>
> - The power state really changed from `ON` to `OFF`. A server that was already off sends nothing.
> - In Bruno, **List all webhooks** shows your RAISE webhook as `ACTIVE`, and **List deliveries** shows a recent delivery.
> - The Relay log contains `event enqueued`. If it does not, COM did not send the event: ask your proctor.
> - The queue shows an `activeMessageCount` above `0`. If it does, the Shim is not running or cannot read the queue: look for an error in the Shim window.
> - The Shim window shows a `delivered to` line. If it shows a delivery error instead, the target did not accept the event.

This is the full path of the event:

```text
   Server powered off
        -> COM detects the change and checks your webhook filter
        -> COM sends one HTTPS POST to the Relay
        -> Relay checks the secret, writes the event to the queue, answers 202
        -> Shim pulls the event, normalizes it, checks de-duplication
        -> Mattermost adapter posts the message to your channel
        -> Shim confirms the event to the queue
```
{: .no-copy}

[↑ Back to Top](#)


## Send the event to a second target

A notification in a chat is useful, but an incident usually also needs a ticket. A strength of the Shim is that adding a target is a configuration change: you change the `TARGETS` parameter and load the settings file that has the credentials of the new target.

In a real environment the second target is often an ITSM tool such as ServiceNow, Jira, or Halo. Those tools need an instance, licenses, and administrator configuration that a 25-team lab cannot provide. **GitHub Issues** shows exactly the same concept: the event becomes an issue, just as it would become a ticket in an ITSM tool. A GitHub repository dedicated to this lab receives the issues of all teams.

The GitHub settings, the repository and the access token file, are in a second settings file, `shim-2-github.env`, that is already in your station folder. The access token itself is in the `secrets` folder.

1. Power your server back on. In Compute Ops Management, select your server, click **Actions**, and select **Power on**.

    No event reaches your Shim. The webhook you created only matches a server going from `ON` to `OFF`, so a power on does not match its filter.

2. Stop the Shim with **Ctrl**+**C**. Because of `--rm`, the container is removed and its de-duplication memory is lost.

3. See what the new settings file adds to the first one. Only the GitHub settings are new:

    ```powershell
    cd $env:USERPROFILE\hol
    Compare-Object (Get-Content .\shim-1-mattermost.env) (Get-Content .\shim-2-github.env)
    ```

4. Start the Shim again with two targets. Two things change: the settings file, and the `TARGETS` line:

    ```powershell
    cd $env:USERPROFILE\hol
    docker run --rm --name com-event-shim `
      --env-file .\shim-2-github.env `
      -v "${PWD}\secrets:/run/secrets:ro" `
      -e TARGETS=mattermost,github `
      -e SERVER_MONITORS=power `
      ghcr.io/jullienl/com-event-shim:1.0.6
    ```

    The log confirms both targets:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-39.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-39.png){: data-lightbox="gallery"}{:class="img-900"}

5. Power off your server again from Compute Ops Management (**Actions** > **Power off**).

6. Watch the Shim window. The event is delivered to both targets. Each adapter logs what it sent, and the `delivered to` lines confirm the result:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-40.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-40.png){: data-lightbox="gallery"}{:class="img-1000"}
  
7. Open the GitHub issues of the lab repository. In Chrome, open a new tab and click the **GitHub Issues** bookmark in the **HOL** folder of the bookmarks bar:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-41.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-41.png){: data-lightbox="gallery"}{:class="img-1000"}

8. You do not need a GitHub account to read the issues. All teams share this repository, so use the serial number of your server, which you can find in COM, to identify your issue `Server <name> is powered OFF`, and open it. 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-42.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-42.png){: data-lightbox="gallery"}{:class="img-900"}

    Its label, `com:server:<serial>:power`, is the correlation key. The Shim uses it in the next section to find this issue again and close it.

9. Look at Mattermost. It shows a second `powered OFF` notification. This is a new power off, and the Shim does not remember the first one: stopping the container cleared its de-duplication memory.

Now see de-duplication at work, with the same Shim still running:

1. Power your server on, wait for the task to complete, then power it off again.

2. Watch the Shim window. This time it does not deliver anything:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-43.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-43.png){: data-lightbox="gallery"}{:class="img-900"}

3. Check Mattermost and GitHub. There is no new message and no second issue.

The Shim builds a de-duplication key from the problem, the action, and the severity, and it keeps one key per target. The second power off is the same problem as the first one, so both targets skip it. This is the protection against a duplicate ticket for a problem that is already known, whether the cause is a redelivery from the queue or a repeated alert.

The memory lasts one hour by default, counted from the last time the event was delivered to that target. A repeat that arrives within the hour is skipped. After the hour, the same event is treated as new and delivered again. A recovery (`clear`) has its own key, so it is never skipped because of an earlier power off, and restarting the Shim clears the memory.

> **Note**: You can change the length of the de-duplication memory with the `DEDUP_TTL_SECONDS` setting. For example, adding `-e DEDUP_TTL_SECONDS=60` to the `docker run` command sets it to one minute. The value `0` turns de-duplication off, so every event is delivered:
> 
> ```powershell
>    docker run --rm --name com-event-shim `
>        --env-file .\shim-2-github.env `
>        -v "${PWD}\secrets:/run/secrets:ro" `
>        -e TARGETS=mattermost,github `
>        -e SERVER_MONITORS=power `
>        -e DEDUP_TTL_SECONDS=60 `
>        ghcr.io/jullienl/com-event-shim:1.0.6
>    ```
>    {: .no-copy}

[↑ Back to Top](#)


## Close the issue with a second webhook

Your server is powered off now. Power it back on and look at the GitHub issue.

1. In Compute Ops Management, select your server and click **Actions** > **Power on**.

2. Open your issue in GitHub again. It is still **open**, and no message is posted in Mattermost.

    The raise webhook only reports a power off. When the server comes back, COM does not send anything, so the Shim cannot know that the problem is over. A recovery needs its own webhook, with a filter for the power on. The Shim then marks it as a `clear` with the same `correlation_key`, so the GitHub adapter finds the issue it opened by its label and closes it. Mattermost posts a `Resolved` message. Without the second webhook, issues open but never close.

3. Create the second webhook with Bruno, in the same way as the first one. In the Bruno collection, right-click the **RAISE** request you used in Task 1 and select **Clone**. 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-44.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-44.png){: data-lightbox="gallery"}{:class="img-900"}

4. Name the new request `CLEAR - Create a webhook that activates when server powered on`:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-45.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-45.png){: data-lightbox="gallery"}{:class="img-800"}

5. In the body of the new request, change two properties and leave `destination`, `state`, and `headers` as they are:

    ```json
    "name": "HOL server power on clear",
    "eventFilter": "type eq 'compute-ops/server' and new/hardware/powerState eq 'ON' and changed/hardware/powerState eq True",
    ```

    The filter uses `new` where the first one used `old`. It matches a server whose power state after the event is `ON`, and only when the power state changed. This is the opposite transition of the first webhook: it fires when your server is powered on.

6. Click **Prettify** to format the JSON in the body, then click **Save**.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-46.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-46.png){: data-lightbox="gallery"}{:class="img-1000"}

7. Click **Send** to create the webhook. As in Task 1, COM runs the handshake with your Relay. Select **List all webhooks** and click **Send**. The response must now show `"total": 2`, and both webhooks must have `"status": "ACTIVE"`.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-47.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-47.png){: data-lightbox="gallery"}{:class="img-900"}

8. Now test the recovery. The new webhook only fires when the power state changes to `ON`, and your server is already on, so power it off first and then back on. Your Shim is still running with both targets. Power your server off, wait until the Shim logs the event, then power it back on. Wait for each power action to complete in COM, which can take a few minutes, before you start the next one.

    > **Note**: The Shim has already seen this power off within the last hour, so it skips it, as you saw earlier. That is expected. It is the power on that matters here. If you want to see the whole cycle, stop the Shim with **Ctrl**+**C** and start it again with the command from the previous section before you power off.

9. Watch the Shim window. The power on is a different action, `clear`, so it has its own de-duplication key and is delivered to both targets:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-48.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-48.png){: data-lightbox="gallery"}{:class="img-900"}

10. Open Mattermost, which shows a green `Resolved` message:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-49.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-49.png){: data-lightbox="gallery"}{:class="img-900"}

11. Open your GitHub issue again. It is now **closed**. If you do not see it, refresh the page and select **Closed** in the issues list.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-50.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-50.png){: data-lightbox="gallery"}{:class="img-900"}

    The raise and the clear are tied together by the `correlation_key`, so the clear closed exactly the issue that the raise opened.

You now have a complete event-driven loop: an incident opens a ticket and notifies a channel, and the recovery closes the ticket.

[↑ Back to Top](#)

# Task 3 - AI-assisted incident investigation

<p class="step-meta">(Task 3 of 3) ⏱️ ~35 min</p>

In Task 2 the event was easy to understand, because you powered the server off yourself. A real incident rarely looks like that. This task introduces what the project can add when an event alone is not enough.

## From an event to an investigation

An event such as `Server health CRITICAL` tells you that something is wrong. It does not tell you what, why, or what to do. To answer, an engineer usually has to:

- sign in to the iLO of the server and read its logs,
- check the memory, the fans, the power supplies, and the storage,
- look for an HPE Customer Advisory that matches the symptoms,
- correlate everything, and then write the ticket.

This takes time and expertise, and it happens when an incident is already in progress.

[↑ Back to Top](#)

## What the project adds

The Shim can run optional **enrichers** before it delivers an event. An enricher adds information to the event, so every target receives it.

```text
                      Queue
                        |
                        v
                       Shim
                        |-- normalize, correlate, de-duplicate
                        |
                        |-- enrichers (optional, selected with ENRICHERS)
                        |     |-- ilo_ai          reads evidence from the iLO of the server
                        |     |                   and asks an AI agent to analyze it
                        |     |-- hpe_advisories  adds the HPE Customer Advisories that
                        |                         apply to the server firmware
                        v
                    Mattermost, GitHub ...    the message and the issue carry the AI analysis
```
{: .no-copy}

The AI analysis returns a structured report: a summary, the evidence it relied on, the likely root cause, a confidence level, and recommended actions. It separates what was observed from what is only a hypothesis, and it does not present an unverified conclusion as a certain cause. The project documentation describes this feature in the section [AI-assisted incident investigation and remediation](https://github.com/jullienl/HPE-COM-Event-Integrations#ai-assisted-incident-investigation-and-remediation).

[↑ Back to Top](#)

## Why it matters

- **The pipeline does not change.** You enable the analysis with one parameter, `ENRICHERS`, and load the settings file that holds the AI settings, `shim-3-ai.env`, exactly as you added GitHub with `TARGETS` and `shim-2-github.env`.
- **The first responder starts with context.** The notification and the ticket already contain the evidence and a suggested next step.
- **It fails safe.** If the evidence collection or the AI service is not available, the event is still delivered, without the analysis.
- **It is guidance, not a verdict.** The report states its confidence, and you still verify the hardware.

[↑ Back to Top](#)

## The AI Gateway

The Shim does not talk to an AI model itself. It sends the evidence to the **AI Gateway**, a separate container, developed as its own open-source project, [ai-gateway](https://github.com/jullienl/ai-gateway), that integrates easily with this framework. It provides the `com-rca` agent (root cause analysis of a COM incident) and can use GitHub Copilot, OpenAI, Anthropic, or an on-premises OpenAI-compatible model. In this lab a shared AI Gateway serves all stations.

The two projects each own one side of the exchange. The AI Gateway owns the agent prompt and the connection to the model. HPE COM Event Integrations owns the contract: the enrichment input that the Shim sends and the output it expects back. Any service that implements this contract can replace the AI Gateway. See the [AI Gateway Operator Guide](https://github.com/jullienl/ai-gateway/blob/main/GUIDE.md) for deployment and provider configuration.

In the next sections you send the same simulated incident three times. First you send it with no enricher, to get a baseline. Then you restart your Shim to enable the AI analysis with evidence read from an iLO, and finally to add the HPE Customer Advisories. After each change you compare the result with the previous run.

[↑ Back to Top](#)

## The simulated incident

In Task 2 you powered off your own server, so the cause was obvious. Here you send a **simulated** incident instead: a COM event that says the health of your server is critical, without saying why. The Shim has to find out. It takes the address of the server's iLO from the event, reads evidence from it through the Redfish API, and asks an AI agent to analyze that evidence. In this lab the iLO is a simulator that holds a storage fault.

You send the simulated event to your own Relay, exactly as COM would. The Relay cannot tell the difference between a real and a simulated event, so nothing changes in the pipeline.

**What the Shim reads from the iLO**

The event only says that the health is critical. The iLO knows which component is at fault, and it exposes that through **Redfish**, the standard REST API of the iLO. When a problem event arrives, the `ilo_ai` enricher collects a small, focused set of evidence from the iLO of the server:

- **Overall state**: the system health and the health of its subsystems.
- **Thermal and power**: the temperature sensors and fans, and the power supplies.
- **Memory**: the DIMMs.
- **Storage**: the drive controllers and the drives. Their paths differ from one server to another, so the Shim discovers them instead of assuming them.
- **Integrated Management Log (IML)**: the event log of the iLO, which is often the richest clue.

The Shim keeps the evidence small on purpose. It keeps only the unhealthy components, with a count of the healthy ones, so "1 of 24 drives degraded" can still be expressed. From the log it keeps only the entries that are not `OK`, most recent first, up to a limit. A complete log or a full sensor list would be mostly noise and could be too large for the AI to use.

Three more properties are worth knowing:

- **Read-only.** The Shim only reads. It uses a read-only account and issues only `GET` requests, so it cannot change anything on the server.
- **Outbound only.** The connection to the iLO starts from the Shim on your VM. The Relay in Azure has no route to a management network, which is why this step runs in the Shim.
- **Once per incident.** The analysis runs for a problem (`raise`) at or above the minimum severity, never for a recovery, and the result is kept so a delivery retry does not pay for a second analysis.

The Shim then sends the event and this evidence to the AI Gateway, which asks the AI agent to analyze them. If an iLO resource does not exist, the Shim notes it and continues with the rest: a partial set of evidence is better than none, and an iLO that cannot be reached never prevents the delivery of the event.

[↑ Back to Top](#)

## Send a baseline incident

First send the incident with no enricher, to see what the pipeline delivers on its own. This baseline is what you compare the next runs with.

1. In the Shim window, stop the Shim with **Ctrl**+**C**.

2. See what the third settings file adds to the second one:

    ```powershell
    cd $env:USERPROFILE\hol
    Compare-Object (Get-Content .\shim-2-github.env) (Get-Content .\shim-3-ai.env)
    ```

    | Setting | Meaning |
    |---|---|
    | `AI_ANALYZER_URL` | The address of the AI Gateway, a shared service that calls the AI model for you. |
    | `AI_AGENT` | The agent that analyzes a COM incident (`com-rca`). |
    | `AI_MIN_SEVERITY` | The lowest severity that is analyzed. With `warning`, informational events are not sent to the AI. |
    | `AI_TENANT` | Identifies your station to the AI Gateway. |
    | `ILO_USERNAME`, `ILO_PASSWORD_FILE` | The read-only account the Shim uses to read the evidence from the iLO. The password is in the `secrets` folder. |
    | `ILO_INSECURE` | Accepts the self-signed certificate of the simulated iLO. Use it in a lab only. |

3. Start the Shim again, first with no enricher. This gives you a baseline. Two things change compared with Task 2: the settings file, and the monitored condition:

    ```powershell
    cd $env:USERPROFILE\hol
    docker run --rm --name com-event-shim `
      --env-file .\shim-3-ai.env `
      -v "${PWD}\secrets:/run/secrets:ro" `
      -e TARGETS=mattermost,github `
      -e SERVER_MONITORS=health `
      ghcr.io/jullienl/com-event-shim:1.0.6
    ```

    | Part of the command | Meaning |
    |---|---|
    | `--env-file .\shim-3-ai.env` | Loads the settings of this step. The AI settings it holds are not used while no enricher is enabled. |
    | `-e SERVER_MONITORS=health` | Watches the health of the server instead of its power state, because the simulated incident is a health problem. |

4. The Shim logs which targets it uses. `ENRICHERS` is not set, so the Shim adds nothing before delivery, exactly as in Task 2.

5. In **Station Info**, copy the `$DeviceId` line from the **Server for the AI steps** block. It is the identity of your own server in COM: its part number and its serial number.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-52.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-52.png){: data-lightbox="gallery"}{:class="img-900"}

6. Open the second PowerShell tab and paste the line into this tab:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-53.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-53.png){: data-lightbox="gallery"}{:class="img-600"}

7. Send the simulated incident to your Relay. Copy and paste the whole block then press **Enter**:

    ```powershell
    cd $env:USERPROFILE\hol
    $RelayUrl = (Select-String -Path .\bruno.env -Pattern '^RELAY_URL=(.*)$').Matches[0].Groups[1].Value.Trim()
    $Secret   = (Get-Content .\secrets\com-shared-secret.txt -Raw).Trim()
    $Serial   = $DeviceId.Split('+')[1]
    $Headers  = @{
        "x-shim-secret"                 = $Secret
        "x-compute-ops-mgmt-event-type" = "compute-ops-mgmt.server.updated"
    }

    function New-Snapshot($Health) {
        @{
            id        = $DeviceId
            type      = "compute-ops-mgmt/server"
            name      = "hol-storage-server"
            operation = "Updated"
            updatedAt = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
            firmwareBundleUri = "/compute-ops-mgmt/v1/firmware-bundles/86542f6c69ed49ceb75452ec85e753ad"
            hardware  = @{
                serialNumber = $Serial
                productId    = $DeviceId.Split('+')[0]
                model        = "ProLiant DL325 Gen12"
                health       = $Health
                powerState   = "ON"
                bmc          = @{ ip = "10.18.22.20:8004" }
            }
            tags = @{}
        } | ConvertTo-Json -Depth 6
    }

    $RaiseJson = New-Snapshot @{
        summary      = "CRITICAL"
        storage      = "MRSA StorCLI on Windows reports a BSOD and unexpected reboot after the S100i storage controller firmware update"
        smartStorage = "S100i storage controller is enabled and reporting a critical condition"
    }
    $ClearJson = New-Snapshot @{ summary = "OK"; storage = "OK"; smartStorage = "OK" }

    (Invoke-WebRequest -Method Post -Uri $RelayUrl -Headers $Headers -ContentType "application/json" -Body $RaiseJson -UseBasicParsing).StatusCode
    ```

    The Relay answers `202`: it authenticated the request and put the event on your queue. The block also prepares a healthy version of the event, `$ClearJson`, that you use to close the incident.

    Look at what the event contains. Your server identity and the health `CRITICAL` are there, together with two short storage messages, and `bmc` holds the address of the simulated iLO. The event does not say what exactly is wrong with the storage, why, or what to do. The Shim has to find that in the iLO. It also carries a `firmwareBundleUri`, which nothing uses yet and which you need in the next section.

8. Watch the Shim window. There is no enricher, so the Shim delivers the event straight away, as in Task 2. It does not read the iLO and does not call the AI Gateway.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-50a.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-50a.png){: data-lightbox="gallery"}{:class="img-900"}

9. Open Mattermost and the GitHub issue of your server. They show the event as the Shim normalized it: the health `CRITICAL` and the two storage messages that were in the event, and nothing more. This is your baseline. It tells you that something is wrong, but not which component is affected, why, or what to do next.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-50b.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-50b.png){: data-lightbox="gallery"}{:class="img-900"}

10. Close the incident. In the second PowerShell tab, send the healthy version of the event:

    ```powershell
    (Invoke-WebRequest -Method Post -Uri $RelayUrl -Headers $Headers -ContentType "application/json" -Body $ClearJson -UseBasicParsing).StatusCode
    ```

    Mattermost shows a `Resolved` message and the GitHub issue is closed, so the next run opens a fresh issue.

[↑ Back to Top](#)

## Add AI analysis with iLO evidence

Now restart the Shim with the `ilo_ai` enricher and send the same incident again.

1. Stop the Shim with **Ctrl**+**C** and start it again. Only one thing changes, the new `ENRICHERS` line:

    ```powershell
    cd $env:USERPROFILE\hol
    docker run --rm --name com-event-shim `
      --env-file .\shim-3-ai.env `
      -v "${PWD}\secrets:/run/secrets:ro" `
      -e TARGETS=mattermost,github `
      -e SERVER_MONITORS=health `
      -e ENRICHERS=ilo_ai `
      ghcr.io/jullienl/com-event-shim:1.0.6
    ```

    | Part of the command | Meaning |
    |---|---|
    | `-e ENRICHERS=ilo_ai` | Adds a stage before delivery that reads the iLO evidence and asks the AI agent to analyze it. |

    The Shim logs that the enricher is enabled:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-51.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-51.png){: data-lightbox="gallery"}{:class="img-900"}

2. In the second PowerShell tab, send the same incident again:

    ```powershell
    (Invoke-WebRequest -Method Post -Uri $RelayUrl -Headers $Headers -ContentType "application/json" -Body $RaiseJson -UseBasicParsing).StatusCode
    ```

3. Watch the Shim window. Before it delivers the event, the Shim now reads the evidence from the iLO and calls the AI Gateway. This can take up to a minute. Look for these lines, where the values will differ:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-54.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-54.png){: data-lightbox="gallery"}{:class="img-900"}

    The `GET` lines are the Shim reading the Redfish evidence from the iLO. The first two highlighted lines are new compared with the baseline run: the POST to `/agent/com-rca` is the Shim sending that evidence to the AI agent, and the `analysed` line gives the confidence the agent reports. The analysis is done once, before delivery, so Mattermost and GitHub receive the same report. If the analysis fails, the Shim logs a warning and still delivers the event without it.

    > **Troubleshooting**: If the report is missing in Mattermost and GitHub, look in the Shim window for a warning from `ilo_ai` or from the AI Gateway. Also check that you restarted the Shim with `-e ENRICHERS=ilo_ai` and sent the incident after the restart. A plain notification means that the analysis did not run.

4. Open Mattermost. Compared with the baseline, the notification now carries the analysis of the AI agent in addition to the usual fields: a summary, the evidence it relied on, the likely root cause, a confidence level, and recommended actions.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-55.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-55.png){: data-lightbox="gallery"}{:class="img-800"}

5. Open the GitHub issues of the lab repository, as you did in Task 2, and find your issue with the serial number of your server. The issue holds the same report. 

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-56.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-56.png){: data-lightbox="gallery"}{:class="img-900"}

    Read it carefully:

    - The **evidence** is what the agent observed in the iLO, such as component states and log entries.
    - The **likely root cause** is its conclusion, and the **confidence** tells you how much to trust it.
    - The **recommended actions** are suggestions for the next steps.

    The report separates what was observed from what is only a hypothesis. It is guidance for an engineer, not a verdict, and you still verify the hardware.

6. Close the incident again. In the second PowerShell tab, send the healthy version of the event:

    ```powershell
    (Invoke-WebRequest -Method Post -Uri $RelayUrl -Headers $Headers -ContentType "application/json" -Body $ClearJson -UseBasicParsing).StatusCode
    ```

    Mattermost shows a `Resolved` message and the GitHub issue is closed, as in Task 2. The Shim does not call the AI for a recovery: when a problem is over, there is nothing left to investigate.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-57.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-57.png){: data-lightbox="gallery"}{:class="img-900"}

[↑ Back to Top](#)


## Add the HPE Customer Advisories

The iLO evidence tells the AI what the hardware reports. HPE Customer Advisories tell it what HPE already knows about the firmware your server runs. The `hpe_advisories` enricher asks COM for the firmware bundle that applies to your server, reads the open and resolved advisories of that bundle, and gives them to the AI agent together with the iLO evidence. When the server belongs to a COM group, it also checks the compliance of the server with the firmware baseline of that group.

> **Note**: Your lab server was never updated through COM and is not in a group, so COM holds no firmware baseline and no compliance data for it, and the lookup would find no bundle. The simulated event therefore carries one in `firmwareBundleUri`: the HPE firmware bundle SPP 2026.03.00.00. A server that was updated through COM provides this field itself, and it is the first place the `hpe_advisories` enricher looks.

This requires access to the COM API, so the Shim uses the personal API client that you created in Task 1.

1. In the Shim window, stop the Shim with **Ctrl**+**C**.

2. Give the Shim access to the COM API. Run this block in the Shim window and paste your Client ID and your Client Secret from your Notepad file when asked:

    ```powershell
    cd $env:USERPROFILE\hol
    $ClientId     = Read-Host "Paste your Client ID"
    $ClientSecret = Read-Host "Paste your Client Secret"
    [IO.File]::WriteAllText("$($PWD.Path)\secrets\com-client-secret.txt", $ClientSecret.Trim())
    ```

    The Client Secret goes into a file of the `secrets` folder, like the other secrets of this lab, so it stays out of the container environment. The Client ID is not secret and is passed in the command.

3. Start the Shim again with the second enricher and the COM settings:

    ```powershell
    cd $env:USERPROFILE\hol
    docker run --rm --name com-event-shim `
      --env-file .\shim-3-ai.env `
      -v "${PWD}\secrets:/run/secrets:ro" `
      -e TARGETS=mattermost,github `
      -e SERVER_MONITORS=health `
      -e ENRICHERS=hpe_advisories,ilo_ai `
      -e HPE_ADVISORIES_MIN_SEVERITY=warning `
      -e COM_BASE_URL=https://us-west.api.greenlake.hpe.com `
      -e COM_CLIENT_ID=$ClientId `
      -e COM_CLIENT_SECRET_FILE=/run/secrets/com-client-secret.txt `
      ghcr.io/jullienl/com-event-shim:1.0.6
    ```

    | Part of the command | Meaning |
    |---|---|
    | `-e ENRICHERS=hpe_advisories,ilo_ai` | Adds the advisory stage. The Shim always runs it before `ilo_ai`, whatever the order you write, so the advisories are ready when the AI request is built. |
    | `-e HPE_ADVISORIES_MIN_SEVERITY=warning` | Like `AI_MIN_SEVERITY`, the lowest severity for which the advisories are looked up. |
    | `-e COM_BASE_URL=...` | The address of the COM API for your region, the same one Bruno uses. |
    | `-e COM_CLIENT_ID=$ClientId` | Your personal API client, used to get a token for the COM API. |
    | `-e COM_CLIENT_SECRET_FILE=...` | The file that holds your Client Secret. |

4. The Shim logs both enrichers:

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-58.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-58.png){: data-lightbox="gallery"}{:class="img-900"}

5. In the second PowerShell tab, send the same incident again (RAISE):

    ```powershell
    (Invoke-WebRequest -Method Post -Uri $RelayUrl -Headers $Headers -ContentType "application/json" -Body $RaiseJson -UseBasicParsing).StatusCode
    ```

    If you closed that tab, paste the `$DeviceId` line from **Station Info** again, then run the block of the previous section again. It prepares the variables and sends the incident, so you can skip this command.

6. Watch the Shim window. The log lines look like the ones of the previous section, and the event takes a little longer because the Shim first asks COM for your firmware bundle and its advisories. If COM cannot be reached or the credentials are wrong, the Shim logs a warning and delivers the event without the advisories, as it does for any enrichment that fails.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-59.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-59.png){: data-lightbox="gallery"}{:class="img-900"}

7. Open Mattermost and the GitHub issue. Compared with the previous run, the report now has an **HPE Customer Advisories** section that lists the open and resolved advisories of the firmware bundle that applies to your server. The AI agent only cites an advisory when its title and component match the symptoms in the event and in the iLO evidence. When one matches, the analysis names it and gives its link. An advisory that is listed as resolved is not proof that your server has the fix: the bundle is the baseline that applies to your server, not necessarily the firmware it runs.

    > **Troubleshooting**: If the **HPE Customer Advisories** section is missing, look in the Shim window for a warning from `hpe_advisories`. The usual causes are a Client ID or Client Secret that was pasted incorrectly (run step 2 again) or a Shim that was started without the `COM_*` settings of step 3.

    [![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-60.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-60.png){: data-lightbox="gallery"}{:class="img-900"}

8. Compare the three runs you have seen in Task 3:

    | Run | What the Shim adds before delivery | What the notification contains |
    |---|---|---|
    | Baseline | Nothing | The normalized event: title, severity, action, model and serial number. |
    | iLO evidence | Evidence read from the iLO and an AI analysis | The event and the AI report. |
    | Advisories and iLO evidence | The advisories of your firmware bundle, then the evidence and the analysis | The event and an AI report that can cite a matching HPE Customer Advisory. |

    The delivery targets, the Relay, and the queue did not change. Only the Shim configuration did.

9. Close the incident:

    ```powershell
    (Invoke-WebRequest -Method Post -Uri $RelayUrl -Headers $Headers -ContentType "application/json" -Body $ClearJson -UseBasicParsing).StatusCode
    ```

    Mattermost shows a `Resolved` message and the GitHub issue is closed. The advisory lookup and the AI call only happen for a problem, never for a recovery.

**This is the end of the lab.** You can stop the Shim with **Ctrl**+**C**. Return your login sheet to your proctor, and continue with the summary below.

[↑ Back to Top](#)


# Summary 

Throughout this lab, you explored how to:

- Create a COM webhook with an event filter, and verify it through the handshake with the Relay.
- Follow a real server event from COM through the Relay and the queue to the Shim, and see why a queue keeps events safe when a target is down.
- Deliver the same event to several targets, Mattermost and GitHub, by changing the `TARGETS` setting.
- Use de-duplication to avoid repeated messages and tickets for a problem that is already known.
- Correlate a problem with its recovery by using a second webhook, so that a `clear` closes the issue that a `raise` opened.
- Enrich an incident with `ENRICHERS`: evidence read from an iLO through Redfish, analyzed by an AI agent, and the HPE Customer Advisories that apply to your firmware.
- Compare the same incident without enrichment, with iLO evidence and AI analysis, and with HPE Customer Advisories.
- Read an AI report critically, separating the observed evidence from the likely root cause and its confidence.

The key point is that the pipeline stayed the same from the first event to the AI-assisted investigation. The Relay, the queue, and the targets did not change. Only the configuration of the Shim did.

[↑ Back to Top](#)

# Take it to your customers and partners

What you built in this lab is a working reference, not a toy. [HPE COM Event Integrations](https://github.com/jullienl/HPE-COM-Event-Integrations) is open source, and the same pieces run in a customer environment. It is a strong conversation starter because it answers a question that many COM customers ask: how do I get COM events into the tools my teams already use?

## Why customers and partners care

- **It meets customers where they are.** One configuration setting selects the target. The project provides 18 adapters, including ServiceNow, Jira, Slack, Teams, PagerDuty and Splunk, and a generic webhook adapter for any other HTTP endpoint. A customer does not have to change its ITSM or ChatOps tool to benefit from COM. GitHub, Slack, Mattermost, Teams and Jira are validated end to end against live targets today. The other adapters are fully implemented but must be validated in the customer's own environment.
- **It complements COM's own case creation.** Automatic case creation stays in place. Events, alerts and incidents also flow into the customer's own applications, several at once.
- **It is quick to adopt.** Everything runs as containers. The Azure and AWS runbooks build the Relay and the queue from scratch, and a customer can start with one target and add others later by changing `TARGETS`.
- **It is reliable by design.** A durable queue sits between COM and the targets, so an event is not lost when a target is slow or down. A failed delivery is retried, and an event that keeps failing is set aside instead of blocking the others.
- **It reduces noise.** De-duplication avoids a second ticket for a problem that is already known, and raise/clear correlation closes the ticket when the recovery arrives, so issues do not pile up.
- **It speeds up the first response.** The AI analysis starts from real evidence read from the iLO and from the HPE Customer Advisories that match the firmware, and the report states its confidence. The responder opens a ticket that already contains a likely cause and a suggested next step.
- **It keeps the customer in control of AI.** The AI Gateway can use GitHub Copilot, OpenAI, Anthropic, or an on-premises OpenAI-compatible model, so customers with data residency or privacy constraints can keep the analysis in their own environment.
- **It is safe to deploy.** The Shim only makes outbound connections, so no inbound port is opened into the customer network. It reads the iLO with a read-only account and `GET` requests only. Secrets stay in files, not in the container environment, and the Relay rejects any request without the shared secret.
- **It is open and extensible.** The adapters, the enrichers and the contract with the AI service are documented. A partner can add a target for a tool that is not yet supported, or replace the AI service with its own, without changing the rest of the pipeline.

This diagram shows how the pieces fit in a customer environment. The Relay and its queue run in a managed cloud (Azure or AWS), the Shim runs on premises, and only the Shim makes connections, always outbound. No inbound connection is opened into the customer network.

[![]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-61.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-Events/image-61.png){: data-lightbox="gallery"}{:class="img-800"}

## Choose a deployment model

The project offers two deployment models. This lab uses Relay + Shim.

| | Relay + Shim | Bridge |
|---|---|---|
| Public HTTPS endpoint | Managed by Azure or AWS | You host it, with public DNS and a CA-signed certificate |
| Inbound port into your network | None | HTTPS is required |
| Durable buffer | Cloud queue (Azure Service Bus or AWS SQS) | Optional on-disk spool |
| Components to deploy | Two: the Relay and the Shim | One container |
| Best when | The target is in a restricted or private network, or you want no inbound path | You can expose an HTTPS endpoint and want the smallest footprint |

The README has a decision tree, [Which deployment should I choose?](https://github.com/jullienl/HPE-COM-Event-Integrations#which-deployment-should-i-choose), and the Bridge has its own [end-to-end runbook](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-bridge/docs/Deploy-End-to-End-On-Prem.md).

## When to use the native COM integration

If COM already offers a native integration for the target and it meets the requirement, that is normally the simplest option. Today this applies to ServiceNow and OpsRamp. Use this project when the customer needs something the native integration does not give:

- no inbound port into the customer network
- durable buffering and retry
- custom transformation or enrichment, such as the AI analysis
- de-duplication and raise/clear correlation
- fan-out to several targets
- a target without a native COM integration
- one integration architecture for several products

Even for ServiceNow or OpsRamp, Relay + Shim is useful when the internal endpoint must remain private.

## Where to start the conversation

| If the customer says... | Show them |
|---|---|
| "We want COM alerts in our ITSM tool." | The GitHub step of Task 2, where the same event becomes a ticket, and the list of supported adapters. |
| "We get too many duplicate tickets." | De-duplication, and the second webhook that closes the ticket when the server recovers. |
| "We cannot open a port into our network." | The Relay and queue design: the Shim only connects outbound. |
| "Our first responders lack context." | The AI report with iLO evidence and the matching HPE Customer Advisory. |
| "We cannot send data to a public AI service." | The AI Gateway with an on-premises OpenAI-compatible model. |
| "We already use ServiceNow or OpsRamp." | The native COM integration first. Position Relay + Shim when the endpoint must stay private, or when they need correlation, fan-out or enrichment. |
| "We are a partner and want to build on COM." | The open contract and the adapter model, which let you [add a target](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-core/README.md#adding-a-new-target) or your own analysis service. The project is MIT licensed. |

## Get started

1. Read the project documentation and the runbooks on [GitHub](https://github.com/jullienl/HPE-COM-Event-Integrations), and the [AI Gateway Operator Guide](https://github.com/jullienl/ai-gateway/blob/main/GUIDE.md).
2. Deploy the Relay and the queue in your own Azure or AWS subscription, start the Shim with one target, and replay the first task of this lab with your own server.
3. Add a second target and the enrichers, as you did in Tasks 2 and 3, and show the result to a customer or partner.
4. Share your feedback, ideas and new adapters through [GitHub issues](https://github.com/jullienl/HPE-COM-Event-Integrations/issues).

> **Note**: This project is a reference solution and is not an officially supported HPE product. Position it as an accelerator that customers and partners can adopt, adapt and extend.

[↑ Back to Top](#)

# Want more?

**📚** HPE COM Event Integrations resources:

| Resource | What you find there |
|---|---|
| [Project README](https://github.com/jullienl/HPE-COM-Event-Integrations) | Overview, deployment models, supported integrations, and the AI-assisted investigation section. |
| [com-event-core](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-core/README.md) | `CanonicalEvent`, the adapter table with validation status, how to add a new target, and the AI analysis enrichment guide. |
| [com-event-relay](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-relay/README.md) | Relay and Shim architecture, delivery guarantees, and configuration. |
| Runbooks | [Azure](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-relay/docs/Deploy-End-to-End-to-Azure.md), [AWS](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-relay/docs/Deploy-End-to-End-to-AWS.md) and [Bridge](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/com-event-bridge/docs/Deploy-End-to-End-On-Prem.md) end-to-end deployments. |
| [ARCHITECTURE.md](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/ARCHITECTURE.md) | Implementation-level architecture and process mapping. |
| Container images | `ghcr.io/jullienl/com-event-relay`, `ghcr.io/jullienl/com-event-shim` and `ghcr.io/jullienl/com-event-bridge` on GitHub Container Registry. |
| [AI Gateway](https://github.com/jullienl/ai-gateway) | The analyzer behind `ENRICHERS=ilo_ai`, with its [Operator Guide](https://github.com/jullienl/ai-gateway/blob/main/GUIDE.md). |
| [License](https://github.com/jullienl/HPE-COM-Event-Integrations/blob/main/LICENSE) and [issues](https://github.com/jullienl/HPE-COM-Event-Integrations/issues) | MIT license, and where to report problems or share adapter validation feedback. |

**🤖** Want to use the AI-assisted incident investigation in your own environment? See
[AI-assisted incident investigation and remediation](https://github.com/jullienl/HPE-COM-Event-Integrations#ai-assisted-incident-investigation-and-remediation)
in the HPE COM Event Integrations project.

**📦** Want more webhook request examples for COM? Use the public
[Postman collection for COM](https://www.postman.com/jullienl/lionel-jullien-s-public-workspace/http-request/6vneprl/get-account-details?sideView=agentMode).

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
COM API capabilities, from initial setup (Day 0 operations), through
activation and configuration (Day 1), to ongoing management and
maintenance (Day 2), such as automated firmware updates.

**🖥️** When you're ready to dive deeper, schedule a personalized
session on the [HPE Demonstration
Portal](https://hpedemoportal.ext.hpe.com/).

**✨** You can also request a [90-day
evaluation](https://www.hpe.com/us/en/hpe-compute-ops-management.html?emodal=/us/en/greenlake/fragments/modal-fragment/uc-modal-form.fragment.html)
of Compute Ops Management to experience its full capabilities.


[↑ Back to Top](#)

