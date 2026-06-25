# Resources to learn
A free, open-source local AWS emulator.
https://github.com/floci-io/floci
^
Try to make it work with terraform code below:
https://github.com/floci-io/floci/blob/main/compatibility-tests/compat-terraform/main.tf

Andrian Cantril's AWS solutions architect cert notes:
https://github.com/jonathan-kee/aws-certified-solutions-architect-cantrill-notes/blob/main/MAIN-notes-SAA-C03.txt

AWS IAM for Terraform:
https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-account

# High level overview of AWS CLI
## DEMO Creating Access Keys and Setting Up AWS CLI v2 Tools

Once logged in with Admin user:
IAM Dropdown > Security Credentials > scroll down to "Create Access Key", click > Command Line Interface (CLI) > check box at bottom > Next > Set Decription Tag > "Create Access Key"

Once Access Key is created, you can use Actions dropdown to Deactivate, Activate, and Delete. If you ever lose access to a key, you need to deactivate & delete it, then create a new one.

### Download AWS CLI v2 
AWS CLI v2 (Windows) Installation - https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html

AWS CLI v2 (macOS) Installation - https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html

AWS CLI v2 (Linux) Installation - https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html

### Configure CLI
Configure a set of credentials which CLI will use to communicate with AWS. We will use the General IAMADMIN user for this one.

COMMAND: 'aws configure': configures default profile for CLI
COMMAND: 'aws configure --profile iamadmin-general' / 'aws configure --profile iamadmin-production': named profile for CLI

Upon entering the above Command:
- AWS Access Key ID
- AWS Secret Key
- Default Region Name: us-east-1
- Default output format (press Enter with blank field for default)

Test that this is successful with COMMAND 'aws s3 ls --profile [CLI profile name]'. This will error first as we need to specify named profile:
'aws s3 ls --profile iamadmin-general', which will currently return a blank string as there are no s3 buckets.

#### Configure for Production
COMMAND: 'aws configure --profile iamadmin-production'
COMMAND to test: 'aws s3 ls --profile iamadmin-production'

SECURITY REMINDER: Never share your SECRET KEY. If leaked, delete and create new set of keys and re-configure in CLI

TIP: If after you Configure CLI with credentials, you can delete the credential files (CSVs)

# High level Overview of Lambda
## Serverless Architecture
The Serverless architecture is a evolution/combination of other popular architectures such as event-driven and microservices.
- Aims to use 3rd party services where possible and FAAS products for any on-demand computing needs.
- Using a serverless architecture means little to no base costs for an environment - and any cost incurred during operations scale in a way with matches the incoming load

### Serverless - Key Concepts
- Serverless isn't one single thing; aiming to manage few, if any, servers for lower overhead
- Stateless and Ephemeral env's; duration billing
- Function as a Service; FaaS used where possible for Compute functionality
- Managed Services are used where possible; web Id providers, S3 for storage, etc.
- Event-driven; consumption only when being used

### Serverless: TL;DR and Architecture
Aim should be to consume as a service whatever you can, code as little as possible, use function as a service for any general compute needs

### Lambda
- FaaS: Function as a Service - short running and focused
- Lambda function: piece of code that lambda runs
- Functions use a runtime like Python 3.8
- Functions loaded into a runtime environment; env has a direct memory (indirect CPU) allocation
- Billing: for the duration that the function runs
- Lambda is a key part of Serverless architectures
- Lambda Function: Think of it as the code + association wrappings/config; a deploment package. Stateless
- You define Lambda resources like Memory (128MB -> 10240MB in 1MB steps), which then scales how much CPU you'll get (you can't directly control how much CPU). Storage in Lambda stored in /tmp 512MB -> 10240MB

EXAM: Lambda function timeout 900s (15 minutes). Anything beyond 15 mins can't use Lambda directly

# High level overview of DynamoDB
# NOSQL Databases & DynamoDB
## DynamoDB - Architecture
DynamoDB is a NoSQL fully managed Database-as-a-Service (DBaaS) product available within AWS. This is the traditional serverless DB route in AWS
- uses Key/Value &/or Document data. "Wide column DB"
- no self-managed servers or infrastructure
- Highly resilient and can be optionally Globally resilient
- Single digit millisecond speeds -- SSD based
- manual or auto scaling or on-demand (set and forget)
- RCU - read capacity units, WCU - write capacity units

# High level overview of S3
### S3 Basics: Simple Storage Service
Global Storage Platform - regional based/resilient. Access from anywhere.
- Public service, can cope with unlimited data & multi-users
- Perfect for hosting large amounts of data
- Economical and accessed via UI/CLI/API/HTTP

#### S3 Delivers 2 things: Objects and Buckets

##### S3 Objects
What is an Object? An object is a file and any optional metadata that describes the file.

Two components and some associated metadata: 
1. Object Key. identifies object in a bucket
2. Value. data or contents of the object. Object size can range from 0 bytes to 5 terabytes (TB) in size.
Metadata: Version ID, Metadata, access control, subresources

NOTE: S3 = Default Storage Service in AWS

##### S3 Buckets (Simple Storage Service)
Containers created in a specific AWS region; default place to go to in order to configure S3
- Data inside a bucket has a primary home region. Never leaves this region unless configured to do so
- Blast radius of a failure is limited to a region
- Buckets can hold an unlimited number of objects; infinitely scalable
- S3 bucket has no complex structure; flat-structure; everything stored at same level; all stored at Root level (if you list out on Command, it'll look like there are folders, but there aren't Eg. /old/photo1.jpg). Folders are called 'prefixes' in S3.

## S3 Static Hosting
Accessing S3 is generally done via APIs. Static Website Hosting is a feature of the product which lets you define a HTTP endpoint, set index and error documents and use S3 like a website.
 - S3 Static Hosting allows access to s3 via HTTP - Eg. Blogs
 - Usage (2 Documents required): First enable, and in doing so, you have to set INDEX and ERROR documents
 - Index page is entry point to most websites
 - Error Document: When you access a page that isn't there, or other type of service side error that's when Error Doc is shown
 -- Index and Error docs need to be html documents as s3 Static Hosting reads HTML files
 - When Static Hosting is enabled, a static website hosting endpoint is created. Name of endpoint is based on bucket name and region
 -- Want a custom Domain? (via R53)... if so, bucket name matters. Name of Bucket MUST match domain name
 --- Eg. Want a site called top10.animals4life.org? Name your bucket "top10.animals4life.org"
 
 ### S3 Static Hosting: What else is S3 Static Hosting Good for (other than hosting static websites?
 - Example 1: Offloading. If you have a site with lots of images hosted by compute service, you can offload the media to an S3 bucket w/ static hosting to save money (compute is usually pricier). Offload large data to S3.
 - Example 2: Out-of-band pages. In IT, this means method of accessing something outside of the main way. Example: You want to perform server maintenance and the server needs to go down. You can put an "Under Construction" static page in S3 to put up when production server is down.
 
 ## S3 Pricing
 Pricing for S3 forms of a number of major components:
 - Cost to Store Data: per gigabyte per month charge
 - Data Transfer Free: for every Gb of data transferred out of S3, per gigabyte charge
 - Data Requests: GET, POST, list, port. Cost per 1,000 operations
 
### S3: What's FREE?
 - 5Gb monthly storage
 - 20,000 GET requests
 - 2,000 PUT requests
 
## DEMO Creating a Static Website with S3
 1. Create S3 Bucket > bucket name "[custom-globally-unique]" > uncheck "Block All Public Access" and acknowledge > Create Bucket
 2. Enable Static Website Hosting > access new bucket > Properties tab > scroll to bottom, Edit Static Website Hosting, Enable > Hosting Type: Static > Index Document "index.html" > Error Document "error.html" > In properties, scroll down and copy new static URL
 3. Upload some Objects to the bucket > Objects tab, "Upload" > Upload index.html, error.html, and "img" folder
 4. Paste copied URL into browser
 - You'll get a 403 Forbidden error (Access Denied) - Remember, S3 buckets are private by Default. We need to add permissions for anonymous/public users to visit site (no method to provide creds to S3)
 5. Give Permissions to un-authenticated uses to acess bucket > Access S3 bucket > Permissions tab > Bucket Policy > Edit > Grab JSON from .zip > Paste in, but replace the "Resource" value BEFORE the "/*" (mine now looks like "Resource":["arn:aws:s3:::top10catsever876.com/*"]) > Save
 6. You can now visit your website
 Extra: If you Registered a domain in R53, you can customize your URL. R53 > Hosted Zones > access your domain > Create Record > select Simple Routing > Record Name Eg. "top10".animals4life.io > choose Endpoint "Alias to S3 website endpoint" > Region: us-east-1 > S3 endpoint, select your bucket > click "Define simple record" > Create Records. Now Cantrill can go to top10.animals4life.io. Remember: Domain name and bucket name must match exactly to do this
 7. Clean Up: Empty bucket, delete bucket

# High level overview of VPC
### AWS Default Virtual Private Cloud (VPC)
A Virtual Network inside AWS. VPCs are regional services; regionally resilient. They operate from multiple AZ's in a region. 
- A VPC is 1 account and 1 region, cann't be spread across multiple accounts/regions
- Private and isolated unless configured otherwise
- Default VPC (max 1 per region, pre-configured) and Custom VPCs (can have many)
- Can be used to connect AWS private networks to on-premise network. Or connecting during multi-cloud deployments

EXAM: VPCs are REGIONALLY resilient

#### Default VPC
There can only be one default VPC per region, and they can be deleted and recreated from the console UI. Unless configured otherwise, VPC is entirely private/isolated. 
- VPC CIDR: Start and end range of IP addresses VPC can use. If anything needs (and is allowed to) communicate with VPC, it needs to communicate to the VPC CIDR
- Default VPC only gets 1 CIDR IP range. Can't change it.
- Default VPC provides Internet Gateway (IGW), Security Group, and NACL
- VPC can be subdivided into subnetworks. Each subnet in VPC is located in one AZ. Default VPC has one subnet in each AZ by default
-- Each subnet uses part of the VPC CIDR range
-- Default VPC CIDR: always 172.31.0.0/16
-- Assigns public IPv4 addresses
--- /20 subnet in each AZ in the region. The higher the /#, the smaller the network. /17 is half the size of /16

QUIZ: How many subnets are in a default VPC? Default VPCs always have the same IP range and same '1 subnet per AZ' architecture. # Subnets = # AZ's in region

EXAM: Default VPC CIDR IP? 172.31.0.0/16

##### Default VPC - Create / Delete

To Locate: AWS Dashboard > Search "VPC" > Your VPCs

To Delete: check Default VPC > actions dropdown "Delete" > follow prompt

To Create Default VPC: If you've deleted Default VPC. In Your VPCs > Actions dropdown > Create Default VPC
