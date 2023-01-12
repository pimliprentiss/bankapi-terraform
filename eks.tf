module "eks_blueprints" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints"


  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  managed_node_groups = {
    mg_5 = {
      node_group_name = "managed-ondemand"
      instance_types  = ["t3.medium"]
      min_size        = 1
      desired_size    = 1
      max_size        = 3

    }
  }
}

resource "kubernetes_namespace" "api_namespace" {
  metadata {
    annotations = {
      managed_by = "terraform"
    }

    name = var.namespace
  }
}


resource "kubernetes_secret" "api_secret" {
  metadata {
    name      = var.secret
    namespace = var.namespace
  }

  data = {
    api_key    = data.aws_ssm_parameter.api_key.value
    secret_key = data.aws_ssm_parameter.secret_key.value
  }

  depends_on = [
    kubernetes_namespace.api_namespace
  ]

}

module "kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons"

  eks_cluster_id       = module.eks_blueprints.eks_cluster_id
  eks_cluster_endpoint = module.eks_blueprints.eks_cluster_endpoint
  eks_cluster_version  = module.eks_blueprints.eks_cluster_version


  enable_amazon_eks_vpc_cni    = true
  enable_amazon_eks_coredns    = true
  enable_amazon_eks_kube_proxy = true
  enable_cluster_autoscaler    = true
  enable_argocd                = true
  enable_cert_manager          = true
  enable_ingress_nginx         = true

  argocd_applications = {
    workloads = {
      path               = "."
      repo_url           = "https://github.com/pimliprentiss/bankapi-argo-registry"
      add_on_application = false
    }
  }



}

