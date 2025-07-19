#Create an IAM role for the EKS cluster.
resource "aws_iam_role" "cluster" {
  name = "${var.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.cluster_name}-role"
  }
}

# Attach the cluster policy to the EKS cluster IAM role
resource "aws_iam_role_policy_attachment" "cluster_policy" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


# Create an Amazon Elastic Kubernetes Service (EKS) cluster.
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]
}

# -----------------------------------------------------------------------------
# Create an IAM role for the EKS worker nodes.
resource "aws_iam_role" "node" {
  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the worker node policies to the EKS worker node IAM role
resource "aws_iam_role_policy_attachment" "node_policy" {
  for_each = toset(([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]))
  policy_arn = each.value
  role       = aws_iam_role.node.name

}

# Create an EKS node group
resource "aws_eks_node_group" "main" {
  for_each = var.node_group_name

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.key
  subnet_ids      = var.subnet_ids
  node_role_arn   = aws_iam_role.node.arn

  capacity_type  = each.value.capacity_type
  instance_types = each.value.instance_types

  scaling_config {
    min_size     = each.value.scaling_config.min_size
    max_size     = each.value.scaling_config.max_size
    desired_size = each.value.scaling_config.desired_size
  }


  depends_on = [aws_iam_role_policy_attachment.node_policy]
}
