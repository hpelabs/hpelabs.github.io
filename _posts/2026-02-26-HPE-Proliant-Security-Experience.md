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
- Deploy and use the **COM Secure Gateway**. citeturn1search1

> **Note:** Screenshots from the original PDF are replaced with concise step prompts (e.g., *“Screenshot: iLO Dashboard”*). When publishing on GitHub Pages, you can later add images in the indicated callouts.

---

## Accessing the HPE Compute BU Enablement Environment
1. Open Chrome and browse to the Horizon Access Portal:
   - External (no HPE VPN): `https://labs.compute.cloud.hpe.com`
   - Internal (HPE VPN): `https://techenablement.hpecorp.net`
2. Click **Omnissa Horizon Web Client** and sign in with credentials from your instructor.
3. Launch the lab desktop and keep working **within this VPN‑enabled browser session**.

![Horizon login & pool selection.](images/horizon-login-pool-selection.png) citeturn1search1

---

## Embedded Server Management with HPE iLO 7
**HPE iLO 7** offers out‑of‑band management (virtual KVM, media, power, logs, and RESTful APIs) over a dedicated iLO port or shared LOM. Assumptions for this lab:
- DHCP reservations provide consistent iLO addressing.
- You have the server’s default credentials (toe‑tag). citeturn1search1

**Steps**
1. In the lab Chrome session, navigate to your assigned iLO FQDN from the team table (e.g., `holgen1201-ilo.hol.enablement.local`).
2. If you see **Your connection is not private**, proceed (self‑signed cert).
3. Sign in as `Administrator` with the provided default password.

![iLO 7 login & Dashboard.](images/ilo-login-dashboard.png) citeturn1search1

> **Team → iLO mapping**: See the original team table in the PDF for FQDN, username, and default password. Replace with your class‑specific values. citeturn1search1

---

## Managing Local Users
Create a second administrative user (for later security testing):
1. **iLO Settings → User Management → Users → + Add**
2. Example (lab):
   - Login Name: `HPE_Admin`
   - User Name: `HPE Admin`
   - Password: `hpent123` (temporary)
   - Role/Privileges: **Administrator** (all)
3. Save and sign out/in using the new account. citeturn1search1

> **Note:** Later, password complexity policies will block simple passwords for **new** accounts once security settings are applied; existing accounts are not retroactively changed. citeturn1search1

---

## Firmware Verification
Use **iLO 7 → Firmware → Firmware Verification** to schedule or run an on‑demand integrity scan of iLO, System ROM (BIOS), and CPLD.

**Lab actions**
1. **Settings** → enable *Background Scan*.
2. Set **Scan Interval** to `1` (for lab) and **Integrity Failure Action** to *Log Only*.
3. Click **Run Scan** to verify components now. citeturn1search1

> **Tip:** Avoid updating firmware while a verification scan is running. Invalid images are quarantined and not offered for flashing. Logs are written to AHS/IML. citeturn1search1

---

## Applying a Web Proxy Configuration
**Security → Access → Web Proxy (edit)**
- Web Proxy Server: `hpeproxy.its.hpecorp.net`
- Port: `443`
- Save changes. citeturn1search1

---

## Connecting to HPE Compute Ops Management
Sign into **HPE GreenLake** → launch **Compute Ops Management**.

**Lab actions**
1. Generate an **Activation Key** (Direct connect; validity 30 minutes; use existing subscription key).
2. In iLO 7 **Dashboard → HPE Compute Ops Management** → **Enable** → **Enter Activation Key** → **Save**.
3. Confirm **Connection Status: Connected** (Workspace ID visible). citeturn1search1

---

## Secure Login Options (MFA & SSO)
From **GreenLake → Manage Workspace → Workspace Details → Actions → Manage MFA** you can enforce MFA (Okta Verify, FIDO2 Security Key/Biometrics, Google Authenticator) and configure SAML SSO. *(Do not enable in the lab session.)* citeturn1search1

---

## Establishing iLO 7 ↔ GreenLake Connection (Direct)
This onboarding uses **mutual TLS (mTLS)** with an HPE‑issued client certificate (EC‑384, SHA‑256) presented by iLO to COM over HTTPS (443). Generate and apply the activation key as above. citeturn1search1

---

## Securing Your Server Fleet with COM
Use **Manage → Settings** in COM to define reusable server settings:
- **Firmware** (baseline/SPP)
- **BIOS / Workload Profiles** (e.g., *General Throughput Compute*)
- **iLO Security Settings** (HPE recommended) citeturn1search1

**Create a Firmware setting**
1. **Create setting** → Name: `TeamXX-Firmware` → Category: **Firmware**.
2. Select a **Gen12 baseline** (latest base SPP) → **Finish**. citeturn1search1

---

## Creating Server Groups & Associating Settings
1. **Manage → Groups → Create a group**
2. Name/Description: your team name; **Type: Server**.
3. Assign:
   - Firmware setting: *TeamXX-Firmware*
   - BIOS setting: choose per workload
   - iLO setting: **iLO settings enabled for security**
4. Leave *Auto apply firmware* **disabled** for the lab.
5. **Enable** *Auto apply BIOS settings*; leave *Auto apply iLO settings* **disabled** (we’ll apply manually later).
6. Add your server to the group and watch **Recent group activity**. citeturn1search1

---

## Advanced Security Settings for HPE iLO 7
Review and remediate iLO security risks from both iLO and COM.

**Tasks**
1. In iLO **Security → Overview**, review risk items.
2. In COM server details, open **iLO security status → Details** and note risks (e.g., SNMPv1 enabled, Secure Boot, self‑signed cert).
3. (Demo) Ignore Secure Boot risk in iLO (not best practice for production).
4. Disable **SNMPv1**: **iLO Settings → Access → SNMP → Edit** → uncheck *SNMPv1 Request/Trap* → **Update**.
5. In COM **Groups → Actions → Apply iLO Settings** → select **iLO settings enabled for security** → **Apply**.
6. Recheck **iLO security status**; remaining risks may require manual actions (e.g., Secure Boot, trusted TLS cert). citeturn1search1

**Enable Secure Boot with Redfish (ilorest)**
```bash
ilorest login holgen12xx-ilo.hol.enablement.local -u Administrator -p hpent123
ilorest select SecureBoot
ilorest set SecureBootEnable=True --commit
ilorest reboot
ilorest logout
```
*Replace `xx` with your team number and credentials as appropriate.* citeturn1search1

**Password Complexity Enforcement**
After applying iLO security settings, new iLO accounts must meet complexity requirements (e.g., use `HPESecurePassw0rd!`). Existing accounts are unaffected. citeturn1search1

---

## HPE iLO 7 TLS/SSL Certificate Management (ACME)
Replace the self‑signed iLO certificate with a CA‑signed certificate using **Automatic Certificate Management Environment (ACME)**.

**Prereqs**
- Import the root CA cert of the ACME server (example below is from the lab’s `step-ca`).

```pem
-----BEGIN CERTIFICATE-----
MIIBnDCCAUKgAwIBAgIRANV44hj14S7EMgYtFwMOx+YwCgYIKoZIzj0EAwIwLDEQ
MA4GA1UEChMHSE9MQ0EwMTEYMBYGA1UEAxMPSE9MQ0EwMSBSb290IENBMB4XDTI2
MDEwNTAzNTcxMFoXDTM2MDEwMzAzNTcxMFowLDEQMA4GA1UEChMHSE9MQ0EwMTEY
MBYGA1UEAxMPSE9MQ0EwMSBSb290IENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEhZyWmGjWm5TGlOgipIH1pd+ZnGqCt92BdTTF8hv4F6VDod5a4HsVXNp3+aE6
SFXjt7TQrUEllguFNM7bPVk7FaNFMEMwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB
/wQIMAYBAf8CAQEwHQYDVR0OBBYEFKkMIYlOv6LVDXBOFxExMjNWmgDlMAoGCCqG
SM49BAMCA0gAMEUCIQCDUN6pBnRH/GWaaN3kPrTX5KniGsMwe/JDAwFEtUKgfQIg
X7RdmJcE9ZM1N4GBw7yl5EOaNrayuWnB9LBWmrN5O2s=
-----END CERTIFICATE-----
```

**Configure ACME in iLO**
1. **Security → TLS Certificate → Configure Certificate**
2. Choose **Manage TLS Certificate Automatically** and provide:
   - **Server URL**: `https://holacme01.hol.enablement.local:443/acme/acme/directory`
   - **CA Certificate**: paste the PEM above
   - Subject fields: `C=US, ST=TX, L=Houston, O=HPE`
3. **Configure** → wait for **Success** → apply **iLO Reset** when prompted.
4. Verify browser now trusts the iLO connection (ensure the CA is trusted by clients). citeturn1search1

> **Troubleshooting:** Check **Dashboard → Security Log** for ACME activity; re‑validate the server URL and CA cert if enrollment fails, then reset iLO after updates. citeturn1search1

---

## HPE COM Secure Gateway
The **Secure Gateway** is an on‑prem virtual appliance (VMware ESXi 7/8) that:
- Consolidates iLO WebSocket traffic into a single outbound connection to COM (simpler firewalls).
- Caches firmware to optimize bandwidth during updates.
- Enables instant connection control (disconnect all iLO↔COM traffic if required). citeturn1search1

---

## Deploying the Secure Gateway via vCenter
1. Log into vCenter at `holsgwvc01.hol.enablement.local` → **Launch vSphere Client**.
2. Credentials: `Administrator@vsphere.local` / `Disc0ver2025!`.
3. **Content Libraries → Images → OVF and OVA Templates** → right‑click `HPESecureGateway-X.X.X` → **New VM from This Template…**
4. Name: `TeamXX-SGW`; select **Datacenter**.
5. Compute resource: `holsgwesx01.hol.enablement.local`.
6. Storage: **NimbleSan01**, **Thin Provision**.
7. Networks: defaults.
8. Finish and wait for deployment, then edit settings to **disable** `Network Adapter 2` (**Connect at power on** unchecked). citeturn1search1

---

## Configuring the Secure Gateway and Connecting to COM
1. Power on the VM → **Launch Web Console**.
2. TUI login: `administrator` / `admin` → accept T&Cs → set password to `HPESecurePassw0rd!`.
3. Hostname (per team) and **Manual** network config:
   - IP (team‑specific table)
   - Prefix: `22`
   - Gateway: `10.18.20.1`
   - DNS: `10.18.20.111`, `10.18.20.112`
4. In COM: **Inventory → Appliances → Add Appliance → Secure gateway**; generate **Activation Key** (30 minutes).
5. Paste the key into the appliance TUI (Step 4/5) → **Next** → confirm **Connected** in both TUI and COM. citeturn1search1

---

## Connecting iLO 7 to COM via Secure Gateway
1. In iLO **Compute Ops Management → Edit Settings** → disable the existing direct connection.
2. **iLO Settings → Access → Web Proxy (edit)**
   - Web Proxy Server: `<your TeamXX-SGW FQDN>`
   - Port: `8080`
3. In COM **Servers → Add server**
   - **Server connection type**: *Secure gateway* (select your gateway)
   - **Authentication mode**: *Activation key*
   - Key validity: 30 minutes; use existing subscription key
4. Generate key → in iLO **Enable → Enter Activation Key → Save**
5. Confirm **Connection Status: Connected (Connection Type: Secure Gateway)** and review server details in COM. citeturn1search1

---

## Summary
You have:
- Managed an HPE ProLiant server with **iLO 7**.
- Verified firmware integrity and tightened iLO security posture.
- Onboarded the server to **HPE GreenLake / COM**.
- Implemented **ACME** to automate TLS certificates for iLO.
- Deployed and used the **COM Secure Gateway** for secure, optimized connectivity. citeturn1search1

---

## Additional Resources
- HPE iLO documentation & Security Technology Brief: https://www.hpe.com/info/iLO
- HPE GreenLake & Compute Ops Management: https://www.hpe.com/us/en/compute/management-software.html
- HPE Support Center (search **iLO 7 User Guide**, **Kerberos authentication**): https://support.hpe.com/ 

*Replace any lab‑specific credentials, IPs, and URLs with values from your event/instructor when sharing publicly.* citeturn1search1
