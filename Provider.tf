provider "aws" {
  region                  = var.region
  shared_credentials_file = "C:/Users/CyberGOD/.aws/credentials"
  version = ">= 2.38.0"
}

data "aws_region" "current" {}

data "aws_availability_zones" "available" {}

provider "http" {}
provider "kubernetes" {}