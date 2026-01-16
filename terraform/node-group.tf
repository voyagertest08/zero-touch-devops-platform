resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "nodes"
  node_role_arn  = aws_iam_role.eks.arn
  subnet_ids     = aws_subnet.public[*].id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}
