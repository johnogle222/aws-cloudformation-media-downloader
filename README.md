# Media Downloader

A media downloader designed to integrate with [it's companion iOS App](https://github.com/j0nathan-ll0yd/ios-OfflineMediaDownloader). It is [serverless](https://aws.amazon.com/serverless/), deployed with [AWS CloudFormation](https://aws.amazon.com/cloudformation/), and built with [TypeScript](https://www.typescriptlang.org/).

## Background

When [YouTube Premium](https://en.wikipedia.org/wiki/YouTube_Premium) was released they announced "exclusive original content, access to audio-only versions of videos and offline playback on your mobile device." I wasn't interested in the content, but I was excited about offline playback due to poor connectivity when commuting via the [MUNI](https://www.sfmta.com/). However, there was a monthly fee of $11.99.

So, [as an engineer](https://www.linkedin.com/in/lifegames), I used this opportunity to build my own media downloader service, experiment with the latest AWS features, along with a [companion iOS App](https://github.com/j0nathan-ll0yd/ios-OfflineMediaDownloader) using SwiftUI and Combine.

The end result is a generic backend infrastructure that could support any number of features or Apps. This repository is the source code, CloudFormation templates, deployment scripts, documentation and tests that power the App's backend. This includes:

* The ability to download videos and have them stored to an S3 bucket.
* The ability to view downloaded videos (via API).
* The ability to register for and dispatch push notifications to the mobile App.
* It also has a custom authorizer Lambda function that supports query-based API tokens. This was needed for integration with Feedly.

I share this for any engineer to be able to build a basic backend and iOS App for a future pet project or idea.

## Project Tenants

* The costs per month should be less than $12.
* Minimize external dependencies.
* [Convention over configuration](https://en.wikipedia.org/wiki/Convention_over_configuration). Minimize code, leverage AWS services.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

```bash
nvm use 10.16.3
npm install --prod=only
npm run build

# deploy the cloudformation template and associated code
npm run deploy-node-modules
npm run deploy-cloudformation

# verify the application works locally
npm run test-local-list
npm run test-local-hook
```

This will deploy the CloudFormation stack to AWS.

## Installation

* Install the [Node Version Manager](https://github.com/creationix/nvm). This will allow you to download the specific version of NodeJS supported by AWS Lambda (8.10).

```bash
brew install nvm
nvm install lts/erbium
nvm use lts/erbium
```

* Install the [Official Amazon AWS command-line interface](https://aws.amazon.com/cli/). [Configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) for your AWS account.

```bash
brew install awscli
aws configure
```

* Install [AWS Serverless Application Model (SAM)](https://github.com/awslabs/aws-sam-cli/). This is for developing on your local environment.

```bash
brew tap aws/tap
brew install aws-sam-cli
```
* Install [jq](https://stedolan.github.io/jq/) (used for deployment scripts)

```bash
brew install jq
```
* Install [md5sha1sum](http://microbrew.org/tools/md5sha1sum/) (used for deployment scripts)

```bash
brew install md5sha1sum
```
* Install [yq](https://mikefarah.github.io/yq/) (used for deployment scripts)

```bash
brew install yq
```

## Deployment

* Deploy CloudFormation - This will deploy your entire CloudFormation template, including your `node_modules` and latest Lambda function code.

```bash
npm run deploy-cloudformation
```

* Deploy Lambda - If there are no changes to your CloudFormation template, you can deploy just your latest source code to your stack.

```bash
npm run deploy-code
```

* Deploy `node_modules` - If changes are made to your package dependencies, you can upload your `node_modules` and update all associated lambda functions.

```bash
npm run deploy-node-modules
```
## Local Testing

Locally test the listing of files

```bash
npm run test-local-list
```

Locally test the feedly webhook

```bash
npm run test-local-hook
```

### Live Testing

In order to test your endpoint in production, you can use the npm commands below.

Remotely test the listing of files

```bash
npm run test-remote-list
```

Remotely test the feedly webhook

```bash
npm run test-remote-hook
```

Remotely test the register device method for registering for push notifications on iOS

```bash
npm run test-remote-registerDevice
```
