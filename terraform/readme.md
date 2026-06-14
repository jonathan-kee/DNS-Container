# Terraform installation
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
4) aws --endpoint-url=http://localhost:4566 ec2 describe-instances
5) terraform destroy --auto-approve

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