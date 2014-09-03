# Getting started with [Pivotal Web Services][pws] (PWS) on Rails

PWS is an installation of [Cloud Foundry][cf] that we host, similar to [Heroku][heroku]. You might use this tutorial if, for example, you know your Labs project wants to host on PWS but you're not sure where to start.

## This is internal

There is a public-facing Getting Started with Rails on PWS guide (not available at time of writing) that details much of the process required to get started with PWS, including command line usage and project setup.

This tutorial is streamlined for Pivots who are familiar with Rails but not with [PWS][pws]. It includes extra information such as [how to request sponsorship for your organization][sponsorship].

There are a few assumptions in this tutorial. It's up to the reader to work around them to suit the project:

- You want to use a postgres database
- You want to use a database at all

## Prerequisites

You should have:

- The Cloud Foundry client CLI `cf` available in your PATH and up-to-date.
- A PWS account

If you installed `cf` with rubygems, chastise thyself and uninstall it again: the CLI is now written in Go.

If you installed `cf` with Homebrew, chastise thyself and [download it through the Developer Console][tools].

For a guide to setting these things up, see [Getting Started with Pivotal Web Services][pws-getting-started].

## Setting up the app locally

Clone this repo. It's really just the result of `rails new app_name --database=postgresql`. You could do that instead if you liked.

```sh
git clone https://github.com/pivotal-cf-experimental/pivot_pws_tutorial_rails
```

Start the app locally.

```sh
cd pivot_pws_tutorial_rails
bin/rails server
```

Looks like you need a database. Do as Rails says to get a local one. Refresh the page. You should now see the vanilla Rails "Welcome aboard" message.

## Log in with the CLI

```sh
cf login -a api.run.pivotal.io
```

Fill in your credentials and choose the org you wish to deploy your app into. Unless you have more than one space, you'll probably be placed into the 'development' space. This is fine for the tutorial.

Let's see what apps are in the space.

```sh
cf apps
```

You may well get 'No apps found'. Let's change that.

```sh
cf push
```

Oh no! Looks like App name is a required field. You could stick this in a manifest.yml, but let's just provide it on the command line for now.

```sh
cf push $YOUR_UNIQUE_APP_NAME
```

If all went well, you should see lots of output and then a summary of the pushed app's status.

```
requested state: started
instances: 1/1
usage: 1G x 1 instances
urls: your-unique-app-name.cfapps.io

     state     since                    cpu    memory        disk
#0   running   2014-09-03 12:06:33 PM   0.0%   93.3M of 1G   89.2M of 1G
```

The app is running on PWS. Congrats!

### Something failed

If you get a message like this:

`
Server error, status code: 400, error code: 100005, message: You have exceeded your organization's memory limit.
`

…then you probably ran out of trial and need your org to be [sponsored][sponsorship].

## Visiting the site after the first push

Visiting your shiny new site will result in the familiar Rails 500 page. Let's dig into what might be going wrong.

Start tailing the app's logs.

```sh
cf logs $YOUR_UNIQUE_APP_NAME
```

Then refresh your browser. You'll see some output in the shell.

`2014-09-03T12:16:21.86+0100 [RTR]     OUT pivot-pws-tutorial-rails.cfapps.io - [03/09/2014:11:16:21 +0000] "GET / HTTP/1.1" 500 1477 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.78.2 (KHTML, like Gecko) Version/7.0.6 Safari/537.78.2" 10.10.2.122:18974 x_forwarded_for:"87.115.116.242" vcap_request_id:96f637b7-36f3-4f52-6f1f-1ed19e033656 response_time:0.008857278 app_id:cf33229e-b7b9-4636-a17d-0f3bbb70e0bd`


This does confirm that we're getting a 500, but since Rails is running in production mode, it's not dumping backtraces to STDOUT or STDERR. We'll need to pull the production.log.

```sh
cf files $YOUR_UNIQUE_APP_NAME app/log/production.log
```

Inside the backtrace should be something along these lines:

```sh
PG::ConnectionBad (could not connect to server: No such file or directory
	Is the server running locally and accepting
	connections on Unix domain socket "/var/run/postgresql/.s.PGSQL.5432"?
):
```

Indeed, we haven't set up a database on PWS.

## Adding a database

## Sponsorship

Any Labs project is eligible for its PWS costs to be covered by a sponsorship during its engagement. Once the project is handed off, the sponsorship will end and the client will be responsible for paying each PWS bill.

[pws]:https://run.pivotal.io/
[pws-getting-started]:http://docs.run.pivotal.io/starting/
[tools]:https://console.run.pivotal.io/tools
[cf]:http://cloudfoundry.org/
[heroku]:https://www.heroku.com/
[sponsorship]:#sponsorship
