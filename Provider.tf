terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

provider "http" {}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
