resource "aws_eks_cluster" "team2_cluster_2" {
  name     = var.cluster_name
  role_arn = aws_iam_role.team2_eks_role_2.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.team2_public_subnet_2.id,
      aws_subnet.team2_private_subnet_2.id,
    ]
    security_group_ids = [aws_security_group.eks_control_plane_sg_2.id]
  }

  tags = {
    Name = "team2_cluster_2"
     
  }
}

resource "aws_iam_role" "team2_eks_role_2" {
  name = "team2-eks-role-2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "team2-eks-role-2"
  }
}

resource "aws_security_group" "eks_control_plane_sg_2" {
  name        = "t2_eks_control_plane_sg_2"
  description = "Security group for EKS control plane"
  vpc_id      = aws_vpc.team2_vpc_2.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "t2_eks_control_plane_sg_2"
  }
}


resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.team2_eks_role_2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  role       = aws_iam_role.team2_eks_role_2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.team2_eks_role_2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr_read_only_policy" {
  role       = aws_iam_role.team2_eks_role_2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "team2_vpc_policy_attachment" {
  role       = aws_iam_role.team2_eks_role_2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role_policy_attachment" "eks_admin_access_policy_" {
  role       = aws_iam_role.team2_eks_role_2.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}