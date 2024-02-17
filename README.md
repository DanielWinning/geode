# Geode

The easy server management and setup tool.

## Introduction

Geode is a command line tool designed to simplify the process of setting up and managing servers. Simply create a new server 
and run the installer to get started.

## Installation

### System Requirements

- Ubuntu 20.04 LTS or greater

### Install

- Create a new Linux server on your desired hosting provider (e.g. DigitalOcean, Azure, AWS, etc.)
- Connect to your server via SSH as the root user (`ssh root@<ip-address>`)
- Run the following command:

```shell
curl https://raw.githubusercontent.com/DanielWinning/geode/main/install/install.sh | bash
# curl https://pkg.dannyxcii.co.uk/get/geode | bash
```

This installs the `geode` command to your system.

## How To Use

Geode contains various commands to help you manage your server. To see a list of available commands, run `geode help`.