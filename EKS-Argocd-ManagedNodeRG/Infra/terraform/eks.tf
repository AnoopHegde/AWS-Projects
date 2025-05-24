##########################################################
# EKS Cluster with Managed Node Groups
##########################################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.36.0"

  cluster_name    = "pe-eks-east1-npd"
  cluster_version = "1.32"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    example = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.small"]

      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }

  tags = {
    Environment = "Dev"
    Terraform   = "true"
  }
}
