module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-cluster"
  cluster_version = "1.21"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets
#  cluster_role_arn = "arn:aws:iam::725526989454:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS"


  eks_managed_node_groups = {
    eks_nodes = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2_x86_64"
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 3
      desired_size = 2
#      iam_role_arn = "arn:aws:iam::725526989454:role/aws-service-role/eks-nodegroup.amazonaws.com/LabRole"
    }
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Para Amazon Linux 2 (x86_64)
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]  # AWS account ID para Amazon Linux
}

