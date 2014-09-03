# Getting started with [Pivotal Web Services][pws] (PWS) on Rails

PWS is an installation of [Cloud Foundry][cf] that we host, similar to [Heroku][heroku]. You might use this tutorial if, for example, you know your Labs project wants to host on PWS but you're not sure where to start.

## This is internal

There is a public-facing Getting Started with Rails on PWS guide (not available at time of writing) that details much of the process required to get started with PWS, including command line usage and project setup.

This tutorial is streamlined for Pivots who are familiar with Rails but not with [PWS][pws]. It includes extra information such as [how to request sponsorship for your organization][sponsorship].

## Prerequisites

You should have the Cloud Foundry client CLI `cf` available in your PATH and up-to-date. If you don't, see the public tutorial first. If you installed it with rubygems, chastise thyself and uninstall it again: the CLI is now written in Go.

## 5 minute cheesy start

Clone this repo.

`git clone https://github.com/pivotal-cf-experimental/pivot_pws_tutorial_rails`

Start the app locally.

`cd pivot_pws_tutorial_rails`
`rails server`

## Sponsorship

Any Labs project is eligible for its PWS costs to be covered by a sponsorship during its engagement. Once the project is handed off, the sponsorship will end and the client will be responsible for paying each PWS bill.

[pws]:https://run.pivotal.io/
[cf]:http://cloudfoundry.org/
[heroku]:https://www.heroku.com/
[sponsorship]:#sponsorship
