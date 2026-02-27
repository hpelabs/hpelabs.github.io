---
layout: page
title: "Lab Website Local Development and Publishing Guide"
sitemap: false
noindex: true
permalink: /install-instructions/
---


This guide explains how to set up your local development environment to build, edit, and publish updates to the **hpelabs.github.io** lab website.

It walks you through installing the required tools (Git and Docker) on a Windows machine, running the website locally using a Docker-based Jekyll environment, previewing your changes in real time, and publishing updates to GitHub.

Once configured, you will be able to:

- Clone the repository locally
- Preview lab guide changes instantly
- Edit content using VS Code
- Publish updates to the public website

The setup only needs to be completed once. After that, your workflow will be limited to pulling updates, editing content, and pushing changes.


# Installation Guide

## 1. Install Required Software

* Install **VS Code**: [https://code.visualstudio.com/docs/?dv=win64user](https://code.visualstudio.com/docs/?dv=win64user)
* Install **Git for Windows**:
  [https://github.com/git-for-windows/git/releases/download/v2.53.0.windows.1/Git-2.53.0-64-bit.exe](https://github.com/git-for-windows/git/releases/download/v2.53.0.windows.1/Git-2.53.0-64-bit.exe)
* Install **Docker Desktop for Windows** (make sure the **WSL option** is enabled during installation):
  [https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-win-amd64](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-win-amd64)

> **Restart your laptop** when prompted.



## 2. First Docker Launch

After restarting:

* Docker will automatically install **WSL** if it is not already installed.
* When Docker starts:

  * Accept the license agreement.
  * Skip the registration step.
  * Wait for the Docker engine to fully start.



## 3. Clone the Repository and Start Docker

1. Open **VS Code**.
2. Open a terminal inside VS Code (`View → Terminal`).
3. Navigate to the folder where you want to clone the website.
4. Run the following commands in **the VS Code terminal**:

    ```bash
    git clone https://github.com/hpelabs/hpelabs.github.io.git .

    docker build -t myjekyll:latest .

    docker run --rm -it -p 4000:4000 -p 35729:35729 -v "${PWD}:/srv/jekyll" myjekyll:latest
    ```

    > **Tip:** Running Docker in the VS Code terminal keeps your workflow in a single environment and allows you to see logs and errors immediately.



## 4. Access the Website Locally

Once the Docker container is running, open your browser and go to http://localhost:4000

You can now browse a live copy of the website locally.


> ⚠️ **Troubleshooting**
>
>{: .small-space}
>
> If the website does not load, replace `${PWD}` in the `docker run` command with the full path to your cloned repository, for example: `C:\Users\YourName\hpelabs.github.io`

## 5. Configure Git for GitHub

Before you can push edits, Git must be configured with your GitHub credentials.

> **Important:** Make sure you have shared your GitHub username with me so I can add you as a collaborator.

> **Note:** If you do not yet have a GitHub account, create one using your HPE email address.

### Configure Git

Run the following commands in the VS Code terminal:

```bash
git config --global user.name "<github_user>"
git config --global user.email "<github_email>"
```

### Push Your First Changes

After configuring Git, you can push your changes:

```bash
git push
```

A window will appear prompting you to authenticate with GitHub. Follow the instructions.



## 6. Sync Your Local Repository

Before editing, make sure your local repository is up to date:

```bash
git pull origin main
```

* This fetches the latest changes from GitHub and merges them into your local branch.

> **Tip:** Always pull before starting new edits to avoid conflicts.

You can also use **VS Code Source Control**:

1. Open the **Source Control** panel (`Ctrl + Shift + G`).
2. Click the **… → Pull** (or **Sync Changes** if you have local commits).

    [![]( {{ site.baseurl }}/assets/images/instructions/image-2.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/instructions/image-2.png){:class="img-600"}{: data-lightbox="gallery"}


## 7. Edit the Website

* Open the folder where the website was cloned in VS Code.
* Open a terminal in VS Code (`View → Terminal`) — Docker should already be running.
* Edit lab guides as needed.

> **Tip:** Each time you press **CTRL + S**, the website will automatically refresh in your browser.



## 8. Publish Your Changes Using VS Code Source Control

1. **Open Source Control** (`Ctrl + Shift + G`).
2. **Stage Your Changes**

   * Click the **+** icon next to individual files, or
   * Click **+ (Stage All Changes)** at the top.
3. **Commit Your Changes**

   * Enter a meaningful commit message (e.g., "Updated COM Zero-Touch lab guide screenshots")
   * Click **Commit**.
4. **Push to GitHub**

   * Click **Sync Changes** (or **… → Push**)
   * Authenticate with GitHub if prompted.

    [![]( {{ site.baseurl }}/assets/images/instructions/image-3.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/instructions/image-3.png){:class="img-600"}{: data-lightbox="gallery"}

> **Recommended Workflow:** Always pull the latest changes before editing and commit/push frequently.




# Information

## 📁 Folder Structure

### Photos Location

All lab images must be stored in `\assets\images\HOLs\<lab_name>`

### Lab Guide Markdown Location

Lab guides must be created in `\_posts\<date>-<lab-title>.md`

Where:

- `<date>` format: `YYYY-MM-DD`
- `<lab-title>`: lab title **without spaces** (use -  instead)
- Example `\_posts\2026-02-16-PowerShell-COM-Zero-Touch.md`

[![]( {{ site.baseurl }}/assets/images/instructions/image-1.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/instructions/image-1.png){:class="img-100pct"}{: data-lightbox="gallery"}



## 🖼 Adding Images in Markdown

Always use the following format when inserting images

(includes border styling, zoom capability, and size control):

```markdown
[![]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image7.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/HOLs/COM-ZeroTouch/image7.png){:class="img-500"}{: data-lightbox="gallery"}
```

### Supported Image Sizes in {:class="img-xxx"}

- `img-300`
- `img-400`
- `img-500`
- `img-600`
- `img-700`
- `img-800`
- `img-900`
- `img-100pct` (full width)



## 📝 Mandatory Markdown Metadata (Front Matter)

The first section of every lab guide markdown file must contain metadata.

This section is mandatory and controls how the website displays your lab.

```yaml
---
layout: post
title: "HPE Compute Ops Management Zero-Touch Automation"
image: /assets/images/HOLs/COM-ZeroTouch/banner.jpg
post_end_promo: <i><b>Continue your journey with more HPE Compute Technical Enablement Hands-on Labs for infrastructure, security, technologies, and solutions.</b></i>
excerpt: Learn to automate HPE server lifecycle management using the HPE Compute Ops Management PowerShell module—from workspace provisioning and device onboarding to policy enforcement, compliance monitoring, and sustainability insights within HPE GreenLake.
---
```

### Metadata Fields Explained

- **post_end_promo**
    
    Adds a final promotional line at the end of your lab guide.
    
- **excerpt**
    
    Adds a short introduction displayed on the homepage.
    
- **image**
    
    Banner image displayed:
    
    - In the header of your lab guide
    - On the homepage preview card

    [![]( {{ site.baseurl }}/assets/images/instructions/image-4.png){: .bordered-image-thin}]( {{ site.baseurl }}/assets/images/instructions/image-4.png){:class="img-800"}{: data-lightbox="gallery"}


## 🎨 Generating a Banner Image

You can use Google Gemini to generate your own banner image.

Example prompt:

> Generate a photorealistic image of [subject].
> 
> 
> Shot with a DSLR camera, 50mm lens, natural lighting, high dynamic range, ultra-detailed, realistic skin texture, sharp focus.
> 
> Export as JPEG with high compression, optimized for web.
> 
> Target file size under 300 KB and sized 1920 x 1282.
> 

After generation:

- Save the file as `banner.jpg`

- Store it in `\assets\images\HOLs\<lab-name>\`

