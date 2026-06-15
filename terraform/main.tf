# LocalStack code
# https://www.youtube.com/watch?v=_PD4j5Ra3kY

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

provider "aws" {
    region = "us-east-1"
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_requesting_account_id = true

    endpoints {
      // localhost:4566 for floci
      ec2 = "http://localhost:4566"
    }

}

resource "aws_instance" "web-server" {
    // How do I know the ami value is correct?
    // ami - (Optional) AMI to use for the instance. Required unless launch_template is specified and the Launch Template specifes an AMI. If an AMI is specified in the Launch Template, setting ami will override the AMI specified in the Launch Template.
    // ami = "ami-06ca3ca175f37dd66"
    
    // How do I know the instance_type value is correct?
    // instance_type - (Optional) Instance type to use for the instance. Required unless launch_template is specified and the Launch Template specifies an instance type. If an instance type is specified in the Launch Template, setting instance_type will override the instance type specified in the Launch Template. Updates to this field will trigger a stop/start of the EC2 instance.
    instance_type = "t2.micro"
    
    count = 1
    tags = {
        Name = "web-server-${count.index}"
    }
}