provider "aws" {
    region = var.region
    
  assume_role {
    role_arn = var.target_role
  }
}
terraform {
  backend "s3" {
    bucket = "yossik-budget-configs-artifacts"
    key    = "yossik-budget-config/terraform.tfstate"
    region = "il-central-1"
  }
  
}
