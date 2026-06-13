# Resources to learn
- https://notes.kodekloud.com/docs/HashiCorp-Certified-Terraform-Associate-004/Course-Introduction/Course-Introduction/page

# Terraform Extensions to Install

[Terraform Extension](./screenshots/TerraformExtension.png)

![Terraform Extension](./screenshots/TerraformExtension.png)

# Resources to learn
*** Terraform can actually spin up vms through Proxmox ***
*** Terraform can be used in local testing using AWS emulators like localstack, ministack, floci ***

List of available local AWS emulators:
- https://github.com/ministackorg/ministack
- https://github.com/floci-io/floci
- https://github.com/localstack/localstack

LocalStack Explained: Simulate AWS Services for Seamless Development:
https://www.youtube.com/watch?v=_PD4j5Ra3kY

Run 45 AWS Services Locally FREE: Floci, Quarkus and GraalVM-Powered, LocalStack Alternative (#96):
https://www.youtube.com/watch?v=dvyDakgeMig

# Terraform Foundations
## Section Introduction Terraform Foundations

### What is Terraform?
Key verbs you’ll use frequently:
- terraform init — initialize a working directory
- terraform plan — preview changes before applying
- terraform apply — execute the planned changes
- terraform destroy — remove managed infrastructure

### (Skip) Why organizations use Terraform

### Core Terraform concepts
Concept           Purpose                               Example/Notes
Configuration     Declare resources and settings        Files with .tf using HCL (HashiCorp Configuration Language)
Provider          Plugin for a target platform          provider "aws" { region = "us-east-1" }
Resource          A managed infrastructure object       resource "aws_instance" "web" { ... }
State             Maps config to real resources         Stored locally or remotely (S3, Terraform Cloud)
Plan/Apply        Preview and enact changes             terraform plan → terraform apply
Module            Reusable configuration unit           Local or registry-based modules for reuse

Terraform state contains the authoritative mapping of resources. Protect and manage state carefully (use remote backends and locking for teams) to avoid resource drift and corruption.

### How Terraform improves workflows
- Automation and CI/CD: Integrate Terraform into pipelines to provision and update infrastructure automatically.

- Collaboration: Use remote state backends and workspaces to coordinate changes among teams.

- Drift detection: terraform plan surfaces differences between configuration and real infrastructure.

- Idempotence: Reapplying the same configuration converges the environment to the declared state.
​
### Common usage pattern
1. Write configuration (*.tf files).
2. Initialize the working directory:
- terraform init

3. Validate and preview changes:
- terraform validate
- terraform plan

4. Apply changes:
- terraform apply

5. Maintain and update through version control and CI.

# Extra
# single-line comment
block_type "block_label" "block_label" {
    first_argument  = expression or value
    second_argument = expression or value
    third_argument  = expression or value
}

# main.tf
# Retrieve the list of AZs in the current AWS region
# data blocks
data "aws_availability_zones" "available"
data "aws_region" "current" {}

# Define the VPC
# resource block
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  # arguments
  tags = {
    Name        = var.vpc_name
    Environment = "demo_environment"
    Terraform   = "true"
  }
}

# Block Example breakdown
# Type of block
resource 

# Resource Type
"aws_vpc"

# Name (Need to be unique name)
"vpc"


# Core Components
## Terraform Core
CLI tool that provisions and manages infrastructure resources as
defined in Terrafrom configuration files

## Providers
Extends the functionality of Terraform for specific platforms, such as
public cloud providers, SaaS offerings, etc.

## Resources
Infrastructure components or services that are managed by Terraform
(virtual machines, networks, DNS records, etc)

## State
How Terraform maps the desired configuration with real-world
resources on the target platform

## Modules
Reusable and sharable blocks of code that can be called over and over again

## Intro to the Terraform Workflow

[Slide](./screenshots/DevelopingTFConfiguration.png)

![Slide](./screenshots/DevelopingTFConfiguration.png)

## Terraform Init

[Slide](./screenshots/TerraformInit.png)

![Slide](./screenshots/TerraformInit.png)

[Slide 2](./screenshots/TerraformLockFile.png)

![Slide 2](./screenshots/TerraformLockFile.png)

[Slide 3](./screenshots/TerraformDirectory.png)

![Slide 3](./screenshots/TerraformDirectory.png)

[Slide 4](./screenshots/TerraformDirectory.png)

![Slide 4](./screenshots/TerraformDirectory.png)

[Slide 5](./screenshots/WorkingWithTerraformDirectory.png)

![Slide 5](./screenshots/WorkingWithTerraformDirectory.png)

## Terraform Plan

[Slide](./screenshots/TerraformPlan.png)

![Slide](./screenshots/TerraformPlan.png)

[Slide 2](./screenshots/TerraformPlanTwo.png)

![Slide 2](./screenshots/TerraformPlanTwo.png)

[Slide 3](./screenshots/TerraformPlanThree.png)

![Slide 3](./screenshots/TerraformPlanThree.png)

[Slide 4](./screenshots/TerraformPlanFour.png)

![Slide 4](./screenshots/TerraformPlanFour.png)


1) Should the .terraform directory be in version control?
- No, add to your .gitignore file
- Contains easily recreatable files
- Can be large in size and contain platform-specific files

2) Can you delete the .terraform directory?
- Technically,yes
- Run terraform init to create it
- Useful for troubleshooting or cleaning up old dependencies

# Terraform Plan