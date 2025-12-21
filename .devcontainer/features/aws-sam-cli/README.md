# AWS SAM CLI Feature

This Dev Container feature installs the AWS Serverless Application Model (SAM) CLI, which provides a local development and testing environment for serverless applications.

## Description

AWS SAM CLI is a command-line tool for building, testing, and deploying serverless applications defined with AWS SAM templates. This feature automatically installs the appropriate version of SAM CLI for your container's architecture.

## Usage

Add this feature to your `devcontainer.json`:

```json
{
  "features": {
    "./features/aws-sam-cli": {
      "version": "latest"
    }
  }
}
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `version` | string | `latest` | The version of AWS SAM CLI to install |

## Supported Architectures

- x86_64 (amd64)
- arm64 (aarch64)

## What Gets Installed

- AWS SAM CLI binary (`sam` command)
- All required dependencies

## Installation Details

The feature:
1. Detects the container's architecture (x86_64 or arm64)
2. Downloads the appropriate AWS SAM CLI distribution from GitHub releases
3. Extracts and installs the CLI to system directories
4. Verifies the installation by checking the `sam --version` output

## Verification

After the container is built, verify the installation:

```bash
sam --version
```

## Official Documentation

For more information about AWS SAM CLI, see:
- [AWS SAM Documentation](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html)
- [AWS SAM CLI Installation Guide](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html)

## Common Commands

```bash
# Initialize a new SAM application
sam init

# Build your application
sam build

# Test your application locally
sam local invoke

# Deploy your application
sam deploy

# Delete your application
sam delete
```
