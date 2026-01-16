resource "aws_eks_cluster" "cluster" {
  name     = "zero-touch-cluster"
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    subnet_ids = aws_subnet.public[*].id
  }
}
