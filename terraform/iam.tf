resource "aws_iam_role" "eks" {
  name = "eks-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "eks.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}
