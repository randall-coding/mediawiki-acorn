# Launch a MediaWiki server

## MediaWiki
[MediaWiki](https://www.mediawiki.org/wiki/MediaWiki) is a freely available, open-source software for creating and managing wiki-based websites. Notably, it powers some of the most recognized wikis on the web, including Wikipedia, Wiktionary, and Wikimedia Commons.  A wiki, for those who don't know, is a collaborative informational website about your company or product (or anything really). Think Wikipedia, but specific to your domain.

In this tutorial, we'll be integrating MediaWiki as a standalone node within a microservice architecture.

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

## Preparing Secrets File
Your server has settings controlled by a secret file:  
 * **db_password** - your chosen database password

Create secrets for your application using acorn-cli.  Change the <> values to your actual credentials.
```
acorn secret create \
 --data db_password=<password> \
   mediawiki
```

## Deploying Acorn
Now that we have the acorn cli configured, we can create and deploy our acorn image with a few simple commands.  You can modify the container RAM by editing the `run` command.

`acorn build -t mediawiki`

`acorn run -s mediawiki:mediawiki -n mediawiki --memory=1Gi mediawiki`

Visit your dashboard to see if your deployment was successful.

Click on the MediaWiki deployment, and find the endpoint section on the right side panel.  This is your MediaWiki instance link.

![mediawiki_acorn_ui](https://github.com/randall-coding/mediawiki-private/assets/39175191/74333113-f0ab-40bd-8f08-404790eb48ad)

![mediawiki_endpoint](https://github.com/randall-coding/mediawiki-private/assets/39175191/680cbcc4-d95f-48c1-aa47-1c14ed1e31cf)

If there are any errors check your acorn via the UI or with the following command:

`acorn logs -f mediawiki`

## Configure MediaWiki

Go to the MediaWiki instance link and finish the installation wizard of MediaWiki.

![mediawiki_setup](https://github.com/randall-coding/mediawiki-private/assets/39175191/dad2b4f1-3e03-42a7-9b5e-be823d496d3b)

Click on the 'set up the wiki' link.

Click through the first series of setup steps until you reach the "**Connect to database**" step.

Configure the database as follows:
- Choose MariaDB
- Fill in the database information:
  - Database Host: `mariadb`
  - Database Name: `my_wiki`
  - Database User: `wikiuser`
  - Database Password: `<password from your secrets file>`

- On the "**Name**" setup step, create your wikimedia account:
  - Insert a name for your WikiMedia
  - Create a username
  - Add your password
  - Select "I'm bored already I want to install wiki"

After completing the installation tasks, you will be provided a `LocalSettings.php` file to download. This contains all your configuration that you filled in during the MediaWiki installation.

![mediawiki_localsettings](https://github.com/randall-coding/mediawiki-private/assets/39175191/14cae77f-ca7f-4835-a53d-8c626e7a641a)

Now take that `LocalSettings.php` file and ssh into your new server by using acorn CLI:
```
acorn exec mediawiki bash
```

Then press 'enter' to select the first container.

When you land on the bash:

```bash
nano /var/www/html/LocalSettings.php
```

And copy and paste the contents of downloaded `LocalSettings.php` into nano, then save the file by pressing `CTRL + O` and `enter` and `CTRL + X` to cancel.

Then, go to your MediaWiki instance endpoint, and you'll see MediaWiki homepage.  That means we've successfully installed MediaWiki using acorn.

<img width="1110" alt="image" src="https://github.com/randall-coding/mediawiki-private/assets/23367718/729dc539-a388-4f05-91b3-07e9499baafc">

## Conclusion
That's all there is to it.  Our MediaWiki server is up and running from an acorn image.  For more information on using your MediaWiki server, see the reference links below.

## References
* [Getting started with Acorn](https://docs.acorn.io/getting-started)
* [Getting started with MediaWiki](https://www.mediawiki.org/wiki/Documentation)
* [MediaWiki repository](https://github.com/wikimedia/mediawiki-docker)
* [MediaWiki docker image](https://hub.docker.com/_/mediawiki/)
