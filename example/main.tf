provider "aws" {
  region = "REPLACE_ME"
}

module "eks_cluster" {
  source = "../"

  name                       = "REPLACE_ME"
  root_domain                = "REPLACE_ME"
  sub_domain                 = "REPLACE_ME"
  allowed_access_cidr_blocks = ["REPLACE_ME/32"]
  kubernetes_version         = "1.21"
  aws_profile                = "default"
}

output "autoscaling_groups" {
  value = module.eks_cluster.autoscaling_group_names
}

output "efs_id" {
  value = module.eks_cluster.efs_id
}

output "s3_buckets" {
  value = module.eks_cluster.s3_buckets
}
