---
layout: post
title: "HPE ProLiant Security Experience"
image: /assets/images/HOLs/Proliant-Security/banner.png
post_end_promo: <i><b>Continue your journey with more HPE Compute Technical Enablement Hands-on Labs for infrastructure, security, technologies, and solutions.</b></i>
excerpt: Explore HPE ProLiant Gen12 security with iLO 7 embedded management, GreenLake onboarding, firmware verification, ACME certificate automation, and Secure Gateway deployment in this hands-on lab experience.
---

Living Lab experience

## Overview
HPE ProLiant Gen12 servers are designed with a security‑first approach and deep remote manageability. In this lab, you will:

- Use **Omnissa Horizon** to access the lab environment.
- Explore **HPE iLO 7** for embedded server management.
- Onboard servers to **HPE GreenLake / Compute Ops Management (COM)**.
- Apply security best practices, verify firmware, and manage certificates (ACME).
- Deploy and use the **COM Secure Gateway**. 

> **Note:** Screenshots from the original PDF are replaced with concise step prompts (e.g., *“Screenshot: iLO Dashboard”*). When publishing on GitHub Pages, you can later add images in the indicated callouts.


# HPE ProLiant Security Experience

HPE is accelerating time to value with our robust portfolio of IT
infrastructure management solutions. These tools are certified and
optimized for managing HPE hardware and solutions. HPE ProLiant Gen12
servers are designed from the ground up with security, remote
manageability, and lifecycle management in mind.

<img src="/assets/images/HOLs/Proliant-Security/image2.png"
style="width:7.65278in;height:3.43542in" />

[![]( {{ site.baseurl }}/assets/images/HOLs/Proliant-Security/image2.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/Proliant-Security/image2.png){: data-lightbox="gallery"}


Here is an overview of our Compute management portfolio.

- HPE Compute Ops Management delivers unified operations as-a-service
  from edge to cloud. In this HOL you will work with this technology.

- HPE iLO7 is embedded server management that enables you to securely
  configure, monitor, and update your HPE servers from anywhere. Again,
  in this HOL you will work with this technology too.

- HPE OneView is integrated IT infrastructure management software that
  automates IT operations and simplifies infrastructure lifecycle
  management across compute, storage, and networking. It is an onsite
  management strategy and is not the focus of this workshop.

This HOL takes a technical approach to how these tools can be used to
manage HPE ProLiant Servers with a strong focus around Security.

# Accessing the HPE Compute BU Enablement Environment

We will use Omnissa Horizon to access the lab environment and view
server details in HPE Compute Ops Management.

Follow these steps:

1.  **Open the Horizon Access Portal**\
    Using your Chrome browser, navigate to the appropriate URL based on
    your network location:

    - **External to HPE** (not connected to HPE VPN):\
      <https://labs.compute.cloud.hpe.com>

    - **Internal to HPE** (or connected to HPE VPN):\
      <https://techenablement.hpecorp.net>

2.  **Launch the Web Client**\
    On the Horizon login screen, click the **Omnissa Horizon Web
    Client** button.

> <img src="/assets/images/HOLs/Proliant-Security/image3.png"
> style="width:3.32439in;height:4.18915in"
> alt="A screenshot of a phone AI-generated content may be incorrect." />

3.  Enter the username and password supplied by your instructor and
    click the **Login** button.

    - **Username**:\
      [**HOL02-T01@labs.compute.cloud.hpe.com**](mailto:HOL02-T01@labs.compute.cloud.hpe.com)
      through **HOL02-T25@labs.compute.cloud.hpe.com**, (depends on your
      team assignment)

    - **Password**:\
      Supplied by instructor

> <img src="/assets/images/HOLs/Proliant-Security/image4.png"
> style="width:4.22658in;height:5.32281in" />

4.  **Click** on the **graphic** that represents your Lab environment.

> <img src="/assets/images/HOLs/Proliant-Security/image5.png"
> style="width:6.18314in;height:2.08835in" />

5.  When you are finished with the lab, please use the logout button.

> <img src="/assets/images/HOLs/Proliant-Security/image6.png"
> style="width:6.2167in;height:2.01056in" />

You are now in a VPN-enabled Chrome browser session. For these labs to
function properly, you must remain within this browser session. You have
a secure connection to our remote lab in Houston, but it does not
operate like a traditional VPN. Only the applications you launch from
this browser session are connected to the remote environment.

This concludes this portion of the lab.

# Embedded Server Management with HPE iLO7

HPE Integrated Lights-Out (iLO) is an embedded server management
technology from HPE that provides out-of-band management capabilities.
Key features of HPE iLO7 include a virtual KVM console, virtual media,
power management, console record-and-replay, and comprehensive remote
console functionality. It enables administrators to manage servers
remotely, regardless of the state of the operating system or the
condition of the server itself, if power is available to the system.
This remote management is facilitated through a dedicated HPE iLO7 port
on the server, but you can connect via the HPE iLO7’s ethernet port as
well.

This portion of the lab assumes the server has power, HPE iLO7’s
ethernet port is connected to a management network switch and the
default password information has been gathered from the toe-tag on the
front of the server.

<img src="/assets/images/HOLs/Proliant-Security/image7.jpeg"
style="width:4.28478in;height:2.51527in"
alt="A barcode with a red circle AI-generated content may be incorrect." />

In this lab environment, a DHCP server assigns IP addresses to known
hosts using DHCP reservations. This ensures that the lab unit you access
receives the same IP address each time it boots after the lab is reset.
Refer to the table below for your team’s name and number, as well as the
default Administrator credentials for the HPE iLO7 you will be using. Be
sure to also record your server’s serial number.

<table style="width:83%;">
<colgroup>
<col style="width: 16%" />
<col style="width: 30%" />
<col style="width: 15%" />
<col style="width: 19%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><blockquote>
<p><strong>Team Name<br />
&amp; Number</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>HPE iLO7<br />
FQDN</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>Username</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>Default Factory Password</strong></p>
</blockquote></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;">Team-01</td>
<td style="text-align: center;">holgen1201-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-02</td>
<td style="text-align: center;">holgen1202-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-03</td>
<td style="text-align: center;">holgen1203-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-04</td>
<td style="text-align: center;">holgen1204-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-05</td>
<td style="text-align: center;">holgen1205-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-06</td>
<td style="text-align: center;">holgen1206-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-07</td>
<td style="text-align: center;">holgen1207-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-08</td>
<td style="text-align: center;">holgen1208-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-09</td>
<td style="text-align: center;">holgen1209-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-10</td>
<td style="text-align: center;">holgen1210-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-11</td>
<td style="text-align: center;">holgen1211-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-12</td>
<td style="text-align: center;">holgen1212-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-13</td>
<td style="text-align: center;">holgen1213-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-14</td>
<td style="text-align: center;">holgen1214-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-15</td>
<td style="text-align: center;">holgen1215-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-16</td>
<td style="text-align: center;">holgen1216-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-17</td>
<td style="text-align: center;">holgen1217-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-18</td>
<td style="text-align: center;">holgen1218-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-19</td>
<td style="text-align: center;">holgen1219-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-20</td>
<td style="text-align: center;">holgen1220-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-21</td>
<td style="text-align: center;">holgen1221-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-22</td>
<td style="text-align: center;">holgen1222-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-23</td>
<td style="text-align: center;">holgen1223-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-24</td>
<td style="text-align: center;">holgen1224-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;">Team-25</td>
<td style="text-align: center;">holgen1225-ilo.hol.enablement.local</td>
<td style="text-align: center;"><blockquote>
<p>Administrator</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
</tbody>
</table>

1.  Use your Horizon enabled Chrome browser session that you connected
    with in the previous section. Remember that for these labs to work,
    you will need to stay within the context of this browser session.

2.  Using the table above, open the **Chrome browser** and **type in the
    FQDN** of your assigned server HPE iLO7.\
    **Note**: **DO NOT USE IE or EDGE.**

> <img src="/assets/images/HOLs/Proliant-Security/image8.png"
> style="width:4.17635in;height:4.18019in" />

3.  Now using the URL for your assigned HPE iLO7, type that into the
    **navigation bar**.

4.  If presented with a message saying, “**Your connection is not
    private”**, this is the self-signed SSL certificate presented to you
    for the HPE iLO7 you are about to use. Click **Advanced**.

> <img src="/assets/images/HOLs/Proliant-Security/image9.png"
> style="width:5.58713in;height:3.33098in" />

5.  On the newly displayed prompt, click on the **Proceed to
    holgen12XX-ilo.hol.enablement.local** to continue to the HPE iLO7
    login screen.

> <img src="/assets/images/HOLs/Proliant-Security/image10.png"
> style="width:3.73253in;height:3.26173in" />

6.  Now enter **Administrator** and the **factory password from the
    table above**, into the Local login name and Password fields.

7.  Click **Log In**.

<img src="/assets/images/HOLs/Proliant-Security/image11.png"
style="width:5.96662in;height:2.61676in" />

8.  Administrators are presented with valuable information about their
    server on the Dashboard. The Host Overview and Host Health cards
    immediately provide relevant information as to the status of the
    managed system. Notice that the HP Compute Ops Management section
    shows that the Connection Status has not been enabled.

<img src="/assets/images/HOLs/Proliant-Security/image12.png"
style="width:6.00952in;height:4.1265in" />

> This concludes this portion of the lab.

# Managing Local Users

> One of the initial tasks for administrators when deploying systems in
> their environment is to ensure compliance with established corporate
> standards. This typically includes provisioning local user accounts
> within HPE iLO7 and configuring HPE iLO7 network settings, such as
> assigning static IP addresses. Administrators may also need to modify
> additional HPE iLO7 parameters that ship with factory‑default values
> to align the baseboard management controller with organizational
> security and operational requirements.

1.  From the Dashboard screen.

> <img src="/assets/images/HOLs/Proliant-Security/image12.png"
> style="width:6.71729in;height:4.6125in" />

2.  In the left-hand navigation pane, click **iLO Settings**.

<img src="/assets/images/HOLs/Proliant-Security/image13.png"
style="width:6.35368in;height:3.41553in" />

3.  Now click on **User
    Management**.<img src="/assets/images/HOLs/Proliant-Security/image14.png"
    style="width:6.29677in;height:2.56328in" />

<!-- -->

6.  Click on **Users**.

> <img src="/assets/images/HOLs/Proliant-Security/image15.png"
> style="width:6.61748in;height:2.89199in" />

7.  For the purposes of this lab, we will **leave the Administrator
    account with the default toe-tag password** and set up another
    administrative user account to access the HPE iLO7.

8.  In the upper right card of the Local Users frame, click **+ Add**
    and enter the following settings to create your new user account.

<table style="width:60%;">
<colgroup>
<col style="width: 28%" />
<col style="width: 31%" />
</colgroup>
<thead>
<tr>
<th><blockquote>
<p>User Information</p>
</blockquote></th>
<th></th>
</tr>
</thead>
<tbody>
<tr>
<td><blockquote>
<p><strong>Login Name</strong></p>
</blockquote></td>
<td><blockquote>
<p>HPE_Admin</p>
</blockquote></td>
</tr>
<tr>
<td><blockquote>
<p><strong>User Name</strong></p>
</blockquote></td>
<td><blockquote>
<p>HPE Admin</p>
</blockquote></td>
</tr>
<tr>
<td><blockquote>
<p><strong>New Password</strong></p>
</blockquote></td>
<td><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td><blockquote>
<p><strong>Confirm Password</strong></p>
</blockquote></td>
<td><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td><blockquote>
<p>User Permissions</p>
</blockquote></td>
<td></td>
</tr>
<tr>
<td><blockquote>
<p><strong>Role</strong></p>
</blockquote></td>
<td><blockquote>
<p>Custom</p>
</blockquote></td>
</tr>
<tr>
<td><blockquote>
<p><strong>Privileges</strong></p>
</blockquote></td>
<td><blockquote>
<p>Select All</p>
</blockquote></td>
</tr>
</tbody>
</table>

9.  Click on **Add** to save the new account.

> <img src="/assets/images/HOLs/Proliant-Security/image16.png"
> style="width:5.0686in;height:4.52437in" />

10. You should now see that the new user has been added to the Local
    Users list.

> <img src="/assets/images/HOLs/Proliant-Security/image17.png"
> style="width:6.5099in;height:3.02988in" />

11. **Logout** and then **log back in** with your newly created user.

12. Take Note – You have just created a fully privileged Administrator
    account with a very simple password. We will circle back on this in
    a later part of the Lab.

13. Return to the **User Management** section in iLO Settings and Click
    on **Directory Groups**.

<img src="/assets/images/HOLs/Proliant-Security/image18.png"
style="width:7.07419in;height:3.02418in" />

The Directory Groups section is where administrators can enter up to six
directory groups using Kerberos authentication and schema-free directory
integration.

<img src="/assets/images/HOLs/Proliant-Security/image19.png"
style="width:7.08338in;height:1.89233in" />

More information can be found in the HPE iLO7 User Guide at the HPE
Support Center.
<https://support.hpe.com/hpesc/public/docDisplay?docId=sd00005342en_us&docLocale=en_US> -
Search “Kerberos authentication” as an example and you will see the
process detailed in one of the search results.

This concludes this portion of the lab.

# Firmware Verification

The Firmware Verification feature allows you to run an on-demand scan or
implement scheduled scans. To respond to detected issues, you can
configure HPE iLO7 to:

- Log the results.

- Log the results and initiate a repair action that uses a recovery
  install set.

Depending on the scan results, information is logged in the Active
Health System Log and the Integrated Management Log. The following
firmware types are supported:

- HPE iLO7 Firmware

- System ROM (BIOS)

- System Programmable Logic Device (CPLD)

When a firmware verification scan is in progress, HPE recommends not
installing firmware updates or uploading firmware to the iLO Repository
during this process. If an invalid iLO or System ROM (BIOS) firmware
file is detected, the invalid file is saved to a quarantine card in the
HPE iLO7’s Repository. You can download the invalid file to investigate
its type and origin. Quarantined images are not displayed on the iLO
Repository page, and you cannot select them when you use the Flash
Firmware feature.

1.  Click on the **Firmware** link to explore the HPE iLO7 capability to
    manually scan the system firmware and to check the validity and
    health of the firmware components.

2.  Click on the **Firmware Verification** card.

> <img src="/assets/images/HOLs/Proliant-Security/image20.png"
> style="width:7.00619in;height:2.63972in" />

3.  This screen may show results of previous scans.

> <img src="/assets/images/HOLs/Proliant-Security/image21.png"
> style="width:6.81606in;height:3.21443in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

4.  Click **Settings** and **Enable Background Scan** with an Integrity
    Failure Action of **Log Only**. The default setting is 7 days, but
    for this lab, change the **Scan Interval** to **1**.

5.  Click **Update** to save the scan settings. You should see that the
    scan settings have been saved successfully.

> <img src="/assets/images/HOLs/Proliant-Security/image22.png"
> style="width:2.88801in;height:3.23008in" />

6.  Click **Run Scan** to trigger a runtime firmware verification of the
    component firmware, to ensure validity. This scan is performed by
    the HPE iLO7 processor and does not consume clock cycles from the
    server’s CPUs. This action can be called from the API or a language
    binding like HPE iLO7 REST Utility or PowerShell.

> <img src="/assets/images/HOLs/Proliant-Security/image23.png"
> style="width:6.97767in;height:3.59901in" />

7.  Return to the HPE iLO7 **Dashboard** screen.

This concludes this portion of the lab.

# Applying a Web Proxy configuration

> HPE iLO7 enables organizations to customize security settings within
> the HPE iLO7, to meet their specific security and compliance
> requirements. This may include uploading a trusted SSL security
> certificate, integrating with directory services, enabling a login
> security banner, and modifying various other security-related
> parameters. For this exercise, we will configure a proxy server for
> HPE iLO7 to use within the environment.

1.  Login to your team assigned HPE iLO7 with the **HPE_Admin** account
    you created earlier.

2.  In the left-hand navigation pane click **Security**.

3.  Then click the **Access** wheel under **Quick Links**.

> <img src="/assets/images/HOLs/Proliant-Security/image24.png"
> style="width:5.90829in;height:2.56222in" />

4.  In the far-right card for the **Web Proxy**, click the **edit**
    (pencil) icon.

> <img src="/assets/images/HOLs/Proliant-Security/image25.png"
> style="width:5.9272in;height:2.75384in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

5.  Click the checkbox for Web Proxy

6.  Now enter **hpeproxy.its.hpecorp.net** in the Web Proxy Server field

7.  Enter **443** in the Web Proxy Port fields.

8.  Leave the other settings blank.

9.  Click **Update** to save the changes you entered.

> <img src="/assets/images/HOLs/Proliant-Security/image26.png"
> style="width:2.62795in;height:3.40428in" />

This concludes this portion of the lab.

# Connecting to HPE Compute Ops Management

The HPE GreenLake Cloud Platform enables IT administrators to connect
and manage devices and cloud services under a unified service presented
by HPE. HPE compute, storage, and networking devices may be centrally
managed whether on premises, at the edge, co-located, or on the other
side of the world.

This single HPE GreenLake dashboard allows administrators to launch
domain specific applications like Compute Ops Management, Aruba Central,
Data Services, along with tools to manage governance like OpsRamp and
gain insights in the HPE Sustainability Insight Center.

> <img src="/assets/images/HOLs/Proliant-Security/image27.png"
> style="width:7.36876in;height:2.67335in"
> alt="A screenshot of a computer Description automatically generated" />

For this exercise, we are going to focus on the onboarding of our
devices into the GreenLake platform so that they may be managed by HPE
Compute Ops Management.

You will need to login to the GreenLake environment. For this portion of
the lab, you will use a different username and password from what you
used to start the labs. Your assignment is based on your team number and
is in the table below.

Once you have located your username and password, proceed to Step 1 of
this lab.

1.  Open a new tab and connect to HPE GreenLake at
    **https://common.cloud.hpe.com/** and then enter your assigned user
    information from the following table as the Username. Your
    instructor will provide a password if it is different from the table
    below.

<table style="width:56%;">
<colgroup>
<col style="width: 13%" />
<col style="width: 25%" />
<col style="width: 17%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><blockquote>
<p><strong>Team Number</strong></p>
</blockquote></th>
<th><blockquote>
<p><strong>GreenLake Username</strong></p>
</blockquote></th>
<th style="text-align: center;"><strong>User password</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;">Team-01</td>
<td><a
href="mailto:comholuser%2B1@gmail.com">comholuser+1@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-02</td>
<td><a
href="mailto:comholuser%2B2@gmail.com">comholuser+2@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-03</td>
<td><a
href="mailto:comholuser%2B3@gmail.com">comholuser+3@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-04</td>
<td><a
href="mailto:comholuser%2B4@gmail.com">comholuser+4@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-05</td>
<td><a
href="mailto:comholuser%2B5@gmail.com">comholuser+5@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-06</td>
<td><a
href="mailto:comholuser%2B6@gmail.com">comholuser+6@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-07</td>
<td><a
href="mailto:comholuser%2B7@gmail.com">comholuser+7@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-08</td>
<td><a
href="mailto:comholuser%2B8@gmail.com">comholuser+8@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-09</td>
<td><a
href="mailto:comholuser%2B9@gmail.com">comholuser+9@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-10</td>
<td><a
href="mailto:comholuser%2B10@gmail.com">comholuser+10@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-11</td>
<td><a
href="mailto:comholuser%2B11@gmail.com">comholuser+11@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-12</td>
<td><a
href="mailto:comholuser%2B12@gmail.com">comholuser+12@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-13</td>
<td><a
href="mailto:comholuser%2B13@gmail.com">comholuser+13@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-14</td>
<td><a
href="mailto:comholuser%2B14@gmail.com">comholuser+14@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-15</td>
<td><a
href="mailto:comholuser%2B15@gmail.com">comholuser+15@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-16</td>
<td><a
href="mailto:comholuser%2B16@gmail.com">comholuser+16@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-17</td>
<td><a
href="mailto:comholuser%2B17@gmail.com">comholuser+17@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-18</td>
<td><a
href="mailto:comholuser%2B18@gmail.com">comholuser+18@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-19</td>
<td><a
href="mailto:comholuser%2B19@gmail.com">comholuser+19@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-20</td>
<td><a
href="mailto:comholuser%2B20@gmail.com">comholuser+20@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-21</td>
<td><a
href="mailto:comholuser%2B21@gmail.com">comholuser+21@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-22</td>
<td><a
href="mailto:comholuser%2B22@gmail.com">comholuser+22@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-23</td>
<td><a
href="mailto:comholuser%2B23@gmail.com">comholuser+23@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-24</td>
<td><a
href="mailto:comholuser%2B24@gmail.com">comholuser+24@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
<tr>
<td style="text-align: center;">Team-25</td>
<td><a
href="mailto:comholuser%2B25@gmail.com">comholuser+25@gmail.com</a></td>
<td style="text-align: center;">TechPr02026!</td>
</tr>
</tbody>
</table>

2.  Click **Next** to be prompted for a password.

3.  Type in the password of **TechPr02026!** (or the password supplied
    by your instructor) and press the **Enter** key or click **Sign
    In**.

4.  If there’s a short advertising message, enjoy it and then close the
    pop-up window.

5.  When presented with a choice of workspaces, choose **COM Security
    Lab XX** (where **XX** is your Team Number) and **Go to Workspace**.

> <img src="/assets/images/HOLs/Proliant-Security/image28.png"
> style="width:6.41919in;height:3.57191in" />

6.  You are now on the HPE GreenLake Cloud Platform homepage. You can
    see your workspace choice, to the right of the HPE GreenLake logo.
    Don’t click on the Launch button for Compute Ops Management just
    yet.

> <img src="/assets/images/HOLs/Proliant-Security/image27.png"
> style="width:6.42442in;height:2.27076in"
> alt="A screenshot of a computer Description automatically generated" />

This concludes this section of the lab.

# Secure Login Options for Enterprise IT Administrators

In the previous section of this lab, we were able to login to our HPE
Compute Ops Management Workspace with an email address and somewhat
complex password. In today’s world, this is no longer secure enough to
meet Industry Security Standards and additional safeguards should be
configured.

Our HPE GreenLake Cloud Platform supports Multi-Factor Authentication as
well as SAML SSO which combining both together, can go a long way to
ensuring any bad actors do not access your IT Estate, especially through
HPE Compute Ops Management.

For this Lab, we will just walk you through the various locations in HPE
GreenLake Cloud Platform where this can be configured, but we will not
actually set it up at this time.

1.  From the **Quick Links** on the right-hand side of the GreenLake
    Home Page, click **Manage Workspace**.

> <img src="/assets/images/HOLs/Proliant-Security/image29.png"
> style="width:4.32908in;height:1.88406in"
> alt="A screenshot of a computer Description automatically generated" />

2.  Select the **Workspace Details** card**.**

> <img src="/assets/images/HOLs/Proliant-Security/image30.png"
> style="width:6.44443in;height:2.88011in" />

3.  In the Actions pull down, navigate to the **Manage MFA** list.

> <img src="/assets/images/HOLs/Proliant-Security/image31.png"
> style="width:6.50156in;height:2.53514in" />

4.  This is where Multifactor Authentication can be configured for all
    Users within the Workspace. Currently supported methods are Okta
    Verify, Security Key or Biometric Authenticator and Google
    Authenticator.

> <img src="/assets/images/HOLs/Proliant-Security/image32.png"
> style="width:2.5309in;height:4.15285in" />
>
> **Note: For the purpose of this lab, we will NOT be configuring MFA on
> these Workspaces.**

When enabling Multifactor Authentication (MFA), you significantly
enhance the security of your account when signing in to HPE GreenLake.
By requiring multiple forms of verification, such as a password and a
one-time code sent to your mobile device, MFA adds an extra layer of
protection against unauthorized access. This reduces the risk of account
compromise, even if your password is stolen or guessed. Implementing MFA
is a crucial step in safeguarding your sensitive data and ensuring
secure access to HPE GreenLake services.

**Note**: MFA can also be configured at the user level from the **HPE
user account details**. However, please do **NOT** enable it for this
lab.\
\
<img src="/assets/images/HOLs/Proliant-Security/image33.png"
style="width:2.8336in;height:1.82648in"
alt="A screenshot of a computer AI-generated content may be incorrect." />

This concludes this section of the lab.

# Establishing a connection from HPE iLO7 to HPE GreenLake

For our lab purposes, the HPE GreenLake Workspace company in this
environment is called *COM Security Lab XX*.

The connection between HPE iLO7 and HPE GreenLake is initiated by the
HPE iLO7 for security purposes. During the onboarding process, an
HPE-issued client certificate is used by the HPE iLO7 to connect to HPE
Compute Ops Management. The HPE CA Certificate uses SHA256 with a key
size of EC 384 bits and is transmitted over a Mutual Transport Layer
Security (mTLS) connection from the HPE iLO7 to HPE GreenLake and
Compute Ops Management over HTTPS (port 443). In a typical TLS setup,
only the server is authenticated by the client. In mTLS, both the client
and the server authenticate each other, providing enhanced security by
ensuring that both parties are authenticated before establishing a
secure communication channel.

For more information regarding the security protocols and firewall
requirements, consult the [HPE Compute Ops Management security
guide](https://www.hpe.com/psnow/doc/a50004539enw).

To initiate the connection from HPE iLO7 to the HPE Compute Ops
Management, we first need to obtain an Activation Key.

1.  Click on the **HPE GreenLake logo** in the browser to return to the
    main menu.

2.  From the HPE GreenLake Recent Services section, choose the
    **Launch** button in the **Compute Ops Management** card to connect
    to HPE Compute Ops Management main menu.

<img src="/assets/images/HOLs/Proliant-Security/image27.png"
style="width:6.59905in;height:2.3941in"
alt="A screenshot of a computer Description automatically generated" />

3.  You are at the Compute Ops Management Overview page.

> <img src="/assets/images/HOLs/Proliant-Security/image34.png"
> style="width:6.8324in;height:2.84022in" />

4.  Click on the **Servers** tab across the top of the page.

> <img src="/assets/images/HOLs/Proliant-Security/image35.png"
> style="width:6.91336in;height:0.65056in" />

5.  Click the **Add server** button.

> <img src="/assets/images/HOLs/Proliant-Security/image36.png"
> style="width:6.88267in;height:0.9181in" />

6.  At this time, we will select **Direct connect** as our Server
    Connection type**.** Click **Next**.

> <img src="/assets/images/HOLs/Proliant-Security/image37.png"
> style="width:6.51599in;height:3.737in" />

7.  Here we can select how long our Activation Key will be valid for and
    which Subscription Key we will apply. For this lab, let’s choose
    **30 minutes** and **Use existing subscription key.** In the Select
    existing key (Select a subscription key) box, **choose the available
    key** and click **Next**.

> <img src="/assets/images/HOLs/Proliant-Security/image38.png"
> style="width:4.80271in;height:3.3012in" />

8.  Once you have reviewed the details, click **Finish and generate
    activation key.**

> <img src="/assets/images/HOLs/Proliant-Security/image39.png"
> style="width:6.12919in;height:3.439in" />

9.  We will now take note of our Activation Key, so we can use it in our
    HPE iLO7 to connect to Compute Ops Management. Click the **copy
    icon** and then close this pop up.

> <img src="/assets/images/HOLs/Proliant-Security/image40.png"
> style="width:6.10581in;height:3.96355in" />

10. Return to the Web Browser Tab, which is connected to your assigned
    Server’s HPE iLO7, then navigate to **Dashboard** on the left-hand
    side of your screen, then click on **HPE Compute Ops Management**
    card.

> <img src="/assets/images/HOLs/Proliant-Security/image41.png"
> style="width:6.56141in;height:2.93001in" />

11. Click **Enable** to enable the Compute Ops Management connection.

> <img src="/assets/images/HOLs/Proliant-Security/image42.png"
> style="width:6.46055in;height:4.30371in" />

12. Then click on **Enter Activation Key.**

> <img src="/assets/images/HOLs/Proliant-Security/image43.png"
> style="width:6.43445in;height:2.99768in" />

13. Then paste the **Activation Key** you copied previously and hit
    **Save**.

> <img src="/assets/images/HOLs/Proliant-Security/image44.png"
> style="width:6.42556in;height:4.25037in" />

14. After a few seconds, it should now show you as **Connected** with
    your **Workspace ID** and **Connection Type.**

> <img src="/assets/images/HOLs/Proliant-Security/image45.png"
> style="width:6.21969in;height:3.21651in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

This concludes this section of the lab.

# Securing your Server Fleet with HPE Compute Ops Management

HPE Compute Ops Management provides the core platform for delivering HPE
compute services, enabling a standardized, self‑service, and real‑time
operational model for IT administrators across the datacenter and
edge‑to‑cloud infrastructures. It delivers a unified control plane that
consolidates compute management into a single cloud‑hosted interface,
reducing operational overhead and ensuring continuous access to newly
released features, service enhancements, and security updates.

In this portion of the lab, we will focus on configuring Server Groups
and applying Server Settings. This is the security configuration and
lifecycle management aspect of your assigned server. We will create
settings for the systems and place those settings into Groups. This
ensures consistency across all servers assigned to those groups.

Return to your HOL Horizon Browser session.

1.  From the HPE Compute Ops Management main menu. Select the **Manage**
    option.

> <img src="/assets/images/HOLs/Proliant-Security/image46.png"
> style="width:6.575in;height:2.95577in" />

2.  Now pick the card for **Settings**.

> <img src="/assets/images/HOLs/Proliant-Security/image47.png"
> style="width:6.57107in;height:4.0929in" />

3.  Take notice of some of the settings in the Name column and the Type
    column associated with each setting. HPE provides some pre-defined
    settings based on HPE ProLiant UEFI Workload Profiles. These
    settings are popular with administrators using HPE best practices
    for workloads like virtualization.

> <img src="/assets/images/HOLs/Proliant-Security/image48.png"
> style="width:4.4399in;height:3.01889in"
> alt="A screenshot of a computer program AI-generated content may be incorrect." />

4.  Now click on **Create setting**.

> <img src="/assets/images/HOLs/Proliant-Security/image49.png"
> style="width:5.8587in;height:3.70236in"
> alt="A screenshot of a computer Description automatically generated" />

5.  On the Setting details page, **enter your Team name with -Firmware**
    appended to it. Also **enter your team’s name as a Description**.
    Finally pick the **Category of Firmware** from the pull-down box and
    click **Next** to continue.

> <img src="/assets/images/HOLs/Proliant-Security/image50.png"
> style="width:5.01503in;height:3.80542in"
> alt="A screenshot of a computer Description automatically generated" />

6.  Now in step two of the process, use the pull-down menu in the
    **Gen12 baseline** to select the latest base SPP available.

> <img src="/assets/images/HOLs/Proliant-Security/image51.png"
> style="width:3.4607in;height:3.01006in" />

7.  Now select **Finish and create server setting**.

> <img src="/assets/images/HOLs/Proliant-Security/image52.png"
> style="width:3.73785in;height:3.17742in" />

8.  You should see the setting for firmware successfully created. Click
    on **Close** to finish the process.

> <img src="/assets/images/HOLs/Proliant-Security/image53.png"
> style="width:4.02693in;height:2.0265in" />

9.  The next two settings we will look to add to our Server Group in the
    next section of the Lab. The first is a **HPE Pre-Defined
    BIOS/Workload profile.** Click on **General Throughput Compute** as
    an example to find out more.

> <img src="/assets/images/HOLs/Proliant-Security/image54.png"
> style="width:4.21505in;height:2.88398in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

10. The second setting is the very important **iLO settings enabled for
    security** setting can be used to apply HPE recommended HPE iLO7
    security settings, to reduce the overall security risk of a server:

> <img src="/assets/images/HOLs/Proliant-Security/image55.png"
> style="width:4.65365in;height:4.81751in" />

This concludes this section of the lab.

# Creating server groups and associating server settings

Server groups allow you to organize servers based on specific criteria
(e.g., location, function, or role). When you create or edit a server
group, you can apply server settings and server group policies. Servers
directly managed by HPE Compute Ops Management can be added to server
groups where these settings will be applied to all the systems in the
group.

1.  Now return to **Manage** in HPE Compute Ops Management and this time
    select the **Groups** card.

> <img src="/assets/images/HOLs/Proliant-Security/image47.png"
> style="width:6.1797in;height:3.84914in" />

2.  At the **Groups** page, click on **Create a group.**

> <img src="/assets/images/HOLs/Proliant-Security/image56.png"
> style="width:6.22597in;height:1.78813in" />

3.  In the Group details section, enter your **Team name** in the
    **Name** field and then again for the **Description** field. Select
    **Server** as the **type**, then click **Next** to continue in the
    wizard.

> <img src="/assets/images/HOLs/Proliant-Security/image57.png"
> style="width:4.90263in;height:2.91844in"
> alt="A screenshot of a computer Description automatically generated" />

4.  In the next screen of the wizard, **use the pulldown menu** to
    **choose** your previously created **Firmware setting**.

> <img src="/assets/images/HOLs/Proliant-Security/image58.png"
> style="width:5.76436in;height:4.21499in" />

5.  In the section, to **choose a BIOS server setting**, choose a
    setting that meets the needs of the customer.

> <img src="/assets/images/HOLs/Proliant-Security/image59.png"
> style="width:3.3595in;height:4.05632in" />

6.  In the section **Choose an iLO server setting** box, select **iLO
    settings enabled for security.**

> <img src="/assets/images/HOLs/Proliant-Security/image60.png"
> style="width:3.40914in;height:4.24918in" />

7.  Leave the rest of the options in this initial section at their
    default values, and then select **Next** to advance in the wizard.

8.  Normally we would enable the Auto apply firmware baseline, but for
    the purpose of this Lab, we will leave it **disabled**. Click
    **Next** to continue.

> <img src="/assets/images/HOLs/Proliant-Security/image61.png"
> style="width:5.20135in;height:4.40163in" />

9.  **Enable** the Auto apply BIOS settings policy and then select
    **Next**.

> <img src="/assets/images/HOLs/Proliant-Security/image62.png"
> style="width:5.41754in;height:3.55954in" />

10. For **auto applying iLO Setting**, leave this **disabled** for now
    so we can **manually apply this later** in the Lab, click **Next**
    to continue.

> <img src="/assets/images/HOLs/Proliant-Security/image63.png"
> style="width:5.35894in;height:3.2037in" />

11. For the question of how we are adding our servers to the group, we
    are going to setup the group for manual addition of servers to the
    group. Select **Next** to move on.

> <img src="/assets/images/HOLs/Proliant-Security/image64.png"
> style="width:5.1989in;height:2.35175in" />

12. We are not going to establish an approval process in this HOL but it
    is a best practice in real life. Select **Next** to move to the
    finish.

> <img src="/assets/images/HOLs/Proliant-Security/image65.png"
> style="width:5.24124in;height:2.28103in" />

13. At the last step, review the card you have settings defined and then
    select **Finish and create group**.

> <img src="/assets/images/HOLs/Proliant-Security/image66.png"
> style="width:5.65274in;height:3.3783in" />

14. The group should be created, and you can click on **Close** to
    finish the process.

> <img src="/assets/images/HOLs/Proliant-Security/image67.png"
> style="width:5.68921in;height:2.86835in"
> alt="A screenshot of a computer Description automatically generated" />

15. Now within the Groups section, you can select your Server group.
    Click the **Hyperlink** for your **Team Name**.

> <img src="/assets/images/HOLs/Proliant-Security/image68.png"
> style="width:5.94483in;height:2.20854in" />

16. Scroll through the details of your server group and take notes of
    the Compliance section. These are the details of what you just
    defined at the group level. This will help administrators understand
    if any configuration drift occurs in the future.

> <img src="/assets/images/HOLs/Proliant-Security/image69.png"
> style="width:4.56138in;height:4.08025in" />

17. Scroll back up to the top of the page and click on the **Actions**
    button (to the right of the frame) to reveal how functions are
    performed on the entire group.

18. Click **Add servers**.

19. **Select your server** by clicking the **checkbox** next to its name
    then click **Continue** to proceed to the summary.

> <img src="/assets/images/HOLs/Proliant-Security/image70.png"
> style="width:4.69418in;height:2.35165in" />

20. Review the actions that will take place on your server before
    clicking **Add 1 server.**

> <img src="/assets/images/HOLs/Proliant-Security/image71.png"
> style="width:4.77444in;height:2.46602in" />

21. Click **Close** to return to your team’s server group.

> <img src="/assets/images/HOLs/Proliant-Security/image72.png"
> style="width:4.72301in;height:2.32356in"
> alt="A screenshot of a computer Description automatically generated" />

22. The settings designated to automatically apply to servers as they
    are added to the group will be applied. **Note the Recent group
    activity** pane and observe the actions as the settings are applied
    to your server.

> <img src="/assets/images/HOLs/Proliant-Security/image73.png"
> style="width:6.04468in;height:2.88576in"
> alt="A screenshot of a computer Description automatically generated" />

This concludes this section of the lab.

# Advanced Security settings for HPE iLO7

HPE iLO (Integrated Lights-Out) provides robust security features to
mitigate risks in networked environments. Features like Trusted Platform
Module (TPM) or TM Status, Local User Account Controls and Directory
Group Account Controls that support Kerberos authentication or
schema-free directory integration. You can set server name and FQDN/IP
addresses yourself but consider leaving those values blank to let the
host OS assign them. There are Secure Shell (SSH) Key Settings that can
be managed for secure communication with the HPE iLO7 management
processor itself.

In this lab we will look at security parameters like in Network Settings
where we can enable/disable various services (e.g., SSH, SNMP, Virtual
Media.) We will configure <u>anonymous data</u> and IPMI/DCMI over LAN.
Idle Connection Timeout values can be set.

While security is crucial, striking a balance between protection and
usability is essential. Implement settings based on your organization’s
needs.

Finally, the HPE iLO7 Security Dashboard provides real-time insights to
monitor and manage security settings proactively.

1.  Navigate back to your assigned Servers **HPE iLO 7**.

2.  From the **HPE iLO7 Dashboard** page, click on **Security** link.

> <img src="/assets/images/HOLs/Proliant-Security/image74.png"
> style="width:6.70955in;height:3.07531in" />

3.  From the Security page, click on the **Overview** card.

> <img src="/assets/images/HOLs/Proliant-Security/image75.png"
> style="width:6.31278in;height:3.1203in" />

4.  Now review the Security parameters.

> <img src="/assets/images/HOLs/Proliant-Security/image76.png"
> style="width:5.65957in;height:4.58723in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

5.  Switch between browser tabs to return to Compute Ops Management.
    From your Server page in Compute Ops Management, the HPE iLO7
    Security Status shows at risk. Click on the **Details** link.

> <img src="/assets/images/HOLs/Proliant-Security/image77.png"
> style="width:5.58371in;height:3.99773in" />

6.  What are some of the security items that need to be addressed?
    \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

> <img src="/assets/images/HOLs/Proliant-Security/image78.png"
> style="width:6.76842in;height:2.93094in" />

7.  **Cancel** out of the iLO security status screen.

8.  Return to the HPE iLO7 **Security dashboard** screen**.** Select the
    option for **Secure Boot** and toggle on the ability to **ignore
    risk**. This is not a best practice for the “real world”, but we are
    demonstrating features in HPE iLO7 and COM.

> <img src="/assets/images/HOLs/Proliant-Security/image79.png"
> style="width:4.08839in;height:5.15462in" />
>
> Note: This task can be easily automated using the **Enable-HPECOM HPE
> iLO7IgnoreRiskSetting** cmdlet from the
> [**HPECOMCmdlets**](https://www.powershellgallery.com/packages/HPECOMCmdlets/1.0.11)
> PowerShell module.

9.  Click **Configure** to make the change

10. Back at the COM screens, you see that now we have an error that is
    being ignored.

11. We will now fix the SNMPv1 error, click on the browser tab that
    returns you to your HPE iLO7 **Dashboard**.

12. Click on **iLO Settings**.

13. Click on **Access**.

14. Click on the **SNMP hyperlink** on the SNMP card.

> <img src="/assets/images/HOLs/Proliant-Security/image80.png"
> style="width:6.30967in;height:3.57796in" />

15. In the SNMPv1 Settings section, select the **Edit icon (pencil)**.

16. Uncheck **SNMPv1 Request** and **SNMPv1 Trap** and then click the
    **Update** button.

> <img src="/assets/images/HOLs/Proliant-Security/image81.png"
> style="width:6.3344in;height:3.44369in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

17. Return to the **Security Dashboard** in HPE iLO7 and validate that
    **SNMPv1** has been disabled.

> <img src="/assets/images/HOLs/Proliant-Security/image82.png"
> style="width:6.39292in;height:4.00283in" />

18. Return to the Details page that you have loaded in Compute Ops
    Management. Scroll down and open the **OK** section. Note that
    SNMPv1 is no longer a risk.

> <img src="/assets/images/HOLs/Proliant-Security/image83.png"
> style="width:5.00877in;height:6.35055in" />
>
> There are other items that need particular attention, such as Secure
> Boot and the use of self-signed certificates. These two are essential
> for HPE iLO7 security. We will later cover how to automatically apply
> a CA-signed certificate with ACME. For Secure Boot, we will utilize
> the HPE restful interface to enable this functionality.

19. We will now utilize Compute Ops Management to push out all the
    recommended HPE iLO7 Security Settings to our assigned Server. Let’s
    click on **Manage** and then **Groups** within Compute Ops
    Management.

20. Click on the **hyperlinked Name** of your **Group/Team.**

21. From the **Actions** drop down menu, select **Apply iLO Settings**.

> <img src="/assets/images/HOLs/Proliant-Security/image84.png"
> style="width:6.2588in;height:3.40202in" />

22. To view the list of HPE iLO7 settings that will be configured, click
    the **iLO settings enabled for security** link.

> <img src="/assets/images/HOLs/Proliant-Security/image85.png"
> style="width:4.58115in;height:2.99344in" />

23. This list shows the **HPE** **recommended iLO settings** that will
    be pushed to our server to reduce the overall security risk:

> <img src="/assets/images/HOLs/Proliant-Security/image86.png"
> style="width:5.37547in;height:2.85025in" />
>
> Note: Some iLO security settings might require a server reboot to take
> effect.

24. Click the **X** to close this popup.

25. Select your **assigned Server** from the list and hit **Next**.

> <img src="/assets/images/HOLs/Proliant-Security/image87.png"
> style="width:5.2018in;height:3.13052in" />

26. Review your changes, then hit **Apply iLO Settings.**

> <img src="/assets/images/HOLs/Proliant-Security/image88.png"
> style="width:4.98637in;height:2.76255in" />

27. Hit **Close** on the success pop up, to return to your Group
    details.<img src="/assets/images/HOLs/Proliant-Security/image89.png"
    style="width:4.10125in;height:2.05791in"
    alt="A screenshot of a computer Description automatically generated" />

28. In the **Recent group Activity**, you should now see the **HPE iLO7
    settings being successfully applied** and the **settings
    compliance** changed to **Compliant**.

> <img src="/assets/images/HOLs/Proliant-Security/image90.png"
> style="width:2.59189in;height:3.50864in" />

29. If we look to the **left of the screen**, we can see our **HPE iLO7
    Security** section still showing **At risk**. Let’s click on the
    **hyperlink.**

> <img src="/assets/images/HOLs/Proliant-Security/image91.png"
> style="width:2.92021in;height:1.81834in"
> alt="A screenshot of a computer security Description automatically generated" />

30. On the right, click again to select the **Server at Risk.**

> <img src="/assets/images/HOLs/Proliant-Security/image92.png"
> style="width:2.80098in;height:2.39651in"
> alt="A screenshot of a computer error Description automatically generated" />

31. We will then be directed to the Details page for our assigned
    Server. Where **iLO security status** is seen, Click on **Details.**

> <img src="/assets/images/HOLs/Proliant-Security/image93.png"
> style="width:5.60036in;height:2.99889in"
> alt="A screenshot of a computer Description automatically generated" />

32. You should see **two items still at Risk**, both have
    **dependencies** outside of the COM deployed HPE iLO7 settings which
    may require manual intervention to resolve.

> <img src="/assets/images/HOLs/Proliant-Security/image94.png"
> style="width:4.14497in;height:1.9604in"
> alt="A close-up of a certificate Description automatically generated" />

33. In the next section of this Hands-On Lab, we will be following steps
    to **Request and Apply a Signed Certificate** from a **trusted
    Certificate Authority**.

34. Let’s navigate to the Horizon **Desktop** and open the **RESTful
    Interface Tool** so we can use **Redfish** to **Enable Secure
    Boot**.

> <img src="/assets/images/HOLs/Proliant-Security/image95.png"
> style="width:1.7888in;height:2.11904in" />

35. Type the following ilorest commands into the RESTful Interface Tool,
    pressing enter after each line.\
    xx represents your Team Number

**ilorest login holgen12xx-ilo.hol.enablement.local -u Administrator -p
hpent123**

**ilorest select SecureBoot**

**ilorest set SecureBootEnable=True --commit**

**ilorest reboot On**

**ilorest logout**

> <img src="/assets/images/HOLs/Proliant-Security/image96.png"
> style="width:5.81137in;height:4.2182in" />

36. Now that **Secure Boot** is enabled, let’s **close** out the
    **RESTful Interface Tool** and head back to our **iLO7** to test out
    one of our Security Settings changes.

37. Return to the **HPE iLO7 Dashboard** of your assigned Server.

> <img src="/assets/images/HOLs/Proliant-Security/image97.png"
> style="width:6.58227in;height:3.79884in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

38. Earlier in the lab, we created a new Administrator privileged User
    with a simple password. Let’s go back to **iLO7 Settings**, then
    **User Management** and look at creating another new user.

> <img src="/assets/images/HOLs/Proliant-Security/image98.png"
> style="width:6.78053in;height:2.86234in"
> alt="A screenshot of a computer program AI-generated content may be incorrect." />

39. Then click on **Users**.

40. Click **+ Add** above the Local Users frame and enter the following
    settings to create your new user account.

<table style="width:53%;">
<colgroup>
<col style="width: 25%" />
<col style="width: 27%" />
</colgroup>
<thead>
<tr>
<th><blockquote>
<p><strong>Login Name</strong></p>
</blockquote></th>
<th><blockquote>
<p>HPE_Admin1</p>
</blockquote></th>
</tr>
</thead>
<tbody>
<tr>
<td><blockquote>
<p><strong>User Name</strong></p>
</blockquote></td>
<td><blockquote>
<p>HPE Admin1</p>
</blockquote></td>
</tr>
<tr>
<td><blockquote>
<p><strong>New Password</strong></p>
</blockquote></td>
<td><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td><blockquote>
<p><strong>Confirm Password</strong></p>
</blockquote></td>
<td><blockquote>
<p>hpent123</p>
</blockquote></td>
</tr>
<tr>
<td><blockquote>
<p><strong>Role</strong></p>
</blockquote></td>
<td><blockquote>
<p>Administrator</p>
</blockquote></td>
</tr>
</tbody>
</table>

> <img src="/assets/images/HOLs/Proliant-Security/image99.png"
> style="width:4.24189in;height:3.78383in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

41. When we implemented our **HPE iLO7 Security Settings**, it forces
    any **new HPE iLO7 Accounts** to meet **Password complexity
    requirements**. Your current user login is not affected by the
    change.

> <img src="/assets/images/HOLs/Proliant-Security/image100.png"
> style="width:4.1919in;height:4.19871in" />

42. Set the password as **HPESecurePassw0rd!** and then click **Add**.
    The results should look like the screen shot below.

> <img src="/assets/images/HOLs/Proliant-Security/image101.png"
> style="width:6.33882in;height:3.90798in" />
>
> HPE provides the Security Dashboard for every HPE iLO5, HPE iLO6 and
> HPE iLO7 enabled platform and aggregates multiple platform’s security
> status in HPE Compute Ops Management. For more information on HPE
> ProLiant Security visit
> [www.hpe.com/info/iLO](http://www.hpe.com/info/iLO) and view the HPE
> iLO7 Security Technology Brief. The link to the document is at the
> bottom of the web page.

This concludes this section of the lab.

# HPE iLO7 SSL Certificate Management

By default, HPE iLO7 uses a self-signed certificate in SSL connections.
While this allows for encrypted communication, it lacks the trust and
verification provided by a Certificate Authority (CA). A CA-signed
certificate is issued by a trusted third-party CA, which verifies the
identity of the server (i.e. the HPE iLO7). This ensures that the
communication is with a legitimate HPE iLO7 device, significantly
reducing the risk of man-in-the-middle (MITM) attacks where an attacker
could intercept and alter the communication.

Using a CA-signed certificate on HPE iLO7 provides several benefits:

- **Trust and Verification**: Ensures that both the client and server
  can verify each other's identity through a trusted CA.

- **Enhanced Security**: Prevents unauthorized entities from
  intercepting and misusing sensitive credentials.

- **Avoiding Security Warnings**: Browsers and other clients trust
  CA-signed certificates, avoiding confusing security warnings.

To enhance overall security and trust, it is recommended to configure
HPE iLO7 with a CA-signed certificate. An easy way to achieve this is by
using HPE iLO7’s support for obtaining and renewing SSL certificates
automatically via ACME (Automatic Certificate Management Environment).

This method offers several key benefits over the manual method of using
a Certificate Signing Request (CSR) and requesting a certificate from a
Certificate Authority (CA). It significantly reduces administrative
overhead by automating the process of certificate issuance and renewal,
ensuring that certificates are always up to date without manual
intervention. This automation minimizes the risk of service disruptions
due to expired certificates and enhances security by regularly
refreshing cryptographic keys. Additionally, it provides a scalable
solution for managing certificates across many devices, ensuring
consistent and compliant security practices throughout the organization.

To learn more about ACME, see [How It Works - Let's
Encrypt](https://letsencrypt.org/how-it-works/).

By default, this feature is disabled in HPE iLO7. In this section, we
are going to enable it and configure automatic certificate enrollment in
HPE iLO7 to obtain a trusted SSL certificate signed by a CA.

If you are looking for information about how to do it manually, see
[Generate CSR and Import an SSL
Certificate](https://support.hpe.com/hpesc/public/docDisplay?docId=sd00002007en_us&page=GUID-D7147C7F-2016-0901-06D0-000000000CC0.html).

1.  The first step is to download the root CA certificate of the
    certificate enrollment server to secure the connection between the
    HPE iLO7 and the ACME server. This server is our internal lab
    Certificate Authority (CA) server, running on Ubuntu with step-ca.\
    We’ve saved you from the trouble and provided the root CA contents
    here.

> -----BEGIN CERTIFICATE-----
>
> MIIBnDCCAUKgAwIBAgIRANV44hj14S7EMgYtFwMOx+YwCgYIKoZIzj0EAwIwLDEQ
>
> MA4GA1UEChMHSE9MQ0EwMTEYMBYGA1UEAxMPSE9MQ0EwMSBSb290IENBMB4XDTI2
>
> MDEwNTAzNTcxMFoXDTM2MDEwMzAzNTcxMFowLDEQMA4GA1UEChMHSE9MQ0EwMTEY
>
> MBYGA1UEAxMPSE9MQ0EwMSBSb290IENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
>
> QgAEhZyWmGjWm5TGlOgipIH1pd+ZnGqCt92BdTTF8hv4F6VDod5a4HsVXNp3+aE6
>
> SFXjt7TQrUEllguFNM7bPVk7FaNFMEMwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB
>
> /wQIMAYBAf8CAQEwHQYDVR0OBBYEFKkMIYlOv6LVDXBOFxExMjNWmgDlMAoGCCqG
>
> SM49BAMCA0gAMEUCIQCDUN6pBnRH/GWaaN3kPrTX5KniGsMwe/JDAwFEtUKgfQIg
>
> X7RdmJcE9ZM1N4GBw7yl5EOaNrayuWnB9LBWmrN5O2s=
>
> -----END CERTIFICATE-----

2.  We can now navigate to our **Security** page in HPE iLO7.

3.  Click on the **TLS Certificate** card.

> <img src="/assets/images/HOLs/Proliant-Security/image102.png"
> style="width:6.49778in;height:3.39689in" />

4.  We will now select **Configure Certificate**.

> <img src="/assets/images/HOLs/Proliant-Security/image103.png"
> style="width:6.4973in;height:3.2009in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

5.  Fill in our details for **Manage TLS Certificate Automatically**.

6.  Our **Server URL** is
    <https://holacme01.hol.enablement.local:443/acme/acme/directory> ,
    you will also need to paste in the CA Certificate we shared in
    Step 1. For other values in the form, see table below. Then click
    **Configure**.

<table style="width:53%;">
<colgroup>
<col style="width: 25%" />
<col style="width: 27%" />
</colgroup>
<thead>
<tr>
<th><strong>Server URL:</strong></th>
<th><blockquote>
<p>See text in step 6</p>
</blockquote></th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Country (C)</strong></td>
<td><blockquote>
<p>US</p>
</blockquote></td>
</tr>
<tr>
<td><strong>State (ST)</strong></td>
<td><blockquote>
<p>TX</p>
</blockquote></td>
</tr>
<tr>
<td><strong>City or Locality (L)</strong></td>
<td><blockquote>
<p>Houston</p>
</blockquote></td>
</tr>
<tr>
<td><strong>Organization Name (O)</strong></td>
<td><blockquote>
<p>HPE</p>
</blockquote></td>
</tr>
</tbody>
</table>

> <img src="/assets/images/HOLs/Proliant-Security/image104.png"
> style="width:5.93385in;height:5.95885in" />

7.  You should see that the status of the certificate operation is “**In
    progress**” and this takes a minute or so.

> <img src="/assets/images/HOLs/Proliant-Security/image105.png"
> style="width:5.65804in;height:2.57179in" />

8.  Soon the status will be **Success**.

> <img src="/assets/images/HOLs/Proliant-Security/image106.png"
> style="width:5.67227in;height:2.71466in" />

9.  Note, an **iLO Reset Pending** icon has appeared and will need to be
    clicked to properly activate the Certificate. Click **Yes, reset**.

> <img src="/assets/images/HOLs/Proliant-Security/image107.png"
> style="width:2.16685in;height:1.43346in" />

10. Give the HPE iLO7 a **few minutes to reset**, then **open a new tab
    or browser** to login and confirm that the **connection** is now
    recognized as **secure** by the browser.

> <img src="/assets/images/HOLs/Proliant-Security/image108.png"
> style="width:5.37528in;height:2.11122in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />
>
> **Note**: For the setup to work end-to-end, the CA certificate must be
> added to the trusted root certificates of all client machines that
> connect to the HPE iLO7. In our lab environment, this process is
> automatically handled by our lab domain policy.

11. If you get a **Failed** status, you can check the HPE iLO7 Security
    logs under **Dashboard** / **Security Log**. This is where ACME
    activity is generated.

> <img src="/assets/images/HOLs/Proliant-Security/image109.png"
> style="width:6.97901in;height:3.61046in" />

12. If you face an enrollment failure, it is recommended to double check
    all values under the TLS Certificate Server configuration and then
    perform an update. Only do this if you have an issue. If you take
    this action what follows will result.

> <img src="/assets/images/HOLs/Proliant-Security/image110.png"
> style="width:6.50555in;height:2.55558in" />

13. Referring to the Security Log, a message that the HPE iLO7 must be
    reset to use the new certificate is displayed.

> <img src="/assets/images/HOLs/Proliant-Security/image111.png"
> style="width:6.9526in;height:2.1148in" />

14. Go to **iLO Settings** and click **Rest iLO** in the **Quick
    Actions** card.

> <img src="/assets/images/HOLs/Proliant-Security/image112.png"
> style="width:6.94485in;height:2.7521in" />

15. A successful Certificate Enrollment, will show that now the **HPE
    iLO7** uses a **trusted SSL certificate signed** by our
    **certificate authority server**:

> <img src="/assets/images/HOLs/Proliant-Security/image113.png"
> style="width:6.8391in;height:2.43588in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

16. You can now circle back to **HPE Compute Ops Management** and check
    the **iLO Security Status**.

> <img src="/assets/images/HOLs/Proliant-Security/image114.png"
> style="width:3.90631in;height:4.42977in" />
>
> **Note**: This process can also be automated using PowerShell with
> this
> [script](https://github.com/jullienl/HPE-Synergy-OneView-demos/blob/master/Powershell/iLO/Enable%20iLO%20NDES%20automatic%20certificate%20enrollment.ps1).\
> This concludes this section of the lab.

<span id="_Toc220925652" class="anchor"></span>HPE Compute Ops
Management Secure Gateway

The HPE Compute Ops Management Secure Gateway is an on-premises virtual
appliance that optimizes secure connectivity between HPE infrastructure
and HPE Compute Ops Management. Deployed on supported hypervisors
(VMware ESXi 7/8), it addresses critical challenges in firewall
management, traffic efficiency, and operational control:

**Key Benefits:**

- **Simplified Firewall Management**: Establishes a single secure
  outbound connection to HPE Compute Ops Management, dramatically
  reducing firewall complexity, minimizing exposed ports, and shrinking
  the attack surface.

- **Efficient Traffic Aggregation**: Consolidates multiple HPE iLO
  WebSocket connections into one unified egress stream, streamlining
  operations and reducing vulnerability risks from fragmented
  connections.

- **Optimized Bandwidth Usage**: Caches firmware components locally when
  HPE iLOs are updated, eliminating redundant downloads for subsequent
  server updates, improving update reliability, and conserving
  bandwidth.

- **Instant Connection Control**: Enables immediate disconnection of all
  HPE iLO-to-COM connections when needed, providing agile response
  capabilities for compliance requirements, troubleshooting, or security
  incidents.

<img src="/assets/images/HOLs/Proliant-Security/image115.png"
style="width:5.21141in;height:2.88293in"
alt="A diagram of a computer network AI-generated content may be incorrect." />

For more details on the Secure Gateway, including deployment,
configuration, and troubleshooting, refer to the official [HPE Compute
Ops Management Secure Gateway
documentation](https://support.hpe.com/hpesc/public/docDisplay?docId=sd00005106en_us).

# Deploying the Secure Gateway through VCenter

In this portion of the lab, we will focus on deploying an OVF Template
supplied by HPE to provision the Virtual Machine Appliance which will
function as the Secure Gateway for Compute Ops Management.

1.  Open a fresh **Web Browser** or **Tab** and navigate to your VCenter
    Server at **holsgwvc01.hol.enablement.local**

2.  **Confirm any Certificate Issues** to Proceed and then click
    **Launch vSphere Client**.

<img src="/assets/images/HOLs/Proliant-Security/image116.png"
style="width:5.09308in;height:2.62419in"
alt="A screenshot of a computer Description automatically generated" />

3.  Use credentials
    [**Administrator@vsphere.local**](mailto:Administrator@vsphere.local)
    and **Disc0ver2025!** as the password.

4.  You should be now logged in to the vSphere Client

<img src="/assets/images/HOLs/Proliant-Security/image117.png"
style="width:4.42146in;height:2.48878in"
alt="A screenshot of a computer Description automatically generated" />

5.  On the **left-hand side** of the screen, expand out the **vSphere
    Client** **menu**, and click on **Content Libraries.**

> <img src="/assets/images/HOLs/Proliant-Security/image118.png"
> style="width:3.04617in;height:3.25661in"
> alt="A screenshot of a computer Description automatically generated" />

6.  Click on **Images.**

> <img src="/assets/images/HOLs/Proliant-Security/image119.png"
> style="width:5.87784in;height:1.79482in"
> alt="A screenshot of a computer Description automatically generated" />

7.  Click on **OVF and OVA Templates**.

8.  Right click on the **HPESecureGateway-X.X.X file** and select **New
    VM from This Template…**

> <img src="/assets/images/HOLs/Proliant-Security/image120.png"
> style="width:3.11834in;height:2.15425in"
> alt="A screenshot of a computer Description automatically generated" />

9.  Set the Virtual Machine name as **TeamXX-SGW** where **XX** is your
    team number and select **Datacenter** as the location for the VM.
    Click **Next** to proceed.

> <img src="/assets/images/HOLs/Proliant-Security/image121.png"
> style="width:6.47836in;height:3.19154in" />

10. Click **holsgwesx01.hol.enablement.local** as the compute resource,
    then **Next** to proceed.

> <img src="/assets/images/HOLs/Proliant-Security/image122.png"
> style="width:5.67396in;height:2.8066in"
> alt="A screenshot of a computer Description automatically generated" />

11. Click **Next** on **Review Details.**

12. Now for **Select Storage**, click **NimbleSan01**, change **Select
    virtual disk format** to **<u>Thin Provision</u>** (This is really
    important) and hit **Next.**

> <img src="/assets/images/HOLs/Proliant-Security/image123.png"
> style="width:6.0409in;height:3.59937in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

13. Leave the **defaults selected** for **Select Networks** and then
    **hit Next**.

> <img src="/assets/images/HOLs/Proliant-Security/image124.png"
> style="width:5.43171in;height:3.17819in"
> alt="A screenshot of a computer Description automatically generated" />

14. One last check and then hit **Finish** to complete the deployment.

> <img src="/assets/images/HOLs/Proliant-Security/image125.png"
> style="width:5.63265in;height:1.91065in"
> alt="A screenshot of a computer Description automatically generated" />
>
> <img src="/assets/images/HOLs/Proliant-Security/image126.png"
> style="width:5.61889in;height:2.29978in"
> alt="A screenshot of a computer Description automatically generated" />

15. You can now navigate back to **Inventory Page** where you will see
    your **VM has been provisioned**. You will have to expand the host
    to see the deployed VMs

> <img src="/assets/images/HOLs/Proliant-Security/image127.png"
> style="width:5.49214in;height:4.64207in" />

16. Modify the network settings of the VM to use only one network
    interface. Right-click on your VM and select **Edit Settings**.

> <img src="/assets/images/HOLs/Proliant-Security/image128.png"
> style="width:4.00641in;height:3.18754in" />

17. Now click on **Network Adapter 2** and deselect **Connect At Power
    On** and then **OK** to confirm the change.

> <img src="/assets/images/HOLs/Proliant-Security/image129.png"
> style="width:3.97043in;height:3.17543in" />

This concludes this section of the lab.

# Configuring the Secure Gateway and connecting to COM

In this portion of the lab, we will power on the VM, configure the
Secure Gateway through its Terminal User Interface (TUI) and then
connect it to HPE Compute Ops Management.

1.  There are multiple ways to power on a VM, **click the Green Play
    button** or any alternative you prefer.

> <img src="/assets/images/HOLs/Proliant-Security/image130.png"
> style="width:6.0078in;height:2.44674in"
> alt="A screenshot of a computer Description automatically generated" />

2.  Click **Launch Web Console** so you can access the Appliance TUI and
    continue the configuration.

> <img src="/assets/images/HOLs/Proliant-Security/image131.png"
> style="width:5.95814in;height:2.741in"
> alt="A screenshot of a computer Description automatically generated" />

3.  Enter the **default Username / Password** to login which is
    **administrator / admin**.

> <img src="/assets/images/HOLs/Proliant-Security/image132.png"
> style="width:4.57684in;height:1.97599in"
> alt="A computer screen with white text AI-generated content may be incorrect." />

**Note:** For navigating through the TUI, you will need to use the
**TAB** and **Enter** keys.

4.  For the next two screens we will need to Accept the T&C’s. Click
    **Agree** both times.

5.  We will now update the password to **HPESecurePassw0rd!** and click
    **Save.**

6.  Click **Next** on **Step 1.**

7.  Enter the fully qualified domain name of your Secure Gateway using
    the table below.\
    \
    <img src="/assets/images/HOLs/Proliant-Security/image133.png"
    style="width:6.08402in;height:0.84569in"
    alt="A screenshot of a computer Description automatically generated" />

<table style="width:72%;">
<colgroup>
<col style="width: 17%" />
<col style="width: 35%" />
<col style="width: 19%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><strong>Team Number</strong></th>
<th style="text-align: center;"><blockquote>
<p><strong>Full qualified domain name</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>IP address</strong></p>
</blockquote></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-01</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team01-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.51</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-02</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team02-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.52</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-03</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team03-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.53</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-04</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team04-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.54</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-05</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team05-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.55</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-06</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team06-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.56</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-07</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team07-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.57</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-08</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team08-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.58</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-09</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team09-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.59</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-10</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team10-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.60</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-11</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team11-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.61</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-12</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team12-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.62</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-13</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team13-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.63</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-14</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team14-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.64</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-15</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team15-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.65</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-16</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team16-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.66</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-17</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team17-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.67</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-18</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team18-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.68</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-19</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team19-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.69</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-20</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team20-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.70</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-21</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team21-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.71</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-22</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team22-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.72</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-23</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team23-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.73</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-24</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team24-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.74</p>
</blockquote></td>
</tr>
<tr>
<td style="text-align: center;"><blockquote>
<p>Team-25</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>team25-sgw.hol.enablement.local</p>
</blockquote></td>
<td style="text-align: center;"><blockquote>
<p>10.18.20.75</p>
</blockquote></td>
</tr>
</tbody>
</table>

8.  

9.  Tab to **IP Address Source** and then to **Manual.** Use the
    spacebar to place a “**X**” in Manual.

> <img src="/assets/images/HOLs/Proliant-Security/image133.png"
> style="width:6.08402in;height:1.5501in"
> alt="A screenshot of a computer Description automatically generated" />

10. For the IP address, use the table above to select your corresponding
    IP Address.

11. For the rest of the values use the table below.

| **Prefix length** | 22           |
|-------------------|--------------|
| **Gateway**       | 10.18.20.1   |
| **Primary DNS**   | 10.18.20.111 |
| **Secondary DNS** | 10.18.20.112 |

12. Once all values are entered correctly, select **Next** to proceed.

> <img src="/assets/images/HOLs/Proliant-Security/image133.png"
> style="width:5.16593in;height:3.45442in"
> alt="A screenshot of a computer Description automatically generated" />

13. Leave the default options for **Time and Web Proxy** configuration
    for step 3 of 5. Tab to **Next** and press **\<Enter\>** on your
    keyboard to continue.

14. For Step 4 of 5, continue below.

> <img src="/assets/images/HOLs/Proliant-Security/image134.png"
> style="width:5.16161in;height:2.37886in" />

15. Now return to your **Web Browser** that’s connected to **HPE Compute
    Ops Management.**

16. From the COM homepage, navigate to **Inventory**, then select
    **Appliances** card.

> <img src="/assets/images/HOLs/Proliant-Security/image135.png"
> style="width:4.67489in;height:2.28399in"
> alt="A screenshot of a computer Description automatically generated" />

17. Click **Add Appliance**, ensure **Secure gateway** is selected.
    Click **Next** to continue.

> <img src="/assets/images/HOLs/Proliant-Security/image136.png"
> style="width:4.65116in;height:3.38581in"
> alt="A screenshot of a computer application Description automatically generated" />

18. Set **30 minutes** for how long the activation key will be valid and
    select **Next**.

> <img src="/assets/images/HOLs/Proliant-Security/image137.png"
> style="width:4.74992in;height:2.17927in"
> alt="A screenshot of a computer Description automatically generated" />

19. Then click **Finish and generate activation key**.

> <img src="/assets/images/HOLs/Proliant-Security/image138.png"
> style="width:4.70417in;height:2.11346in"
> alt="A screenshot of a computer Description automatically generated" />

20. Take note of the **Activation Key** and copy it.

> <img src="/assets/images/HOLs/Proliant-Security/image139.png"
> style="width:3.22735in;height:2.48582in"
> alt="A screenshot of a computer Description automatically generated" />

21. Type this into the TUI Step 4 of 5, for the **Secure Gateway
    Appliance** and tab to **Next** and hit **Enter** to continue.

22. The Secure Gateway should now be **connected** and you can **Close**
    this last **informational** step.

> <img src="/assets/images/HOLs/Proliant-Security/image140.png"
> style="width:6.10826in;height:3.24148in"
> alt="A screenshot of a computer program Description automatically generated" />

23. The TUI page should show your **Secure Gateway** as **Connected**.

> <img src="/assets/images/HOLs/Proliant-Security/image141.png"
> style="width:6.06719in;height:3.79199in" />

24. The COM **Appliances** inventory page should display the same
    information:

> <img src="/assets/images/HOLs/Proliant-Security/image142.png"
> style="width:6.31037in;height:3.25944in" />

This concludes this section of the lab.

25. 

# Connecting our HPE iLO7 to COM via the Secure Gateway

In this portion of the lab, we will disconnect our existing HPE iLO7
from COM, modify our Proxy details and then create a new Activation Key
linking it to the Secure Gateway and apply this to our HPE iLO7.

1.  Return to the **Web Browser** that’s connected to your **HPE iLO7**
    and navigate to **Compute Ops Management** section on the center of
    the **Dashboard**. Click on the **HPE Compute Ops Management** card.

> <img src="/assets/images/HOLs/Proliant-Security/image109.png"
> style="width:6.06299in;height:3.13662in" />

2.  From here, click on **Edit Settings** option.

> <img src="/assets/images/HOLs/Proliant-Security/image143.png"
> style="width:5.24168in;height:2.8527in" />

3.  Disable the COM connection by clicking on the **sliding button**
    next to HPE Compute Ops Management.

4.  Then **check the box** to disable the connection to HPE COM.

5.  Click **Save** to continue.

> <img src="/assets/images/HOLs/Proliant-Security/image144.png"
> style="width:6.08363in;height:4.2402in" />

6.  Then navigate to the **HPE iLO7 Settings** section to update the
    **Web** **Proxy** details under **Access**.

7.  Click the **pencil** to the right of **Web Proxy** to update the
    **Web Proxy** information.

> <img src="/assets/images/HOLs/Proliant-Security/image145.png"
> style="width:4.56968in;height:2.58347in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

8.  Update the **Web Proxy Server** to the FQDN of your newly created
    Secure Gateway Appliance. Refer to your assigned FQDN to know what
    to enter here. For this example, we will use "Team03". Additionally,
    set the Web Proxy Port to **8080**. Finally click **Update** to make
    the changes.

> <img src="/assets/images/HOLs/Proliant-Security/image146.png"
> style="width:3.22528in;height:4.16703in" />

9.  Find your **Web Browser** or **Tab** that’s **connected to Compute
    Ops Management** and navigate to **Servers**. You will see your
    server showing it as **Reconnecting** or **Not Connected** depending
    on how fast you are.

> <img src="/assets/images/HOLs/Proliant-Security/image147.png"
> style="width:5.59396in;height:0.5396in" />

10. Go ahead and click **Add server** at the top right area of this
    page.

> <img src="/assets/images/HOLs/Proliant-Security/image148.png"
> style="width:5.56802in;height:0.79882in"
> alt="A screenshot of a phone Description automatically generated" />

11. Change the **Server connection type** to **Secure gateway** and
    select your **assigned** secure gateway from the **drop-down menu**.

12. For the Authentication Mode make sure **Activation key** is
    selected.

13. Click **Next** to continue.

> <img src="/assets/images/HOLs/Proliant-Security/image149.png"
> style="width:5.03497in;height:3.85192in" />

14. Change the Expiration to **30 minutes** and select **Use existing
    subscription key**. Finally click **Next** to continue.

> <img src="/assets/images/HOLs/Proliant-Security/image150.png"
> style="width:4.422in;height:3.22892in" />

15. Review your Activation Key Details, then hit **Finish and generate
    activation key**.

> <img src="/assets/images/HOLs/Proliant-Security/image151.png"
> style="width:5.39961in;height:2.80319in"
> alt="A screenshot of a computer Description automatically generated" />

16. Take note of or **copy the Activation key**, then **close** the pop
    up.

> <img src="/assets/images/HOLs/Proliant-Security/image152.png"
> style="width:4.69155in;height:3.71534in" />

17. Return to your **Web Browser** or **Tab** which is connected to your
    **Server’s HPE iLO7**, Click on **Compute Ops Management**.

18. Click **Enable**.

> <img src="/assets/images/HOLs/Proliant-Security/image153.png"
> style="width:4.85112in;height:2.9669in" />

19. At the Activation Key is required screen, click on **Enter
    Activation key**.

> <img src="/assets/images/HOLs/Proliant-Security/image154.png"
> style="width:6.77035in;height:3.4325in" />

20. At the Enter Activation Key screen enter the **activation key** you
    captured in the previous step and click on **Save**.

> <img src="/assets/images/HOLs/Proliant-Security/image155.png"
> style="width:6.40889in;height:4.25037in" />

21. Give it a few seconds and it should then return with a Connection
    Status of **Connected**, your **workspace ID** and **Connection Type
    Secure Gateway**.

> <img src="/assets/images/HOLs/Proliant-Security/image156.png"
> style="width:6.86834in;height:2.71467in"
> alt="A screenshot of a computer AI-generated content may be incorrect." />

22. If we then navigate back to our Browser or Tab that’s connected to
    COM, we will see our Server now Connected and going through its
    inventory process.

> <img src="/assets/images/HOLs/Proliant-Security/image157.png"
> style="width:6.94792in;height:0.47808in" />

23. If you go a step further and Click on the **Hostname of your
    Server** or at this point, possibly the two bolded dash lines **-
    -**, you will get detailed information and see you are connected via
    the Secure Gateway.

> <img src="/assets/images/HOLs/Proliant-Security/image157.png"
> style="width:6.83336in;height:0.4702in" />

24. Review the information on the Server Summary information screen.

> <img src="/assets/images/HOLs/Proliant-Security/image158.png"
> style="width:5.20989in;height:3.44645in" />

25. You can also click on the **hyperlink** for your **Secure Gateway**
    to get **detailed information** for the server as well.

> <img src="/assets/images/HOLs/Proliant-Security/image159.png"
> style="width:5.19662in;height:3.30103in" />
>
> You have accomplished what we wanted to show you in this HOL
> experience. We hope you get a lot out of it. Thank you for
> participating in the session.

This completes this HOL experience.

<span id="_Toc220925656" class="anchor"></span>Summary

In this lab, we explored the robust capabilities of HPE's integrated
Lights-Out (HPE iLO7) management tools, specifically HPE iLO7, within
the ProLiant Gen12 series. We also examined how HPE Compute Ops
Management offers secure and efficient remote management of HPE servers,
enabling administrators to access and control systems from virtually
anywhere—provided the necessary security configurations are in place.

By implementing HPE iLO7 security best practices—such as secure network
access, strong authentication methods, and encryption—users can maintain
a secure environment while remotely managing ProLiant servers. This
applies across various environments, from remote offices and edge
systems to large datacenters. HPE’s unified management strategy ensures
consistency in system oversight, regardless of location.

Additionally, we demonstrated how HPE Compute Ops Management integrates
seamlessly with a Secure Gateway, highlighting the ease and security of
remote management. With HPE ProLiant Compute, HPE empowers IT
administrators with both the flexibility and security needed to maintain
full control of their hardware, no matter where it’s located.

<span id="_Toc220925657" class="anchor"></span>Want more?

Back home, you can head to the HPE Demonstration Portal and request a
time slot\
(<https://hpedemoportal.ext.hpe.com/>) to demonstrate these products

For COM Interest, request a 90-day evaluation\
()

Pull out your phone and view HPE GreenLake and HPE Compute Ops
Management, to move to the next step in a wholistic IT system management
strategy.\
\
**Login**: com.demouser@gmail.com\
**Password**: TechPr02026!\
<img src="/assets/images/HOLs/Proliant-Security/image160.png"
style="width:1.50302in;height:1.51729in" />\
\
\
**LEARN MORE AT\**
![](/assets/images/HOLs/Proliant-Security/image162.jpeg)<u>https://[hpe.com/us/en/compute/management-software.html](https://www.hpe.com/us/en/compute/management-software.html?jumpid=in_learnmore)</u>
