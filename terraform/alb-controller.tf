# -----------------------------
# Service Account for ALB Controller (IRSA)
# -----------------------------
resource "kubernetes_service_account_v1" "alb_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.alb_controller.arn
    }
  }
}

# -----------------------------
# AWS Load Balancer Controller (Helm)
# -----------------------------
resource "helm_release" "alb_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.7.1"
  namespace  = "kube-system"

  timeout         = 600
  wait            = true
  atomic          = true
  cleanup_on_fail = true
  reuse_values    = true

  set = [
    {
      name  = "clusterName"
      value = aws_eks_cluster.cluster.name
    },
    {
      name  = "region"
      value = "ap-south-1"
    },
    {
      name  = "awsVpcId"
      value = aws_vpc.main.id
    },
    {
      name  = "serviceAccount.create"
      value = "false"
    },
    {
      name  = "serviceAccount.name"
      value = kubernetes_service_account_v1.alb_controller.metadata[0].name
    }
  ]

  depends_on = [
    aws_eks_node_group.nodes,
    aws_iam_openid_connect_provider.eks,
    aws_iam_role_policy_attachment.alb_attach,
    kubernetes_service_account_v1.alb_controller
  ]

  lifecycle {
    prevent_destroy = true
  }
}

