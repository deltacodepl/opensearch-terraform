provider "aws" {
  default_tags {
    tags = {
      ManagedBy = "Terraform"
    }
  }
}

data "aws_region" "current" {}

data "aws_route53_zone" "opensearch" {
  name = "segregatory.eu"
}

provider "elasticsearch" {
  url         = module.opensearch.cluster_endpoint
  aws_region  = data.aws_region.current.name
  healthcheck = false
}

module "opensearch" {
  source = "../../"

  cluster_name    = var.cluster_name
  cluster_domain  = "oaktest"
  cluster_version = "2.3"
  master_instance_enabled=false
  master_instance_type = var.master_instance_type
  hot_instance_type = var.hot_instance_type
  master_instance_count=1
  hot_instance_count=1
  warm_instance_enabled=false
  warm_instance_type=var.warm_instance_type
  warm_instance_count=var.warm_instance_count
  availability_zones=1
  master_user_arn=""


  saml_enabled = false
}
