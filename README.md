# Virtual Psychologist Streamlit Chat Application based on ChatGPT

This Streamlit application allows users to have a conversation with a virtual psychologist powered by the OpenAI ChatGPT model. The user can enter their message in the text input field and the ChatGPT model will generate a response. This project includes a Streamlit-based chatbot operationalized in AWS using AWS ECS Fargate.

## Table of Contents

- [Virtual Psychologist Streamlit Chat Application based on ChatGPT](#virtual-psychologist-streamlit-chat-application-based-on-chatgpt)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
    - [CloudFormation Stack Deployment](#cloudformation-stack-deployment)
      - [CloudFormation Parameters](#cloudformation-parameters)
    - [Docker Image Build](#docker-image-build)
    - [Docker Container Run](#docker-container-run)
  - [Usage](#usage)
  - [Support](#support)
  - [Contributing](#contributing)

## Installation

### CloudFormation Stack Deployment

This CloudFormation template creates a Virtual Private Cloud (VPC) with four subnets (two public and two private), an Internet Gateway, and a NAT Gateway. It also creates four route tables (one for each subnet) and routes for each route table to direct traffic to the Internet Gateway or NAT Gateway as appropriate.

The VPC has a CIDR block of 10.0.0.0/16, and the four subnets are created with CIDR blocks of 10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24, and 10.0.4.0/24. The public subnets are mapped to have public IP addresses on launch, and the private subnets are not.

There are also a few parameters defined at the beginning of the template that allow the user to specify an allowed IP address range for accessing port 80 on the load balancer, the name of an Elastic Container Registry (ECR) repository, and the path to an API key in the SSM Parameter Store.

To deploy the CloudFormation stack for this project, use the `./cf.yaml` file. You can do this using the AWS Management Console, the AWS CLI, or the AWS SDKs.

#### CloudFormation Parameters

| Parameter | Description | Default Value |
| --- | --- | --- |
| AllowedIP | Comma-separated list of IP addresses that should be allowed to access port 80 on the load balancer | 0.0.0.0/0 |
| Repository | The name of the ECR repository | public.ecr.aws/a9t7y4w6/demo-chatgpt-streamlit:latest |
| ChatGptApiKeyPath | ChatGPT API Key path in SSM Parameter Store | /openai/api_key |

For example, to deploy the stack using the AWS CLI, you can use the following command with default values:

```bash
aws cloudformation create-stack \
  --stack-name chatgpt-streamlit \
  --template-body file://cf.yaml \
  --capabilities CAPABILITY_IAM
```

For example, to deploy the stack using the AWS CLI, you can use the following command with custom values:

```bash
aws cloudformation create-stack --stack-name chatgpt-streamlit \
  --template-body file://cf.yaml \
  --parameters ParameterKey=AllowedIP,ParameterValue=1.2.3.4/32 ParameterKey=Repository,ParameterValue=public.ecr.aws/a9t7y4w6/demo-chatgpt-streamlit:latest ParameterKey=ChatGptApiKeyPath,ParameterValue=/openai/api_key
```

This will create a new stack called `chatgpt-streamlit` using the `cf.yaml` template file and the `CAPABILITY_IAM` capability.

### Docker Image Build

To build the Docker image for this project, use the `Dockerfile` in the `./app` directory. You can do this using the `docker build` command.

For example, to build the image using the `Dockerfile` in the current directory, you can use the following command:

```bash
docker build -t chatgpt-streamlit .
```

This will build the image and tag it with the name `chatgpt-streamlit`.

### Docker Container Run

```bash
docker run -p 8501:8501 -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
  -e AWS_DEFAULT_REGION="us-east-1" \
  public.ecr.aws/a9t7y4w6/demo-chatgpt-streamlit:latest
```

## Usage

The Streamlit application is deployed in an AWS ECS cluster and is available through a web browser using the URL of the load balancer. To access the app, simply navigate to the URL in a web browser.

## Support

If you have any questions or encounter any issues while using the project, please don't hesitate to reach out. You can find contact information in the [CONTRIBUTING](#contributing) section below.

## Contributing

We welcome contributions to this project! If you would like to contribute, please follow these guidelines:

- Create an issue to discuss the change you would like to make.
- Once the change has been discussed and approved, you can submit a pull request.
- All pull requests should include tests to ensure that the code is working as intended.
- Once the pull request has been reviewed and accepted, it will be merged into the main branch.

Thank you for your interest in contributing to the project!
