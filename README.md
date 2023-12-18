# Launch a MediaWiki server

## MediaWiki
MediaWiki is a freely available, open-source software specifically designed for creating and managing wiki-based websites. Notably, it powers some of the most recognized wikis on the web, including Wikipedia, Wiktionary, and Wikimedia Commons.

In this tutorial, we'll be integrating MediaWiki as a standalone node within your microservice architecture.

To make the process even simpler, we will deploy our MediaWiki instance using an acorn image.

## What is Acorn? 
Acorn is a new cloud platform that allows you to easily deploy, develop and manage web services with containerization.  A single acorn image can deploy all that you need: from a single container webserver, to a multi service Kubernetes cluster with high availability.  Don't worry if you don't understand what all those terms mean; we don't have to know that in order to deploy our server.

## Setup Acorn Account
Setup an acorn account at [acorn.io](https://acorn.io).  This can be a free account for your first deployment, and if you'd like additional storage space you can look into the pro account or enterprise.  You will need a Github account to signup as shown in the image below.

![signin_acorn](https://github.com/randall-coding/opensupports-docker/assets/39175191/d46815fb-d2d5-42cd-b93d-41ca541a63bd)

## Install acorn cli 
First we need to install acorn-cli locally.  Choose an install method from the list below:

**Linux or Mac** <br>
`curl https://get.acorn.io | sh`

**Homebrew (Linux or Mac)** <br>
`brew install acorn-io/cli/acorn`

**Windows** <br> 
Uncompress and move the [binary](https://cdn.acrn.io/cli/default_windows_amd64_v1/acorn.exe) to your PATH

**Windows (Scoop)** <br>
`scoop install acorn`

For up to date installation instructions, visit the [official docs](https://runtime-docs.acorn.io/installation/installing).

## Login with cli
Back in our local command terminal login to acorn.io with: <br>
`acorn login acorn.io` 

## Deploying Acorn
Now that we have the acorn cli configured, we can create and deploy our acorn image with a few simple commands.  You can modify the volume size (5Gi) or container RAM (2Gi) by editing the `run` command.

`acorn build -t mediawiki`

`acorn run -n mediawiki --memory=1Gi mediawiki`

Visit your dashboard to see if your deployment was successful.

Click on the mediawiki deployment, and find the endpoint section on the right side panel.  This is your mediawiki instance link.

![acorn_app_solr](https://github.com/randall-coding/solr-acorn/assets/39175191/c2d89fe2-8be8-4b9d-9c90-c7e0720bba03)

![endpoint_solr](https://github.com/randall-coding/solr-acorn/assets/39175191/61aca5eb-c924-4dbe-a46d-5669e6658b19)

If there are any errors check your acorn via the UI or with the following command:

`acorn logs -f mediawiki`

## Configure MediaWiki

Paste the mediawiki instance endpoint into your browswer. On the first page click the "set up the wiki" link to begin the installation wizard of mediawiki.

<img width="1118" alt="image" src="https://github.com/randall-coding/mediawiki-private/assets/23367718/e9d0f326-50a9-4982-b3dc-8d15fe6f9935">

Click on the 'complete the installation' link.

Then, configure the database according to this:
- Choose MariaDB
- Fill in the database information:
  - Database Server: `mariadb`
  - Database Name: `my_wiki`
  - Database User: `wikiuser`
  - Database Password: `secretpassword`

- Next setup a wikimedia account:
  - Insert a name for your WikiMedia
  - Put your username
  - Password

On the install page click "Continue"

After doing all the installation tasks, you will be provided a `LocalSettings.php` file to download. This contains all your configuration that you filled in during the mediawiki installation.

Now take that `LocalSettings.php` file and ssh into your new server by using acorn CLI:

```
acorn exec mediawiki bash
```

Then press 'enter' to select the first container.

When you land on the bash:

```bash
nano /var/www/html/LocalSettings.php
```

Now Copy and paste the contents of downloaded `LocalSettings.php`, then save the file by pressing `CTRL + O`.

Then, go to your mediawiki instance link, and you'll see mediawiki homepage and that means we've successfully installed mediawiki using acorn.

## Conclusion
That's all there is to it.  We've now got a wikimedia server up and running from an acorn image.

## References
* [Getting started with Acorn](https://docs.acorn.io/getting-started)
