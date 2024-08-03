provider "aws" {
  region = var.region
}
provider "kubernetes" {
  host                   = data.aws_eks_cluster.Xpert-eks-cluster.endpoint
  token                  = data.aws_eks_cluster_auth.Xpert-eks-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.Xpert-eks-cluster.certificate_authority[0].data)
}

data "aws_eks_cluster" "Xpert-eks-cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "Xpert-eks-cluster" {
  name = module.eks.cluster_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.20.0"

  cluster_endpoint_public_access = true
  cluster_name                   = "Xpert-eks-cluster"
  cluster_version                = "1.30"

  subnet_ids = module.EKS-vpc.private_subnets
  vpc_id     = module.EKS-vpc.vpc_id

  tags = {
    environment = "development"
    application = "test"
  }

  eks_managed_node_groups = {
    nodepool = {
      instance_types = ["t2.micro"]
      name           = "nodepool1"
      min_size       = 0
      max_size       = 2
      desired_size   = 1
      capacity_type  = "SPOT"
      labels = {
        env  = "test"
        type = "t2.micro"
      }

      tags = {
        environment = "development"
        application = "test"
      }
    },
    nodepool2 = {
      instance_types = ["t2.small"]
      name           = "nodepool2"
      min_size       = 0
      max_size       = 2
      desired_size   = 0
      capacity_type  = "SPOT"
      taints = {
        dedicated = {
          key    = "dedicated"
          value  = "on-demand"
          effect = "NO_SCHEDULE"
        }
      }
      labels = {
        env  = "test"
        type = "t2.small"
      }

      tags = {
        environment = "development"
        application = "test"
      }
    }
  }
}



#   worker_groups = [
#     {
#       name          = nodepool1
#       instance_type = ["t2.micro"]
#       min_size      = 0
#       max_size      = 2
#       desired_size  = 1
#     },
#     {
#       name          = nodepool1
#       instance_type = ["t2.small"]
#       min_size      = 0
#       max_size      = 2
#       desired_size  = 1
#     },
#   ]


