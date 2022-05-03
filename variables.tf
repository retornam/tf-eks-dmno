variable "cidr_block" {
  description = "CIDR BLOCK for the cluster"
  default     = "10.0.0.0/16"
}

variable "name" {
  type        = string
  description = "name of the cluster"
  default     = "test-eks-cluster"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support for VPC"
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS Hostnames"
  default     = true
}


variable "allowed_access_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed HTTP(s) access to the cluster's domain name."
  default     = ["0.0.0.0/0"]
}

variable "autoscaling_groups" {
  description = "configuration settings for the default autoscaling groups"
  type = map(object({
    instance_type    = string,
    min_size         = number,
    max_size         = number,
    desired_capacity = number
  }))
  default = {
    platform = {
      instance_type    = "m5.2xlarge",
      min_size         = 0
      max_size         = 1
      desired_capacity = 1
    },
    compute = {
      instance_type    = "m5.2xlarge",
      min_size         = 0
      max_size         = 10
      desired_capacity = 0
    },
    gpu = {
      instance_type    = "p3.2xlarge",
      min_size         = 0
      max_size         = 1
      desired_capacity = 0
    }
  }
}

variable "amis" {
  description = "the EKS AMIs to use"
  type = map(object({
    name   = string
    owners = list(string)
  }))

  default = {
    eks = {
      name   = "amazon-eks-node-%s-v*"
      owners = ["602401143452"]
    }
    eks_gpu = {
      name   = "amazon-eks-gpu-node-%s-v*"
      owners = ["602401143452"]
    }
  }
}

variable "kubeconfig_output_path" {
  description = "path to save kubeconfig file"
  default     = ""
}

variable "kubernetes_version" {
  type        = string
  description = "Desired Kubernetes version"
  default     = "1.21"
}


variable "private_subnet_count" {
  default     = 3
  description = "total number of private subnets"
}

variable "public_subnet_count" {
  default     = 3
  description = "total number of public subnets"
}

variable "root_domain" {
  type        = string
  description = "describe your variable"
}

variable "sub_domain" {
  type        = string
  description = "subdomain for cluster"
}


variable "tigeraoperator_version" {
  default     = "v3.21.4"
  description = "Operator for Tigera Calico"
}

variable "force_destroy" {
  type        = bool
  description = "force destroy S3 buckets"
  default     = true
}

variable "aws_profile" {
  type        = string
  default     = "default"
  description = "the aws_profile to use for the generated kubeconfig"

}
