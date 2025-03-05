module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"

 cluster_name    = "trf-eks-k8-cluster"
  cluster_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

enable_irsa = true
  # Optional
  cluster_endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true
    eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t3.medium"]
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  eks_managed_node_groups = {

    node_group = {
      min_size     = 2
      max_size     = 6
      desired_size = 2
    }
    }



  tags = {
    cluster = "demo"
    Environment = "dev"
    Terraform   = "true"
  }
}
