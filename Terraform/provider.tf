###############################################################################
########################## VERSIONES Y PROVUIDER ##############################
###############################################################################

# Versión de Terraform
terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Provider AWS
provider "aws" {
  region = "us-east-1"
}