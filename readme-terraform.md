# Resources to learn
Kodekloud notes:
- https://notes.kodekloud.com/docs/HashiCorp-Certified-Terraform-Associate-004/Course-Introduction/Course-Introduction/page

List of projects using localstack:
- https://docs.localstack.cloud/aws/sample-apps/

Sample React with Spring:
- https://github.com/localstack-samples/sample-terraform-fullstack-serverless-shipment-app
^
I am not familiar with:
- localstack CLI.
- AWS CLI with the awslocal wrapper.
- Terraform with the tflocal wrapper.
- make (optional, but recommended for running the sample application)

The application uses Spring Boot profiles (dev for LocalStack, prod for AWS) with different endpoint configurations (application-prod.yml, application-dev.yml), ensuring the same codebase works across both environments. Testcontainers integration provides additional validation that the LocalStack environment accurately emulates AWS behavior.
^
Follow below for the full picture of Java / Spring Boot development:
- https://github.com/Jojoooo1/project-assignment

For React:
- https://playfulprogramming.com/collections/framework-field-guide/

# Terraform Extensions to Install

[Terraform Extension](./screenshots/TerraformExtension.png)

![Terraform Extension](./screenshots/TerraformExtension.png)

[HCL Extension](./screenshots/HCLExtension.png)

![HCL Extension](./screenshots/HCLExtension.png)

# Resources to learn
*** Terraform can actually spin up vms through Proxmox ***

*** Terraform can be used in local testing using AWS emulators like localstack, ministack, floci ***

List of available local AWS emulators:
- https://github.com/ministackorg/ministack
- https://github.com/floci-io/floci
- https://github.com/localstack/localstack

LocalStack Explained: Simulate AWS Services for Seamless Development:
- https://www.youtube.com/watch?v=_PD4j5Ra3kY

Run 45 AWS Services Locally FREE: Floci, Quarkus and GraalVM-Powered, LocalStack Alternative (#96):
- https://www.youtube.com/watch?v=dvyDakgeMig

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
|Concept           |Purpose                               |Example/Notes |
| --- | --- | --- |
|Configuration     |Declare resources and settings        |Files with .tf using HCL (HashiCorp Configuration Language) |
|Provider          |Plugin for a target platform          |provider "aws" { region = "us-east-1" } |
|Resource          |A managed infrastructure object       |resource "aws_instance" "web" { ... } |
|State             |Maps config to real resources         |Stored locally or remotely (S3, Terraform Cloud) |
|Plan/Apply        |Preview and enact changes             |terraform plan → terraform apply |
|Module            |Reusable configuration unit           |Local or registry-based modules for reuse |

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

## (Skip) Introduction to Terraform

## Learn the Basics of HashiCorp Configuration Language HCL
HCL is declarative: you describe the desired end state (for example, “a VPC with CIDR 10.0.0.0/16”) and Terraform determines how to create or update resources to match that state. Think of it like ordering a dish at a restaurant — you specify the final result, not every step required to cook it.

### HCL structure and basic syntax
HCL configurations are organized into blocks that group related configuration items. Each block has:
- A block type (for example, resource, data, variable, output)
- One or more labels (for example, a resource type and an instance name)
- A body containing arguments and optionally nested blocks

Comments are supported and useful for documenting intent:
- Single-line comments: # or //
- Multi-line (block) comments: /* ... */

Example annotated HCL:
// single-line comment
block_type "block_label" "block_label" {
  first_argument  = expression_or_value
  second_argument = expression_or_value
  third           = expression_or_value
}

// Top-level assignments must appear inside appropriate blocks (for example, locals).
locals {
  attribute_abc = "value_1"
  attribute_2   = "value_2"
}

Files use the .tf extension (for example, main.tf). Terraform automatically loads .tf files in a directory as a single configuration.

### Common HCL block types (at-a-glance)
Block Type      Purpose                                                 Example
resource        Declares infrastructure to create and manage            resource "aws_instance" "web" { ... }
data            Reads information from existing infrastructure          data "aws_ami" "ubuntu" { ... }
variable        Declares input values for a module                      variable "aws_region" { type = string }
output          Exposes values from a module or root configuration      output "vpc_id" { value = aws_vpc.vpc.id }
locals          Defines local computed values                           locals { common_tags = { Environment = "dev" } }

### A real example: defining a VPC
Below is a compact, realistic Terraform configuration showing data sources and a resource block that defines an AWS VPC:

// Retrieve the list of availability zones in the current AWS region
data "aws_availability_zones" "available" {}

// Retrieve the current AWS region
data "aws_region" "current" {}

// Define the VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = var.vpc_name
    Environment = "demo_environment"
    Terraform   = "true"
  }
}

Key points:
- data blocks read existing information (e.g., AZs or AMIs).
- resource blocks declare resources Terraform will manage.
- Arguments inside resource blocks (like cidr_block) describe desired properties, not procedural steps.

Use terraform fmt or a Terraform-aware editor (for example, the VS Code Terraform extension) to keep formatting consistent automatically.

### Anatomy of a resource block
*** First label aws_vpc is tied to the provider ***

Question: How do I reference the correct resource from provider? Do I have to read the documentation?

Breakdown of the VPC resource block:
- resource — keyword indicating managed infrastructure.
- First label ("aws_vpc") — the resource type provided by the provider (AWS in this case).
- Second label ("vpc") — the local instance name that uniquely identifies this resource in the module.
- Body — arguments (like cidr_block) and nested blocks (like tags) describing the resource.

Reference a resource elsewhere using the canonical address resource_type.resource_name, for example aws_vpc.vpc. That address allows other resources, modules, and outputs to read attributes from the VPC.

Each resource name (the second label) must be unique per resource type within a module. For multiple VPCs use distinct names, for example:

resource "aws_vpc" "production" { ... }
resource "aws_vpc" "test"       { ... }

### (Copy Paste) HCL style recommendations

### (Copy Paste) Quick workflow (getting started)

### (Skip) Summary

## Lets Look at Resource Referencing with Demo
*** You can manage github repositories with terraform ***

*** I skip explanation on referencing because there was no example code ***

HCL demo: writing Terraform files in VS Code

This demo shows practical HCL examples and recommended workflow items (like using terraform fmt). The focus is on writing, referencing, and formatting HCL rather than provider-specific behavior.

1. Create a file named github.tf in your working directory. VS Code with a Terraform extension will provide syntax highlighting and snippets for provider and resource blocks.

2. Add a provider block that references a token variable:
```terraform
provider "github" {
  token = var.github_token
}
```

3. Define a repository resource. Each resource block is a combination of type and local name that forms the unique address used elsewhere in the configuration:
```terraform
resource "github_repository" "production-repo" {
  name        = "prod-repo"
  description = "Repo for our production app"
  private     = true
}
```

4. Add another repository using a different local name so both resources have unique addresses:
```terraform
resource "github_repository" "testing-repo" {
  name        = "test-repo"
  description = "Repo for our testing app"
  private     = true
}
```

Every resource instance in a Terraform configuration must have a unique address: the combination of its type and its local name (for example, github_repository.production-repo). Reusing the same local name for two instances of the same resource type will produce a configuration error.

Do not hard-code sensitive values (like provider tokens) directly in .tf files. Use input variables, terraform.tfvars, or environment variables (for example, TF_VAR_github_token) and store secrets in a secure secrets manager or CI/CD secret store.

Using terraform fmt to format HCL

Keep code readable and consistent with terraform fmt. It normalizes indentation and aligns assignment operators to Terraform’s canonical style.

Examples:
- Run the formatter across the working directory:
```bash
$ terraform fmt
github.tf
test.tf
```

- If only one file required formatting, the output might be:
```bash
$ terraform fmt
github.tf
```

Splitting resources across files

Terraform treats all .tf files in a directory as a single configuration. Use multiple files to organize resources logically — e.g., separate providers, networking, compute, and test resources.

Example file split:

test.tf:
```terraform
resource "github_repository" "testing-repo" {
  name        = "test-repo"
  description = "Repo for our testing app"
  private     = true
}
```
github.tf:
```terraform
provider "github" {
  token = var.github_token
}

resource "github_repository" "production-repo" {
  name        = "prod-repo"
  description = "Repo for our production app"
  private     = true
}
```
Running terraform fmt in the directory will scan and format all .tf files and report each file it modified.

Quick best practices

|Area	              |Recommendation|
| --- | --- |
| Referencing	      |Prefer using attributes from created resource or data blocks instead of hard-coded values|
| Secrets	Use       |variables and secure secret stores — avoid committing tokens to VCS|
| Formatting	      |Run terraform fmt regularly or enable automatic formatting in your editor|
| Organization	    |Group related resources into separate .tf files or modules for maintainability|

Wrap-up
- Resource referencing enables dynamic, maintainable Terraform configurations by passing values between blocks rather than hard-coding.
- Terraform uses references to build a dependency graph and determine the correct provisioning order.
- Maintain consistent style with terraform fmt, split files for clarity, and keep secrets out of source files.

## (Continue) Learn about Best Practices for HCL

## Core Components and Benefits of Terraform

### Summary Table
|Component           |Role                               |Example |
| --- | --- | --- |
|Terraform Core | Execution engine; builds dependency graph and applies changes | CLI commands: terraform init, terraform plan, terraform apply|
|Provider | Translates resources to API calls for a platform | provider "aws" { region = "us-east-1" }|
|Resource | Declares infrastructure objects to manage | resource "aws_instance" "web" { ... }|
|State | Persists mapping and metadata of managed resources | backend "s3" { ... }|
|Module | Reusable configuration package | module "vpc" { source = ".../vpc" }|

### Terraform Core
Terraform Core is the CLI binary that reads and interprets your Terraform configuration files (.tf). When you run terraform init, terraform plan, or terraform apply, you are interacting with Terraform Core. Its responsibilities include:

- Parsing configuration files and building a dependency graph.
- Comparing your declared configuration against the current state.
- Determining a plan of changes and orchestrating provider API calls to create, update, or destroy resources.

Terraform Core is provider-agnostic: it defines the workflow and execution model while delegating resource-specific operations to providers.

### Providers
Providers are plugins that extend Terraform Core with the logic to manage resources on a particular platform (AWS, Azure, Google Cloud, GitHub, etc.). Providers implement the mappings between Terraform resource declarations and platform API calls.

A minimal provider block:
```terraform
provider "aws" {
  region = "us-east-1"
}
```

Notes about providers:
- Version pin providers to ensure reproducible behavior.
- Providers may require credentials and specific configuration (environment variables, shared configs, or explicit blocks).
- Provider plugins are installed during terraform init.

### Resources
Resources are the primary declarations that describe the infrastructure objects Terraform will manage — compute instances, networks, databases, DNS records, and more. Each resource block contains arguments (inputs) and exposes attributes (outputs) that can be referenced elsewhere.

Example resource:
```terraform
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"

  tags = {
    Name = "example-web"
  }
}
```

Key resource concepts:
- Attributes such as IDs and computed values are stored in state and can be referenced using interpolation.
- Lifecycle meta-arguments (create_before_destroy, prevent_destroy) control how Terraform updates resources.
- Resource dependencies are inferred from references; explicit depends_on can enforce ordering when needed.

### State
Terraform state is the authoritative record of what Terraform manages in the real world. It maps resources in your configuration to real-world objects, stores metadata (IDs, attributes), and enables Terraform to compute incremental diffs.

State enables:
- Mapping real resources to configuration.
- Accurate planning and targeted updates.
- Sensitive metadata persistence (resource IDs, ARNs, endpoints).

Remote state and locking are critical for team workflows. Example S3 backend with DynamoDB locking:
```terraform
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "project-name/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}
```

Remote state backends enable team collaboration, state locking, and recovery. Use them for shared environments to avoid state conflicts and accidental overwrites.

Terraform state can contain sensitive information (secrets, IDs, endpoints). Use encrypted storage, restrict access, and avoid committing state files to source control.

### Modules
Modules are reusable, composable packages of Terraform configuration — the primary method to encapsulate and share common infrastructure patterns. Think of modules as functions or libraries for infrastructure.

Calling a module:
```terraform
module "vpc" {
  source = "git::https://example.com/terraform-modules.git//vpc"
  cidr   = "10.0.0.0/16"
  region = "us-east-1"
}
```

Module best practices:
- Keep modules focused and opinionated.
- Expose inputs (variables) and outputs (outputs) for composability.
- Version and publish modules (Terraform Registry, Git tags) for stability.

### Component Overview
- Terraform Core: Orchestrates the execution model and dependency graph.
- Providers: Implement API interactions for specific platforms.
- Resources: Declare the desired infrastructure objects.
- State: Records the current status and metadata of managed resources.
- Modules: Package reusable configuration patterns.

## (Skip) Which Terraform Version Should You Use 

## (Continue) Comparing Terraform to Other Tools

## (Continue) Declarative vs Imperative Why Terraform Works the Way It Does

# The Core Terraform Workflow

## (Continue) Section Introduction Terraform Workflow

```terraform
# Initialize the working directory (downloads providers, sets up backend)
terraform init

# Create and show an execution plan (safe preview of changes)
terraform plan

# Apply the planned changes (prompts for approval by default)
terraform apply

# Tear down managed infrastructure
terraform destroy
```

## (Continue) Intro to the Terraform Workflow

## Terraform Init
### Summary
- Run terraform init at the start of a project and whenever providers, modules, or backend configuration change.
- terraform init downloads providers and modules, configures the backend, creates/updates .terraform.lock.hcl, and populates the .terraform directory.
- Commit .terraform.lock.hcl to version control to ensure consistent provider versions across environments.
- Do not commit .terraform; add it to .gitignore and recreate it with terraform init if needed.

### What terraform init does
terraform init sets up the working environment by:

- Downloading provider plugins referenced in your configuration (for example, AWS, Azure, GCP).
- Fetching referenced modules from the Terraform Registry, Git, or other sources.
- Configuring the backend where the Terraform state is stored (local or remote backends such as S3, Azure Storage, etc.).
- Creating or updating the dependency lock file .terraform.lock.hcl to pin provider versions and checksums.

Think of terraform init as the foundation step — Terraform ensures all dependencies are available locally before any planning or applying occurs. The command is incremental: if you update a single provider, Terraform downloads only the changed provider and leaves other cached providers intact.

When to run terraform init:
- At the start of a new Terraform project.
- After adding, removing, or upgrading providers or modules.
- After changing backend settings.
- Any time you want to refresh locally cached dependencies.

[Terraform Lock File](./screenshots/TerraformLockFile.png)

![Terraform Lock File](./screenshots/TerraformLockFile.png)

Commit .terraform.lock.hcl to version control. It pins provider versions and checksums so every team member and CI run uses the same provider binaries, preventing “works on my machine” issues.

### The lock file:  .terraform.lock.hcl
Each run of terraform init will create or update a .terraform.lock.hcl file in your working directory (the same folder as your *.tf files). This lock file:

- Records provider versions and checksums selected during initialization.
- Ensures consistent provider selection across machines and CI runs.
- Is managed automatically by Terraform — do not edit it manually.

Best practice: include .terraform.lock.hcl in your repository so provider selection changes are visible in code reviews.

### (Continue) Example output from terraform init

## (Continue) Terraform Plan
*** The plan output is for audit purposes ***

Summary and best practices
- Treat terraform plan as a dry-run: it refreshes state, calculates the delta, and displays actions with clear symbols.
- Always review the plan before applying, especially in production environments.
- Use terraform plan -out=FILE to produce a saved, deterministic plan that can be reviewed and applied later.
- Be mindful of sensitive values: Terraform hides them in plan output.
- Pay attention to -/+ replacement annotations so you understand when resources will be destroyed and recreated.

## (Continue) Understanding the Resource Graph
### Summary
- Terraform automatically builds and walks a dependency graph from references in your configuration.
- File ordering does not control execution order — dependency references do.
- Use depends_on only when Terraform cannot infer the required ordering from references.
- Terraform executes resources in parallel where possible; default concurrency is 10, adjustable via -parallelism.
- A clear understanding of the resource graph explains how terraform plan generates an execution plan and why operations run in a particular order.

|Dependency type| How Terraform discovers it|When to use|Example|
| --- | --- | --- | --- |
|Implicit|Inferred from attribute references and data sources|Default; use whenever possible|vpc_id = aws_vpc.main.id|
|Explicit|Declared manually with depends_on|When there is an ordering requirement Terraform can’t infer|depends_on = [aws_db_instance.db]|

## (Continue) Terraform Apply

## (Continue) Terraform Destroy
### Summary
- terraform destroy removes all resources managed in the current workspace after showing a destruction plan and requiring confirmation.
- For selective removals, prefer deleting resource blocks and running terraform apply so your configuration remains the source of truth.
- Destroyed resources are removed from the Terraform state file.
- Targeted destruction (-target) can remove a specific resource quickly but may cause drift and should be used sparingly.
- Always double-check destruction plans and consider backups before proceeding in production.

## (Continue) Terraform Validate

# Terraform CLI

## (Continue) Section Introduction Terraform CLI

## (Continue) Introduction to the Terraform CLI

## (Important) Demo Terraform CLI 

## Making the Most of the Terraform CLI

## (Important) Demo Making the Most of the Terraform CLI

# Terraform File Structure and Organization

## (Important) Terraform File Structure and Organization

# Terraform Configuration - Fundamentals

## (Important) HCL Basics Understanding Block Structure

## (Continue) Connecting to Cloud Platforms with Provider Blocks
Question: Where does Kubernetes fit in cloud?

## (Continue) Creating Infrastructure with Resource Blocks
*** You need to consult Terraform registry for available resource types and argument details ***

*** I wonder if there's a way for me to read the Terraform registry with VScode ***

### Resource: aws_instance
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

### Argument Reference
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#argument-reference

Example: two EC2 instances:

```terraform
resource "aws_instance" "web" {
  ami           = "ami-012345"
  instance_type = "t2.micro"

  key_name  = "prd-web-key"
  subnet_id = "subnet-12345abc"

  tags = {
    Name = "prd-web-svr-01"
  }
}

resource "aws_instance" "db" {
  ami           = "ami-0c55b159"
  instance_type = "m5.4xlarge"
}
```

Example configuration for a production stack:

```terraform
resource "aws_lb" "public_load_balancer" {
  name               = "prd-web-lb"
  load_balancer_type = "network"
}

resource "fortios_firewall_policy" "allow_web_443" {
  action = "accept"
  name   = "allow_web_443"
}

resource "aws_instance" "web" {
  instance_type = "t3.large"
  ami           = "ami-0c55b159"
}

resource "aws_db_instance" "prd_db" {
  engine         = "mysql"
  instance_class = "db.t3.large"
}
```

- The aws_lb name value (prd-web-lb) is provider-visible and will appear in the AWS Console.
- Each block maps to a real-world component; together they create a functioning environment.

Example: create a GitHub repository, a branch, and set the default branch:

```terraform
resource "github_repository" "prod_repo" {
  name       = "prod-app-xyz-repo"
  visibility = "private"
}

resource "github_branch" "default" {
  repository = github_repository.prod_repo.name
  branch     = "main"
}

resource "github_branch_default" "default" {
  repository = github_repository.prod_repo.name
  branch     = github_branch.default.branch
}
```

## (Important) Defining Variable Types
### Summary
- The three primitive types (string, number, bool) form the foundation of Terraform variables.
- Lists, maps, and sets are the primary collection types; choose based on order, naming, and uniqueness requirements.
- Always reference variables as var.<name> and validate indexes and types before runtime.

## Assigning Variable Values and Understanding Precedence
### Summary and best practices
- Defaults: Use for safe, non-sensitive baselines and documentation.
- Environment variables: Use for secrets and CI/CD-injected values.
- .tfvars files: Use to group environment-specific settings; avoid committing secrets unless stripped.
- Command-line flags: Use for ad-hoc overrides and testing; remember these are highest precedence.
- Always follow the precedence rules above to avoid unexpected overrides during runs.

## Exposing Configuration Data with Output Values
### Summary
- output blocks provide a structured way to expose information from Terraform configurations.
- Outputs appear after terraform apply, are stored in state, and can be consumed by scripts, CI pipelines, and other modules.
- Use description and sensitive to make outputs easier and safer to use.
- Keep outputs focused on externally useful values and secure your state backend.

# Understading and Managing Terraform State
## (Continue) Remote State Configuration
*** This looks like the real meat of Terraform ***

# Terraform Modules
## Introduction to Modules
### (Skip) What is a module?

### (Skip) Benefits of using modules

### What does a module look like?
A module is simply a directory containing standard Terraform files. The most common layout is:
- main.tf — resources and core configuration
- variables.tf — input variables the module accepts
- outputs.tf — outputs the module exposes to callers
- (optional) versions.tf — provider and Terraform version constraints
- (optional) examples/ — example usage to help consumers

Example filesystem layout:
modules/
  tls/
    main.tf
    variables.tf
    outputs.tf
  load_balancer/
    main.tf
    variables.tf
    outputs.tf

Common module file types and purpose

| File | Purpose | Example |
| --- | --- | --- |
| main.tf | Define resources and composition | resource "aws_acm_certificate" "example" { ... } |
| variables.tf | Declare input variables and defaults | hcl variable "domain_name" { type = string } |
| outputs.tf | Expose values to calling module | hcl output "certificate_arn" { value = aws_acm_certificate.example.arn } |
| versions.tf | Lock Terraform and provider versions | hcl terraform { required_version = ">= 1.0.0" } |
| examples/ | Example root module demonstrating usage | examples/complete/main.tf |

Example: calling a local child module from a root module

```terraform
module "tls" {
  source = "./modules/tls"

  domain_name = "example.com"
  cert_tags   = {
    environment = "prod"
  }
}
```

Minimal variables.tf inside the module:

```terraform
variable "domain_name" {
  type        = string
  description = "Domain name for the TLS certificate"
}

variable "cert_tags" {
  type        = map(string)
  description = "Tags to apply to the certificate"
  default     = {}
}
```

Minimal outputs.tf inside the module:

```terraform
output "certificate_arn" {
  description = "The ARN of the TLS certificate"
  value       = aws_acm_certificate.example.arn
}
```

### ​Module sources and versioning
Modules can be sourced from several places: local paths, Git repositories, Terraform Registry, or other VCS. Always prefer versioned sources for reproducible builds when pulling remote modules.

Examples of module sources
| Source type | Example |
| --- | --- |
| Local path  | source = "./modules/network" |
| Git (with ref) | source = "git::https://github.com/example-org/terraform-modules.git//modules/postgres?ref=v1.2.0" |
| Registry | source = "app.terraform.io/example-org/mysql/aws" |
| Archive URL | source = "https://example.com/terraform-modules.tar.gz" |

When referencing remote modules, pin to a specific tag, branch, or commit using ?ref= to avoid accidental changes.

### (Skip) Declaring and using module blocks

### (Skip) Summary

## Understanding Parent and Child Modules

### (Copy pasted) Parent (root / calling) module — module block example

### (Copy pasted) Child module — structure, variables, resources, and outputs

### (Copy pasted) How root and child modules connect

### (Copy pasted) Passing values between modules

### (Skip) Benefits of a modular approach

## Module Versioning and Version Constraints

## Calling Modules with the Module Block

## Understanding Variable Scope in Modules

## Demo Using Modules from the Terraform Registry

## Demo Writing and Using Your Own Modules
### What you’ll build
- A parent Terraform configuration that calls local modules.
- Three local modules: vpc, subnet, and ec2.
- Data flow that passes outputs from one module into another (e.g., VPC ID -> Subnet -> EC2).

### Directory and file layout
Create a top-level Terraform directory (this is the parent module). Inside it add common files and a modules subdirectory with three child modules.

| Location | Recommended files |
| --- | --- |
| Top-level (parent) | main.tf, variables.tf, outputs.tf, providers.tf |
| modules/vpc | main.tf, variables.tf, outputs.tf |
| modules/subnet | main.tf, variables.tf, outputs.tf |
| modules/ec2 | main.tf, variables.tf, outputs.tf |

Below are cleaned-up module implementations and the parent configuration examples. Keep these modules focused and parameterized so they are reusable across accounts and environments.

### VPC module
This module creates a VPC and exposes its ID as an output.

modules/vpc/main.tf
```terraform
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}
```

modules/vpc/variables.tf
```terraform
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-cool-vpc-for-modules"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
```

modules/vpc/outputs.tf
```terraform
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}
```

### Subnet module
This module provisions a subnet and the supporting network resources: an Internet Gateway, a route table, and a route table association. It accepts a vpc_id input and returns the subnet_id.

modules/subnet/main.tf
```terraform
resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.subnet_name}-igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.subnet_name}-rt"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}
```

modules/subnet/variables.tf
```terraform
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "demo-subnet"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "us-east-1a"
}
```

modules/subnet/outputs.tf
```terraform
output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.subnet.id
}
```

### EC2 module
This module creates a security group and an EC2 instance. Inputs include VPC and subnet IDs plus AMI, instance type, and an instance name. Outputs include the instance ID and public IP.

modules/ec2/main.tf
```terraform
resource "aws_security_group" "sg" {
  name        = "allow-ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_instance" "instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}
```

modules/ec2/variables.tf
```terraform
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # example Amazon Linux 2 AMI in us-east-1
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "my-instance"
}
```

modules/ec2/outputs.tf
```terraform
output "instance_id" {
  description = "The ID of the instance"
  value       = aws_instance.instance.id
}

output "public_ip" {
  description = "The public IP address of the instance"
  value       = aws_instance.instance.public_ip
}
```

### Parent configuration
The parent module declares the AWS provider and calls the child modules. Note how we wire outputs into module inputs.

providers.tf (parent)
```terraform
provider "aws" {
  region = "us-east-1"
}
```

main.tf (parent) — module blocks
```terraform
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "demo-vpc"
}

module "subnet_module" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.vpc_id
  subnet_cidr       = "10.0.1.0/24"
  subnet_name       = "demo-subnet"
  availability_zone = "us-east-1a"
}

module "prod-workload" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.subnet_module.subnet_id
  ami_id        = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  instance_name = "bryans-web-server"
}
```

### Tooling and basic workflow
After you add or change modules, follow this basic workflow.
1. Initialize the working directory (downloads providers and registers modules)
```bash
$ terraform init
Initializing the backend...
Initializing modules...
- vpc in modules/vpc
- subnet_module in modules/subnet
- prod-workload in modules/ec2
Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v5.89.0...
```

2. Format your files
```bash
$ terraform fmt
```

3. Create and review a plan, then apply
```bash
$ terraform plan
Plan: X to add, 0 to change, 0 to destroy.
```

Example of a planned resource created by a child module:
```bash
# module.vpc.aws_vpc.vpc will be created
resource "aws_vpc" "vpc" {
  + arn                        = (known after apply)
  + cidr_block                 = "10.0.0.0/16"
  + default_network_acl_id     = (known after apply)
  + default_route_table_id     = (known after apply)
  + default_security_group_id  = (known after apply)
  ...
}
```

### (Skip) Notes and best practices

### (Skip) Summary


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