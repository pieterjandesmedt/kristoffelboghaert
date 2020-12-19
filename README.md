# kristoffelboghaert.be

## Installation

Clone this repository

```sh
git clone git@github.com:pieterjandesmedt/kristoffelboghaert.git
```

Install the AWS CLI to sync images.

```sh
brew install awscli
```

Install imagemagick for resizing images.

```sh
brew install imagemagick
```

Install exiftool for getting information from images.

```sh
brew install exiftool
```

Install node.js to install and run sqip.

```sh
brew install node
```

Install sqip for generating the Low Quality Image Previews.

```sh
npm install -g sqip-cli@canary
```


## Deployment

### Configure AWS

Create an environment variables file `.env` with these contents:

```
AWS_ACCESS_KEY_ID=<keyId>
AWS_SECRET_ACCESS_KEY=<keyValue>
AWS_DEFAULT_REGION=eu-west-3
```

Run the push command to deploy.

##
