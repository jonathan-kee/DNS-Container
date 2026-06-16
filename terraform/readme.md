# Terraform installation
Link to documentation:
https://developer.hashicorp.com/terraform/install#darwin

For Mac installation:
- brew tap hashicorp/tap
- brew install hashicorp/tap/terraform
- terraform version

# Steps to setup 
Link to documentation:
https://floci.io/floci/getting-started/quick-start/

1) cd terraform
2) docker compose up -d
3) terraform apply --auto-approve

^
Missing terraform init step

4) aws --endpoint-url=http://localhost:4566 ec2 describe-instances

^
I do not awscli installed

5) terraform destroy --auto-approve

# Project Setup
1) cd terraform
2) docker compose up -d
3) terraform init 
4) Run the below commands in terminal:
export AWS_ENDPOINT_URL=http://localhost:4566
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
5) terraform plan
6) terraform apply --auto-approve
7) terraform destroy --auto-approve

## Workflow
1) Write (Develop Your Terraform Configuration Files)

2) Init (Download Providers and Modules)

- terraform init #(Initialize working directory)

3) Plan (Preview Changes Before Modifying Real-World Resources)

- terraform plan #(Preview execution plan)

4) Apply (Execute Changes to Your Infrastructure)

- terraform apply #(Apply changes to infrastructure)

5) Destroy (Tear Down All Managed Resources)

- terraform destroy #(Destroy managed resources)

## Workflow 2.0
1. terraform init — set up the directory and backend.
2. terraform validate and terraform fmt — ensure configuration quality.
3. terraform plan -out=plan.tfplan — generate a reviewable plan.
4. Review the plan carefully, then terraform apply plan.tfplan — apply changes.
5. Use terraform output to retrieve values and terraform state to inspect state as needed.
6. When decommissioning resources, use terraform destroy with caution.