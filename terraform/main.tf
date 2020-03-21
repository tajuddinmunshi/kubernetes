provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "tf-state-blog3"
    key    = "dev/terraform3"
    region = "eu-west-2"
  }
}

locals {
  azs                    = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  environment            = "dev"
  kops_state_bucket_name = "${local.environment}-kopsvvvvv"
  // Needs to be a FQDN
  kubernetes_cluster_name = "tajuddinmunshi.com"
  ingress_ips             = ["10.0.0.100/32", "10.0.0.101/32"]
  vpc_name                = "${local.environment}-vpc"

  tags = {
    environment = "${local.environment}"
    terraform   = true
  }
}

data "aws_region" "current" {}
